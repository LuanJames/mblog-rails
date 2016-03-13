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
//= require_tree .

$(document).ready(function(){

$('#notifications').click(function () {
  var ids = [];
  var _el = $(this);
  _el.find('.not-item').each(function () {
    var attr = $(this).attr('data-user');
    if (typeof attr !== typeof undefined && attr !== false) {
      ids.push($(this).attr('data-user'));
    }
  });

  if (ids.length > 0) {
     $.ajax({
            url: "/profile/saw",
            type: "post",
            data: {users: ids},
            success: function (response) {
              if (response.success) {
                _el.find('.not-item').each(function () {
                  $(this).removeAttr('data-user');
                });
                _el.find('.navbar-unread').remove();
              }
            },
            error: function(jqXHR, textStatus, errorThrown) {
              if (jqXHR.status == 401) {
                window.location = '/users/sign_in'
              }
            }
          });
  }
});

});