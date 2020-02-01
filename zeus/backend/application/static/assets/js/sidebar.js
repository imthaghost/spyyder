'use strict';

//Fixed sidebar
let sidebar = $('.sidebar');

function Sidebar() {
  let mTop = $('#top').offset().top;
  let top = $(document).scrollTop();
  let eTop = $('#endMenu').offset().top;
  let mHeight = $('.sidebar').height();
  let width = $('.col-3').width();
  
  if (top >= (mTop - 100) && top < (eTop - mHeight - 300)) {
    sidebar.addClass('sidebar--fixed').removeClass('sidebar--bottom');
    sidebar.css('width', width);
  } else if (top >= (eTop - mHeight - 300)) {
    sidebar.addClass('sidebar--bottom').removeClass('sidebar--fixed');
  } else {
    sidebar.removeClass('sidebar--fixed').removeClass('sidebar--bottom');
  }
}

Sidebar();

$(window).on('scroll', function () {
  Sidebar();
  let $sections = $('.chapter');
  $sections.each(function (i, el) {
    let top = $(el).offset().top - 225;
    let bottom = top + $(el).height();
    let scroll = $(window).scrollTop();
    let id = $(el).attr('id');
    if (scroll > top && scroll < bottom) {
      $('li.active').removeClass('active');
      $('a[href=\'#' + id + '\']').parent().addClass('active');
    }
  })
});

$(window).on('resize', function () {
  Sidebar();
});

//Anchors
$(function () {
  $('a[href^=\'#\']').on('click', function () {
    let target = $(this).attr('href');
    $('html, body').animate({scrollTop: $(target).offset().top - 110}, 800);
    return false;
  });
});