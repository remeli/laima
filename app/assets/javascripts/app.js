$(document).ready(function() {
  $("#our-works").jCarouselLite({
    btnNext: "#next-work",
    btnPrev: "#prev-work",
    visible: 5
  });
});
$(document).ready(function() {
  $(".img-works a").lightBox({fixedNavigation:true});
});
