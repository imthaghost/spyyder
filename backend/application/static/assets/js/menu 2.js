'use strict';

//Fixed-top menu
function fixedHeader() {
  let ww = $(window).scrollTop();
  if (ww > 0) {
    $('.menu').addClass('menu--active');
    $('.mobile-menu').addClass('mobile-menu--scroll');
  } else {
    $('.menu').removeClass('menu--active');
    $('.mobile-menu').removeClass('mobile-menu--scroll');
  }
}

fixedHeader();
$(window).on('scroll', function () {
  fixedHeader();
});


