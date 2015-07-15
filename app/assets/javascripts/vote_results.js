
$(document).on('ready page:load', function () {
  $('.flow-text').wordBreakKeepAll();
  $('.jc_vote_title').wordBreakKeepAll();
  $('.jc_shrinker h1').wordBreakKeepAll();
  $('.representatives-carousel').slick({
    dots: true,
    infinite: true,
    arrows: true,
    slidesToShow: 1,

  });

  $('.flow-text').css('font-size',function(){
    var responsiveFontSize = $(this).width() / 33;
    if( responsiveFontSize < 14 )
      return 14
    else
      return responsiveFontSize
  });


  $('#userAlarm').on('shown.bs.modal', function () {
    $('#userAlarm').focus()
  })


  $(function(){
    var shrinkHeader = 525;
    $(window).scroll(function() {
      var scroll = getCurrentScroll();
      if ( scroll >= shrinkHeader ) {
        $('.jc_shrinker').addClass('shrink');
      }
      else {
        $('.jc_shrinker').removeClass('shrink');
      }
    });

    function getCurrentScroll() {
      return window.pageYOffset || document.documentElement.scrollTop;
    }

  });

});