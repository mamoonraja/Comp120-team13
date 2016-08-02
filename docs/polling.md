#Leg 6: Polling and dynamic caching


###Polling

After much trail and and error, we eventually decided to go with the naive method of using javascript to retrieve and show new incidents.  

The reason behind this decision was simply the difficulty we had integrating an alternative methods of websockets/socket.IO with our rails app (and I believe many other teams ran into similar problems).  Although there are issues with this, such as not every browser supports sockets, the main benefit of the websockets method as we saw it was that there was no constant pinging of our server, and if we had more time in the future we would like to tinker with it a bit more.  In the end we could not get it to properly integrate with our asset pipeline and play nicely with our datatables gem.  

The naive method we are using definately has a few downsides.  First, a user can modify the javascript to send queries to our server say every millisecond.  Second, it is somewhat inflexible in that it will continue polling even if a user is inactive or they don't want to see incidents.  Third, there is unconstrained pinging of our server that doesn't scale very will with many users.  That being said, the benefit is that it is straightforward. 

We use a gem called datatables that is very handy for displaying incidents.  It provides pagination, sorting of all columns ascending or descending, search, and some other stylings.  Therefore much of our work in javascript (besides learning the language for some of us) went in to interacting with this gem and its API.

The first thing we did was set the default sorting priority of our datatables to date (descending) then time (descending) upon intialization:  

    $("#datatable").DataTable({
      "order": [[5, "desc"], [6, "desc"]],
    });

This first means that new incidents will appear at the top of the table ( since they are displayed in order ) and second that 
the first time a user sees our incident index page it will display newest first. 

We then wrote a javascript function in a file called polling.js whose purpose was to use our get incidents endpoint via our api to query our server for our incidents.  It then compares the number of incidents it gets back to the number in the table.  If there are more than the number in our table we know a new one has been added, and we insert a new row into our table (note that we have to account for the heading row with the way the gem works.  This javascript function is done with set timeout, so that it will wait till the ajax is finished loading before querying again.  Also we decided to poll every minute to reduce the stress on our servers (as opposed to say 10 or 30 seconds):

    setTimeout(function async() {
      $.get("/api/v1/incidents", function(data) {
        var len = data.incidents.length;
        var diff = len + 1 - $('.table__row').length;
        for(var i = 0; i < diff; i++)
          self.addNewIncident(data.incidents[len - 1 - i]);
      });
      setTimeout(async, 60000);
    }, 60000);


we then redraw the table to update the incidents in so that our user can see the new ones.  Note that this redrawing is not a refresh of the page of any sort, and to the user it appears as if a new incident has simply appeared at the top.  

###Images

Compressing images was fairly straightforward.  We simply added a column to our datatable for the thumbnail and used a gem called miniMagick to compress our images into thumbnails.  We chose miniMagick because of the support with CarrierWave which we are using for our images.  Adding compression was as simple as including miniMagic in our mediauploader file and adding code to create a new version of our media content:

       version :thumb do
         process :resize_to_fit => [50, 50]
       end

We can then call in the new column of our table to see the thumbnails.

    <img src="<%= incident.media.thumb.url %>"/> 
    


###Caching

We decided to go with memcachier and dalli to cache our dynamic content (incidents).  We chose this option over a newer one such as redis.  Now a lot of our research argued that the newest version of redis is superior in most ways: redis has more data types, support selective deleting of cache content, and very good performance overall.  The newer version of redis also support clustering, which was memcaches main advantage.  

However, for our purposes there were two big advantages of memcache: First memcache is sort of the tried and true method.  We don't need a lot of the extra features redis has for our basic application, and the foundation of memcache is proven to work well.  Second, there is a lot of documentation on it and community support around it, especially in conjunction with heroku. We were even able to find an to date tutorial for rails 4 with heroku.  

Once we had made our decision and found a good resource, implementing the caching was fairly straightforward. We installed the dali gem and then set our production environment in our config folder as follows:

              config.cache_store = :dalli_store,
                      (ENV["MEMCACHIER_SERVERS"] || "").split(","),
                      {:username => ENV["MEMCACHIER_USERNAME"],
                       :password => ENV["MEMCACHIER_PASSWORD"],
                       :failover => true,
                       :socket_timeout => 1.5,
                       :socket_failure_delay => 0.2
                      }

###Looking ahead

We currently have one bug we are still working on: it has to do with our datatables gem when we are polling new incidents.  the time the incident is submitted is currently incorrect for a polled incident, and it sometimes causes the incedent to show up at the bottom instead of the top.  We should have this fixed soon.

As mentioned before we would have liked to get websockets or sockets.io working, but it was tricky.  Our naive way works for a low volume of (not ill-intentioned) users.  Ideally we would like to take some preventative measures such as, since we have user log in implemented, limit the amount of queries from an individual users.  We ideally would have a rate limiting system such as was discussed in class no just because of this polling system, but for users accessing our API in general.  We do feel for this leg our method works ok.


