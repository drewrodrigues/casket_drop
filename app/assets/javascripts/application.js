// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  var grids = $('.landing-grid-1, .landing-grid-2, .landing-grid-3, .landing-grid-4');
  grids
    .on('mouseover', function(event) {
      $(this).children('.landing-grid-mask').fadeIn(200);
    })
    .on('mouseleave', function() {
      $(this).children('.landing-grid-mask').fadeOut(200);
    });
})
