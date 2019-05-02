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
//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


$(document).ready(function() {
  // $('#sentinel_target_c').change(function() {
  //   var ddd = this
  //   console.log(this)
  //   // $('#sentinel_target_f').val(this.*1.8+32)
  // });

  $('#sentinel_target_c').change(function() {
      $('#sentinel_target_f').val($(this).val()*1.8+32);
      // $('#sentinel_target_f').attr('disabled',true)
  });

  $('#sentinel_target_f').change(function() {
      $('#sentinel_target_c').val(($(this).val()-32)/1.8);
      // $('#sentinel_target_c').attr('disabled',true)
  });

});
