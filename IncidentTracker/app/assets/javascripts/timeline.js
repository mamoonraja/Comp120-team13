$(document).on('page:change', function() {
  $("#datatable").DataTable({
    "order": [[5, "desc"], [6, "desc"]],
    responsive: true,
    retrieve: true
  });
});
