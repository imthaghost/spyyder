// *** RUN YOUTUBE VIDEO IN CLICK

(function () {
  let video = '<iframe class=\'embed-responsive-item\' src=\'https://www.youtube.com/embed/{%video%}?rel=0&amp;showinfo=0&autoplay=1\' frameborder=\'0\' allowfullscreen></iframe>';
  let video_frame = $('.video__video');
  video_frame.on('click', function (e) {
    e.preventDefault();
    let videoId = $(this).attr('data-video');
    video_frame.addClass('video__video--loading');
    $('.video__video .embed-responsive').html(video.replace('{%video%}', videoId));
    video_frame
      .removeClass('video__video--loading')
      .addClass('video__video--loaded')
      .off('click')
  });
})();