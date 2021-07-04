$(function() {
  $('body').on('keyup', '#tag_input', function(e) {
    if(e.keyCode == 188 || e.keyCode == 13) {
      renderText();
    } else if (e.keyCode == 8 && $(this).val() == '') {
      focusBeforeText();
    }
  })
  $('body').on('blur', '#tag_input', function(e) {
      renderText();
    }
  )

  function renderText() {
    var input = $('#tag_input');
    var addText = input.val();
    input.val('');
    if (addText[addText.length - 1] == ',') {
      addText = addText.slice(0, -1)
    }
    if (addText.length) {
      $('#tag_texts').append(`<div class="neo">${addText.trim()}</div>`);
    }
  }

  function focusBeforeText() {
    var textsElements = $('#tag_texts').children();
    if (textsElements.length) {
      var scopeElement = $(textsElements[textsElements.length - 1]);
      $('#tag_input').val(scopeElement.text());
      scopeElement.remove();
    }
  }

  $('body').on('click', '#memo-submit', function() {
    var str = [];
    $('#tag_texts').children().each(function() {
      str.push($(this).text());
    })
    $('#tag_field').val(str.join(','));
  })

  $('body').on('keydown', '#memo-edit-form', function(e) {
    if(e.keyCode == 13) {
      if (e.target.localName != 'textarea') {
        return false;
      }
    }
  })
  window.onbeforeunload = function(e) {
    if ($('#leave_flag').data('flag')) {
      e.returnValue = "ページを離れようとしています。よろしいですか？";
    }
  }
})
