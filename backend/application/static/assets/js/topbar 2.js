'use strict';

//Fixed topbar
let mTop = $('.topbar').offset().top;
let eTop = $('#endMenu').offset().top;
$(window).on('scroll', function () {
  let top = $(document).scrollTop();
  
  if (top >= (mTop - 100) && top <= (eTop - 350)) {
    $('.topbar').addClass('topbar--fixed').removeAttr('style');
    $('.jsfeatures').addClass('jsfeatures--active');
  } else if (top >= (eTop - 350) && top <= (eTop - 150)) {
    $('.topbar').css({'transform': 'translateY(-150px)'});
  } else {
    $('.topbar').removeClass('topbar--fixed').removeAttr('style');
    $('.jsfeatures').removeClass('jsfeatures--active');
  }
});

//topbar
$(window).on('scroll', function () {
  let $sections = $('.about-app');
  $sections.each(function (i, el) {
    let top = $(el).offset().top - 283;
    let bottom = top + $(el).height() + 105;
    let scroll = $(window).scrollTop();
    let id = $(el).attr('id');
    if (scroll > top && scroll < bottom) {
      $('a.active').removeClass('active');
      $('a[href=\'#' + id + '\']').addClass('active');
    }
  })
});

//Anchors
$(function () {
  $('a[href^=\'#\']').on('click', function () {
    let target = $(this).attr('href');
    $('html, body').animate({scrollTop: $(target).offset().top}, 800);
    return false;
  });
});