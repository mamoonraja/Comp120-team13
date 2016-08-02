function IncidentPoller() {
  this.poll();
}

IncidentPoller.prototype.poll = function() {
  var self = this;
  setTimeout(function async() {
    $.get("/api/v1/incidents", function(data) {
      var len = data.incidents.length;
      var diff = len + 1 - $('.table__row').length;
      for(var i = 0; i < diff; i++)
        self.addNewIncident(data.incidents[len - 1 - i]);
    });
    setTimeout(async, 60000);
  }, 60000);
};

IncidentPoller.prototype.addNewIncident = function(incident) {
  var table = $('#datatable').DataTable();
  var time = new Date(incident.time);
  time = time.getHours() - 12 + ":" + time.getMinutes();
  $.get("/api/v1/users/" + incident.user_id, function(data) {
    console.log(data);
    var name = data.user.first_name + " " + data.user.last_name;
    table.row.add([
        name,
        "<img src='" + incident.media.media.thumb.url + "'/>",
        incident.description,
        incident.location,
        "Open",
        incident.severity,
        incident.date,
        time,
        "<a href='/incidents/" + incident.id + "'>Show</a>"
    ]).draw();
    $("tr[role='row']").addClass('table__row');
  });
};

$(document).ready(function() {
  new IncidentPoller();
});

