function resourceSearchFrameLinks() {
  $('#resource_list_link').click(function() {
    toggleSearchFrame(this, relpath + 'resource_list.html');
  });
}

$(resourceSearchFrameLinks);

$(document).ready(function() {
  $(".switchContainer a.XML").click(function() {
    if(!$(this).hasClass("active")) {
      $(".switchContainer a.JSON").removeClass("active");
      $(".switchContainer a.XML").addClass("active");
      $("pre.example.code.JSON").fadeOut("fast", function() {
        $("pre.example.code.XML").fadeIn("fast");
      });
    }
  });

  $(".switchContainer a.JSON").click(function() {
    if(!$(this).hasClass("active")) { 
      $(".switchContainer a.XML").removeClass("active");
      $(".switchContainer a.JSON").addClass("active");
      $("pre.example.code.XML").fadeOut("fast", function() {
        $("pre.example.code.JSON").fadeIn("fast");
      });
    }
  });
});