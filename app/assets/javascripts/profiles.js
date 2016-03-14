var spin = '<div class="spinner"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>';

$(document).ready(function(){
  $('#toggle-follow').click(function(){
    var _el = $(this);
     $.ajax({
            url: "/profile/follow",
            type: "post",
            data: {user_id: _el.attr('data-user')},
            success: function (response) {
              if (response.success) {
                if (response.follow) {
                  _el.removeClass('btn-default').addClass('btn-primary');
                } else {
                  _el.removeClass('btn-primary').addClass('btn-default');
                }
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
    var _posts = $('.item-text-area');
    var data = {content: $('#post-content').val()};
    var _spin = $(spin);
    $(this).append(_spin);
     $.ajax({
            url: "/profile/post",
            type: "post",
            data: data,
            success: function (response) {
              if (response.success) {
                _posts.after(response.html);
                $('#post-content').val('');
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