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

$(document).ready(function() {
  $("#services-admin .one-service:even").addClass('even');
  $("#services-admin .one-service:odd").addClass('odd');
});
