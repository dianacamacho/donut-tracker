/* global $ */

$(document).ready(function() {
  $(".button-collapse").sideNav();
  $('.modal').modal();
  $('#timepicker').pickatime({
    autoclose: false,
    twelvehour: true
  });
  // $('.carousel').carousel();
  // $('.carousel.carousel-slider').carousel({fullWidth: true});
  $('.carousel').carousel({
    dist:0,
    shift:0,
    padding:20,

  });
});

