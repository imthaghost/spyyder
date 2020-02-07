'use strict';

$(document).on('ready', function () {
  
  //Settings for activation carousels
  //More information about settings here: https://github.com/kenwheeler/slick/
  
  $('#feature-slider').slick({
    // normal options...
    infinite: true,
    autoplay: true,
    autoplaySpeed: 5000
  });
  
  $('.carousel__slider--think').slick({
    // normal options...
    infinite: true,
    autoplay: true,
    autoplaySpeed: 5000,
    dots: true,
    dotsClass: 'carousel__navigation-stick'
  });
  
  $('.carousel__slider--images').slick({
    // normal options...
    infinite: true,
    // autoplay: true,
    autoplaySpeed: 5000,
    dots: true,
    dotsClass: 'carousel__navigation-stick',
    // cssEase: 'linear',
    // fade: true,
    // useCSS: false
  });
  
  //Custom navigation panel
  $('.carousel__navigation-item').on('click', function () {
    //remove .active class from all items
    $('.carousel__navigation-item').removeClass('slick-active');
    
    //change slide
    let id = $(this).attr('tabindex');
    $('#feature-slider').slick('slickGoTo', id, false);
    //add .active to actual nav-item
    $(this).addClass('slick-active')
  });
  
  //Changing style of navigation item before appear next slide
  $('#feature-slider').on('beforeChange', function (event, slick, currentSlide, nextSlide) {
    $('.carousel__navigation-item').removeClass('slick-active');
    $('.carousel__navigation-item[tabindex=\'' + nextSlide + '\']').addClass('slick-active');
    
    let leftPos = nextSlide * 150;
    $('.carousel__navigation').animate({scrollLeft: leftPos}, 400);
  });
  
  //Replace html-code from plugin to necessary for theme
  $(function () {
    //Add icons for all sliders
    let prev = '<span><i class=\'mdi mdi-chevron-left\'></i></span>';
    let arrArrowLenght = document.getElementsByClassName('slick-prev').length;
    
    for (let i = 0; i < arrArrowLenght; i++) {
      document.getElementsByClassName('slick-prev')[i].innerHTML = prev;
    }
    
    let next = '<span><i class=\'mdi mdi-chevron-right\'></i></span>';
    for (let i = 0; i < arrArrowLenght; i++) {
      document.getElementsByClassName('slick-next')[i].innerHTML = next;
    }
  });
  
  if (device.desktop()) $('.carousel__navigation, .carousel__navigation-items').dragscrollable();
});

