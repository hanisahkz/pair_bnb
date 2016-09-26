// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree
//= require moment


$(document).ready(function() {
  $('input[class="daterange"]').daterangepicker();
  $("#slider").slider({
    range:true,
    min: 10,
    max: 5000,
    values: [10, 5000],
    slide: function(event, ui) {
      $("#price").val("$" + ui.values[0] + " - $" + ui.values[1]);
    },
    change: function(event, ui) {
      $("#min").attr('value', $("#slider").slider("values", 0));
      $("#max").attr('value', $("#slider").slider("values", 1)); 
    }
  });
  $("#price").val("$" + $("#slider").slider("values", 0) + " - $"
    + $("#slider").slider("values", 1));
});