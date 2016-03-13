$(document).ready(function(){
  $('#toggle-follow').click(function(){
    var _el = $(this)
     $.ajax({
            url: "/profile/follow",
            type: "post",
            data: {user_id: _el.attr('data-user')},
            success: function (response) {
              if (response.success) {
                _el.text(response.body);
              }
            },
            error: function(jqXHR, textStatus, errorThrown) {
              if (jqXHR.status == 401) {
                window.location = '/users/sign_in'
              }
            }
          });
  });

  $('#create-post').click(function () {
    var _el = $(this);
    var _posts = $('.posts');
    var data = {content: $('#post-content').val()};
     $.ajax({
            url: "/profile/post",
            type: "post",
            data: data,
            success: function (response) {
              if (response.success) {
                _posts.prepend(response.html);
                _el.text(response.body);
              }
            },
            error: function(jqXHR, textStatus, errorThrown) {
              if (jqXHR.status == 401) {
                window.location = '/users/sign_in'
              }
            }
          });
  });
});