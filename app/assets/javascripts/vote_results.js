$(document).on('ready page:load', function () {
  $('.flow-text').wordBreakKeepAll();

  $('.representatives-carousel').slick({
    dots: true,
    infinite: false,
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

});