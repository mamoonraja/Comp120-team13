# Static Content Performance Report

### Tools Used
Yslow, Pagespeed Tools

The suggestions these two tools gave us had the least amount of overlap, so therefore we felt that together they provided a good general measurement of our optimizations

### Initial state of the site
These are the results for the incidents timeline/table page. The other pages were all as good or better.

When using Yslow, our site actually recieved an A as the original score, although it was the lowest A possible (90).  There were 4 change suggestions that we did not get an A on.
* F - use a CDN
* F - expires headers
* B - compress components with gzip
* C - use cookie-free domain

When running Pagespeed at the beginning we recieved an 86% for desktop.  There were 4 suggestions
* render browser caching
* remove blocking JS
* enable compression with gzip
* minify javascript


### Discussion of Changes
The first change we made was to compress components with gzip.  After some research about rails asset pipeline, we found that doing this was as simple as adding "use Rack::Deflater" to our config file.  This solved the issue for both of our tools.

The next big change we made was setting up a CDN to serve our static content.  This process took the most time.  We decided to use S3 buckets in AWS to store our static content/images.  The main reason we decided to use S3 was our research showed that while s3 is a bit slower than some cdns such as Cloudfront, it has better storage and bandwidth costs, which is something we felt we wanted to prioritize.  Implementing this brought our CDN grade on Yslow up to an A.

We tried quite a few things to resolve the remove blocking JS suggestions from Pagespeed. First we moved javascript to the bottom of the page. We also minified our js using the uglifier gem.  Yslow is picking up the minification/uglification but pagespeed is not for some reason.  When we directly access the file that is loaded on the site, it is clearly minified except for comments, so we feel there must be something uglifier is not doing that pagespeed is picking up but yslow isn't.  For our purposes we think this is ok. Unfortunately neither solved the blocking JS warning from pageslow.  We also tried to use the 'async' tag for our scripts to solve this but still with no success.

The next change we made was to add expires headers and caching.  The way we did this was to add "config.static_cache_control = "public, max-age=31536000"" to our application.rb file in config.  This adds a far future expiring header to our files (I believe it is 10 years).  This solved the cacheing issue in pagespeed.  However we found that this did not help for the datatables gem we used to style our table with sorting, pagination, search, etc.  Because these files were unaffected, we were still receiving an F for the expires headers grade in Yslow.  

We spent a lot of time trying to deal with this datatables issue, but we found it very tricky to handle the datatables gem.  Eventually the best idea we had to fix this was to instead of using datatables as a gem, reference the stylesheets and js files for the plug in externally since we found ones that were already on a public CDN.  This method solved our expiration problems with the plug in on Yslow, upgrading that to an A, but it caused additional ones as well - the tags of some of the images in the CDN were not configured correctly and this fell to a C.  Since this was lower on the list it resulted in an increase in performance, but it is another issue we still would like to solve.  This method also caused an issue in pagespeed - these external sheets were considered render-blocking CSS and it wanted them to be elimated.

### Final Results
Once again these results are on the the incidents timeline page, since all other pages scored at least as well

When running Yslow our performance increased from A(90) to to A(99), which we are quite happy with.  The places where performance can be improved are
* C configure entity tags
* D use cookie free domains

The first is related to the Datatables CDN image tags as mentioned earlier.   As for using cookie free domains, spent a lot of time configuring s3 for static content and images and hoped that we would be able to take care of it along the way, but unfortunately it has not yet been resolved.  Currently we are still working this one.

When running pagespeed our performance increesed from 86% to 89%. The main reason this speed up isn't as much was due to to the render-blocking js/css that was added to by using the cdn version of datatables.  Also as mentioned earlier Pagespeed also did not pick up our minification of our js files, although we manually confirmed it was happening and Yslow agrees.

In conclusion we were able to solve almost everything except a few problems relating to the datatables gem and the cookie free domain.  Our current plan is to spend a bit more time working with Datatables and researching the cookie free domains. We feel that the decrease in performance from Datatables is not very significant compared to the look and functionality value it adds, but we still want to try and resolve them.
