$(document).on "page:change", ->
  if $("body[data-controller=purchases][data-action=index]").get 0
    $(".ship-thumb").click ->
      $("#ship-selection").val $(this).data "ship-id"
      $('html, body').animate({
        scrollTop: $("#purchase-form").offset().top
      }, 2000)

    $("#submit-order").click ->
      $.post "/api/orders",
        order:
          character_name: $("#character-name").val()
          order_items_attributes: [{
            item_id: $("#ship-selection").val()
            quantity: 1
          }]
      .done ->
        new Requisition.FlashMessage "Order placed", "alert-success"
      .fail ->
        new Requisition.FlashMessage "Could not place order", "alert-danger"
      false
