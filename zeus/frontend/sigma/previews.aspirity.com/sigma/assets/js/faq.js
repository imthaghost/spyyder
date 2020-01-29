'use strict';

//The code for opening and closing
$('.faq__card').on('click', function () {
  
  let el = this.getElementsByClassName('faq__card-description')[0];
  let p = $(el).children();
  let height = 0;
  
  for (let i = 0; i < $(p).length; i++) {
    height += $(p[i]).height() + 32;
  }
  
  if ($(this).hasClass('active')) {
    $(el).removeAttr('style');
    $(this).removeClass('active');
  } else {
    $(el).css({'height': height});
    $(this).addClass('active');
  }
});