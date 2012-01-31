// slider jobs
$(document).ready(function() {
  $("#our-works").jCarouselLite({
    btnNext: "#next-work",
    btnPrev: "#prev-work",
    visible: 5
  });
});

// lightbox for jobs
$(document).ready(function() {
  $(".img-works a").lightBox({fixedNavigation:true});
});

//  lightbox for jobs in service show page
$(document).ready(function() {
  $("#service-jobs a").lightBox({fixedNavigation:true});
});


// admin services
$(document).ready(function() {
  $("#services-admin .one-service:even").addClass('even');
  $("#services-admin .one-service:odd").addClass('odd');
});

// main slider
$(document).ready(function() {
  $("#slide-js").jCarouselLite({
    btnNext: ".left-arrow img",
    btnPrev: ".right-arrow img",
    visible: 1
  });
});

$(document).ready(function() {
  $('#myScrollTable').Scrollable(200, 700);
});
