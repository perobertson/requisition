$(document).on "page:change", ->
  if $("body[data-controller=ships][data-action=index]").get 0
    $(".ship-thumb").click ->
      $("#ship-selection").val $(this).data "ship-id"
      $('html, body').animate({
        scrollTop: $("#purchase-form").offset().top
      }, 2000)

    $("#submit-order").click ->
      $.post "/api/orders",
        order:
          character_name: $("#character-name").val()
          ship_id: $("#ship-selection").val()
      .done ->
        new Requisition.FlashMessage "Order placed", "alert-success"
      .fail ->
        new Requisition.FlashMessage "Could not place order", "alert-danger"
      false
