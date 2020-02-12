'use strict';

//Validation forms
function validateForm(selector) {
  Array.prototype.slice.call(document.querySelectorAll(selector)).forEach(function (item) {
    item.addEventListener('input', function (e) {
      if (e.target.value === '') {
        item.dataset.touched = false;
      }
    });
    item.addEventListener('invalid', function () {
      item.dataset.touched = true;
    });
    item.addEventListener('blur', function () {
      if (item.value !== '') item.dataset.touched = true;
    });
  });
}

//Validation for checkbox
$(function () {
  let requiredCheckboxes = $('.js-form :checkbox[required]');
  requiredCheckboxes.on('change', function () {
    if (requiredCheckboxes.is(':checked')) {
      requiredCheckboxes.removeAttr('required');
      $('.form__submit').removeAttr('disabled').removeClass('disable');
    } else {
      requiredCheckboxes.attr('required', 'required');
      $('.form__submit').attr('disabled', 'disabled').addClass('disable');
    }
  });
});

validateForm('.js-form .form__input');