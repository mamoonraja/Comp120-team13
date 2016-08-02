$(document).on('page:load', function() {
  $('#user_role').on('change', function() {
    if($('#user_role').val() == 'Faculty') {
      $('.department').show();
    } else {
      $('.department').hide();
    }
  });
});

$(document).ready(function() {
  var str = $('.js--media').attr('src');
  if(str.substr(-1) === '/') {
    str = str.substr(0, str.length - 1);
    $('.js--media').attr('src', str);
  }
});
