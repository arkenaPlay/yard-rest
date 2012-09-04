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
      $("pre.api_codeblock.JSON").fadeOut("fast", function() {
        $("pre.api_codeblock.XML").fadeIn("fast");
      });
    }
  });

  $(".switchContainer a.JSON").click(function() {
    if(!$(this).hasClass("active")) { 
      $(".switchContainer a.XML").removeClass("active");
      $(".switchContainer a.JSON").addClass("active");
      $("pre.api_codeblock.XML").fadeOut("fast", function() {
        $("pre.api_codeblock.JSON").fadeIn("fast");
      });
    }
  });
});