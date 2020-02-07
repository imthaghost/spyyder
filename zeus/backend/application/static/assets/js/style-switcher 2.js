'use strict';

//Open swtcher menu
$('.style-switcher__control').on('click', function () {
  $('.style-switcher').toggleClass('style-switcher--active');
});


$('.style-switcher__link').on('click', function (event) {
  event.preventDefault();
  let link = $(this).attr('href');
  $('.style-switcher__link').removeClass('active');
  $(this).addClass('active');
  $('link[id=\'main_style\']').attr('href', link);
});