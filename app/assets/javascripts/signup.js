$(document).on('ready page:load', function () {
  if($('#signup').length) {
    $('#user_is_seller').change(function() {
      if ($('#user_is_seller').val() === 'true') {
        $('<input placeholder="Enter Code" required="required" type="password" name="user[code]"" id="user_code">').insertAfter(this)
      } else if ($('#user_is_seller').val() === 'false') {
        if ($('#user_code')) {
          $('#user_code').remove()
        }
      }
    })
  }
})
