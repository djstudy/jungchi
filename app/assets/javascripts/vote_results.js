$(document).on('ready page:load', function () {
  $('.representatives-carousel').slick({
    dots: true,
    infinite: false,
    arrows: true,
    slidesToShow: 1,

  });

  $('.flow-text').css('font-size',function(){
    var responsiveFontSize = $(this).width() / 33;
    if( responsiveFontSize < 18 )
      return 18
    else
      return responsiveFontSize
  });

});