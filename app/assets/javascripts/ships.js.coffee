$(document).on "page:change", ->
  if $("body[data-controller=ships][data-action=index]").get 0
    $(".ship-thumb").click ->
      $("#ship-selection").val $(this).data "ship-id"
      $('html, body').animate({
        scrollTop: $("#purchase-form").offset().top
      }, 2000)
