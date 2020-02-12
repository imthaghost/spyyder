'use strict';

$('.tags__tag').on('click', function () {
  
  //add your logic for tag search
  if ($(this).hasClass('tags__tag--active')) {
    $(this).removeClass('tags__tag--active');
  } else {
    $(this).addClass('tags__tag--active');
  }
});

//create reply form
$('.post__comment-reply').on('click', function () {
  $('.post__comment-reply').removeAttr('disabled');
  let comm = $(this).parent('.post__comment-controls');
  $(this).attr('disabled', 'disabled');
  
  $('.post__comment-controls .post__write-comment').remove();
  $('.post__write-comment--main').css({'display': 'none'});
  
  let post_form = '<div class=\'post__write-comment form form--comment\'>' +
    '<h4>Write a comment</h4>' +
    '<button class=\'post__write-comment-cancel link link--accent\'>Cancel comment</button>' +
    '<form class=\'form__form\'>' +
    '<div class=\'form__group\'>' +
    '<div class=\'form__form-group\'>' +
    '<label class=\'form__label\'>Name</label>' +
    '<input class=\'form__input js-field__name\' type=\'text\' placeholder=\'John Doe\'>' +
    '<span class=\'form-validation\'></span>' +
    '</div>' +
    '<div class=\'form__form-group\'>' +
    '<label class=\'form__label\'>Email <span>*</span></label>' +
    '<input class=\'form__input js-field__name\' type=\'email\' placeholder=\'example@gmail.com\' required>' +
    '<span class=\'form-validation\'></span>' +
    '</div>' +
    '<div class=\'form__form-group\'>' +
    '<label class=\'form__label\'>Website</label>' +
    '<input class=\'form__input js-field__url\' type=\'url\' placeholder=\'http://example.com\'>' +
    '<span class=\'form-validation\'></span>' +
    '</div>' +
    '</div>' +
    '<div class=\'form__form-group\'>' +
    '<label class=\'form__label\'>Comment <span>*</span></label>' +
    '<textarea class=\'form__input form__input--textarea js-field__message\' type=\'url\' required' +
    '          placeholder=\'Enter your comment here...\'></textarea>' +
    '<span class=\'form-validation\'></span>' +
    '</div>' +
    '<div class=\'form__form-group form__form-group--notify\'>' +
    '<label class=\'checkbox-btn\'>' +
    '<input class=\' checkbox-btn__checkbox\' type=\'checkbox\' name=\'notify\'>' +
    '<span class=\'checkbox-btn__checkbox-custom\'><i class=\'mdi mdi-check\'></i></span>' +
    '<span class=\'checkbox-btn__label\'>Notify me of new comments by email.</span>' +
    '</label>' +
    '</div>' +
    '<button class=\'site-btn site-btn--accent form__submit\' type=\'submit\' value=\'Send\'>Post comment</button>' +
    '</form>' +
    '</div>';
  
  $(comm).append(post_form);
});

//remove reply form
$('.post__comment-controls').on('click', 'button.post__write-comment-cancel', function () {
  
  let post_form = $(this).parent('.post__write-comment');
  $(post_form).prev().prev().removeAttr('disabled');
  $(post_form).remove();
  $('.post__write-comment--main').css({'display': 'block'});
});

//selects
$('.form__input--select').editableSelect({effects: 'slide', filter: false});

$('.js-field__category').attr('placeholder', 'Select category...');
$('.js-field__month').attr('placeholder', 'Select month...');

$('.form__input-icon-wrap').on('click', function () {
  $('.form__input--select').editableSelect('hide');
});

$('.form__input--select').on('click', function () {
  $(this).editableSelect('show');
});

$('.js-field__category').on('select.editable-select', function (e) {
  let category = $(this).val().replace(' ', '_').toLowerCase();
  window.open('../blog/13_blog_filter.html?category=' + category, '_self')
});

$('.js-field__month').on('select.editable-select', function (e) {
  let date = $(this).val().split(' ');
  let month = date[0];
  let year = date[1];
  window.open('../blog/13_blog_filter.html?month=' + month + '&year=' + year, '_self');
});


//lightshot
if ($(".post__gallery").length) {
  // gallery lightshot
  $(document).ready(function () {
    $(".post__gallery").lightGallery();
  });
}

// twitter widget
function tweet() {
  let w = document.getElementById('twitter-widget-0').contentDocument;
  let text = w.getElementsByClassName('timeline-Tweet-text');
  let date = w.getElementsByClassName('timeline-Tweet-timestamp');
  
  $('#tweet').removeClass('social-card__tweet--load');
  $(date[0]).addClass('social-card__tweet-date').appendTo('#tweet');
  $(text[0]).appendTo('#tweet');
  // document.getElementById('twitter-widget-0').remove();
}

window.onload = function () {
  let myVar;
  myVar = setTimeout(function () {
    tweet();
  }, 100)
};

//likes buttons
//we use localStorage to store information about liked comments. it's just for simulation of work likes.
$(function () {
  let comments = $('.post__comment-like');
  
  for (let i = 0; i < comments.length; i++) {
    let comment_id = $(comments[i]).attr('data-comment-id');
    
    if (localStorage.getItem(comment_id)) {
      let like = $(comments[i]).context.innerText;
      like = parseInt(like) + 1;
      let start ='<i class=\'mdi mdi-heart\'></i> ';
      $(comments[i]).html(start + like).addClass('post__comment-like--active');
    }
  }
});

$('.post__comment-like').on('click', function () {
  
  let comment = $(this).attr('data-comment-id');
  let like = $(this).context.innerText;
  like = parseInt(like.split(' ')[1]);
  let start ='<i class=\'mdi mdi-heart\'></i> ';
  
  if ($(this).hasClass('post__comment-like--active')) {
    $(this).removeClass('post__comment-like--active');
    like -= 1;
    localStorage.removeItem(comment);
  } else {
    $(this).addClass('post__comment-like--active');
    like +=1;
    localStorage.setItem(comment, comment);
  }
  
  $(this).html(start + like);
  $(this).addClass('post__comment-like--clicked');
  
  let myVar;
  myVar = setTimeout(function () {
    $('.post__comment-like--clicked').removeClass('post__comment-like--clicked');
  }, 500)
});

//post like
$(function () {
  let post = $('.post__social--likes');
  
  for (let i = 0; i < post.length; i++) {
    let post_id = $(post[i]).attr('data-post-id');
    
    if (localStorage.getItem(post_id)) {
      let like = $(post[i]).context.innerText;
      like = parseInt(like) + 1;
      console.log('text', like);
      let start ='<i class=\'mdi mdi-heart\'></i> ';
      let end = ' <span>likes</span>';
      $(post[i]).html(start + like + end).addClass('post__social--active');
    }
  }
});

$('.post__social--likes').on('click', function () {
  
  let post_id = $(this).attr('data-post-id');
  let like = $(this).context.innerText;
  like = parseInt(like.split(' ')[1]);
  let start ='<i class=\'mdi mdi-heart\'></i> ';
  let end = ' <span>likes</span>';
  
  if ($(this).hasClass('post__social--active')) {
    $('.post__social--likes').removeClass('post__social--active');
    like -= 1;
    localStorage.removeItem(post_id);
  } else {
    $('.post__social--likes').addClass('post__social--active');
    like +=1;
    localStorage.setItem(post_id, post_id);
  }
  
  $('.post__social--likes').html(start + like + end);
  $(this).addClass('post__social--likes-clicked');
  
  let myVar;
  myVar = setTimeout(function () {
    $('.post__social--likes-clicked').removeClass('post__social--likes-clicked');
  }, 500)
});