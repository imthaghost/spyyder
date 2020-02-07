'use strict';

$('.tags__tag').on('click', function () {
  //todo: add your logic for tag search
  if ($(this).hasClass('tags__tag--active')) {
    $(this).removeClass('tags__tag--active');
  } else {
    $(this).addClass('tags__tag--active');
  }
});

//create posts' preview on blog page
$(function () {
  $.getJSON('posts.json', function (data) {
    
    let page = getUrlVars()['p'] ? getUrlVars()['p'] : '1';
    let posts_amount = data.post.length;
    if (((posts_amount - 1) / 6).toString() <= page) {
      $('.blog__btn-prev').remove();
    }
    
    let posts = data.post.slice((page - 1) * 6 + 1, page * 6 + 1);
    
    $.each(posts, function (i, a) {
      let like = localStorage.getItem(a.id) ? ' blog__item-social--active' : '';
      let likes = localStorage.getItem(a.id) ? a.likes + 1 : a.likes;
      let blog_post = '<div class=\'blog__item card\'>' +
        '<a href=\'' + a.link + '\' class=\'blog__item-link\'/>' +
        '<div class=\'blog__item-img-wrap\'>' +
        '<div class=\'blog__item-img\' style=\'background-image: url(' + a.img + ')\'></div>' +
        '</div>' +
        '<div class=\'blog__item-content\'>' +
        '<a class=\'blog__item-content-category link link--accent\' href=\'13_blog_filter.html?category=' + a.type + '\'>' + a.category + '</a>' +
        '<p class=\'blog__item-content-date\'>' + a.date + '</p>' +
        '<h4 class=\'blog__item-content-title\'>' + a.title + '</h4>' +
        '<p class=\'blog__item-content-preview\'>' + a.preview + '</p>' +
        '<div class=\'blog__item-content-bottom\'>' +
        '<p class=\'blog__item-social\'><i class=\'mdi mdi-eye\'></i> ' + a.views + ' <span>views</span></p>' +
        '<a class=\'blog__item-social link link--accent\' href=\'' + a.link + '#comments\'><i class=\'mdi mdi-comment\'></i> ' + a.comments + ' <span>comments</span></a>' +
        '<a class=\'blog__item-social blog__item-social--like link link--accent' + like + '\' data-post-id=\'' + a.id +
        '\'><i class=\'mdi mdi-heart\'></i> ' + likes + ' <span>likes</span></a>' +
        '</div>' +
        '</div>' +
        '</div>';
      $(blog_post).appendTo('.blog__wrap');
    });
    
    //add newest post on the first page
    if (page === '1') {
      $('.blog__btn-next').remove();
      
      let first = data.post[0];
      let like = localStorage.getItem(first.id) ? ' blog__item-social--active' : '';
      let likes = localStorage.getItem(first.id) ? first.likes + 1 : first.likes;
      
      let blog_post = '<div class=\'blog__item-img-wrap\'>' +
        '<a href=\'' + first.link + '\' class=\'blog__item-link\'/>' +
        '<div class=\'blog__item-img\' style=\'background-image: url(' + first.img + ')\'></div>' +
        '</div>' +
        '<div class=\'blog__item-content\'>' +
        '<p class=\'blog__item-content-date\'>' + first.date + '</p>' +
        '<a class=\'blog__item-content-category link link--accent\' href=\'13_blog_filter.html?category=' + first.type + '\'>' + first.category + '</a>' +
        '<a class=\'link link--gray\' href=\'' + first.link + '\'><h2 class=\'blog__item-content-title\'>' + first.title + '</h2></a>' +
        '<p class=\'blog__item-content-preview\'>' + first.preview + '</p>' +
        '<hr/>' +
        '<div class=\'blog__item-content-bottom\'>' +
        '<p class=\'blog__item-social\'><i class=\'mdi mdi-eye\'></i> ' + first.views + ' <span>views</span></p>' +
        '<a class=\'blog__item-social link link--accent\' href=\'' + first.link + '#comments\'><i class=\'mdi mdi-comment\'></i> ' + first.comments + ' <span>comments</span></a>' +
        '<a class=\'blog__item-social blog__item-social--like link link--accent' + like + '\' data-post-id=\'' + first.id +
        '\'><i class=\'mdi mdi-heart\'></i> ' + likes + ' <span>likes</span></a>' +
        '</div>' +
        '<a href=\'' + first.link + '\' class=\'site-btn site-btn--light blog__item-btn\'>Continue Reading</a>' +
        '</div>';
      $(blog_post).appendTo('.blog__item--header');
    }
    else {
      $('.header-home').css({display: 'none'});
      $('.blog').addClass('blog--section-first');
    }
  });
});

//page-btns logic
$('.blog__btn-prev').on('click', function (e) {
  e.preventDefault();
  let page = getUrlVars()['p'] ? getUrlVars()['p'] : '1';
  page = parseInt(page) + 1;
  window.open('12_blog.html?p=' + page, '_self')
});

$('.blog__btn-next').on('click', function (e) {
  e.preventDefault();
  let page = getUrlVars()['p'] ? getUrlVars()['p'] : '1';
  page = parseInt(page) - 1;
  window.open('12_blog.html?p=' + page, '_self')
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
  window.open('13_blog_filter.html?category=' + category, '_self')
});

$('.js-field__month').on('select.editable-select', function (e) {
  let date = $(this).val().split(' ');
  let month = date[0];
  let year = date[1];
  window.open('13_blog_filter.html?month=' + month + '&year=' + year, '_self');
});


//get url parameters
function getUrlVars() {
  let vars = {};
  window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (m, key, value) {
    vars[key] = value;
  });
  return vars;
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
  let myVar = setTimeout(function () {
    tweet();
  }, 100)
};


//likes buttons
//we use localStorage to store information about liked posts. it's just for simulation of work likes.
$('.blog').on('click', '.blog__item-social--like', function () {
  
  let post = $(this).attr('data-post-id');
  let like = $(this).context.innerText;
  like = parseInt(like.split(' ')[1]);
  let start = '<i class=\'mdi mdi-heart\'></i> ';
  let end = ' <span>likes</span>';
  
  if ($(this).hasClass('blog__item-social--active')) {
    $(this).removeClass('blog__item-social--active');
    like -= 1;
    localStorage.removeItem(post);
  } else {
    $(this).addClass('blog__item-social--active');
    like += 1;
    localStorage.setItem(post, post);
  }
  
  $(this).html(start + like + end);
  $(this).addClass('blog__item-social--clicked');
  
  let myVar;
  myVar = setTimeout(function () {
    $('.blog__item-social--clicked').removeClass('blog__item-social--clicked');
  }, 500)
});