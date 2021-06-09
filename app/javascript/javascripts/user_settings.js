// /user_settings/*
// ユーザ設定画面
// アバター変更操作
$(function() {
  var avatarForm = $('#user_avatar');
  avatarForm.on('change', function(e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#setting-avatar-preview-img').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
    $('#setting-avatar-preview').removeClass('d-none');

    var formdata = new FormData($('#setting-avatar-form').get(0));

    $.ajax({
      url: '/user_settings/avatar/confirm',
      method: 'post',
      data: formdata,
      processData: false,
      contentType: false,
      cache: false,
      dataType: 'json',
    })
    .done(function(data) {
      $('#update-form').html(data.html);
    })
    .fail(function() {
      console.log('failed');
    });
  })

  $('#setting-avatar-cancel-button').on('click', function() {
    $('#setting-avatar-preview').addClass('d-none');
  })
})

// /:username
// ユーザ詳細画面
// introduction form 表示切り替え
$(function() {
  $('#edit-introduction-button').on('click', function() {
    $('#form-introduction').removeClass('d-none');
    $('#edit-introduction-button').addClass('d-none');
  });
  $('#form-introduction-cancel').on('click', function() {
    $('#form-introduction').addClass('d-none');
    $('#edit-introduction-button').removeClass('d-none');
  })
})
