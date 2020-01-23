$( document ).on('turbolinks:load',function(){
//slick,slider
  $('.slider').slick({
    autoplay:true,
    autoplaySpeed:4000,
    speed:1000,
    accessibility: true,
    dots:true,


    });
    $('.slick-dots li').on('mouseover', function() {
        $('.slider').slick('goTo', $(this).index());
    });
});
$( document ).on('turbolinks:load',function() {
//画像プレビュー
function readURL(input) {
  if (input.files && input.files[0]) {
  var reader = new FileReader();
  reader.onload = function (e) {
$('#js_imgPrev').attr('src', e.target.result);
  }
  reader.readAsDataURL(input.files[0]);
  }
}
$("#js_presentImg").change(function(){
  readURL(this);
});

});