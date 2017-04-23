/* global $ */

$(document).ready(function() {
  $(".button-collapse").sideNav();
  $('.modal').modal();
  $('#timepicker').pickatime({
    autoclose: false,
    twelvehour: true
  });
});