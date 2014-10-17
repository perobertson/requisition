$(document).on "page:change", ->
  if $("body[data-controller=purchases][data-action=index]").get 0
    $(".ship-thumb").click ->
      ship_id = $(this).data "ship-id"
      $(this).parents(".row").find("img").removeClass "bg-primary"
      if ship_id == $("#ship-selection").data "ship-id"
        $("#ship-selection").data "ship-id", null
      else
        $(this).find("img").addClass "bg-primary"
        $("#ship-selection").data "ship-id", ship_id

    $("#submit-order").click ->
      order_items = []
      ship_id = $("#ship-selection").data "ship-id"
      if ship_id?
        order_items.push { item_id: ship_id, quantity: 1 }

      $("#drones input").each (index, element) ->
        elem = $(element)
        if elem.val() isnt "0"
          order_items.push { item_id: elem.data("drone-id"), quantity: parseInt(elem.val()) }

      $.post "/api/orders",
        order:
          character_name: $("#character-name").val()
          order_items_attributes: order_items
      .done ->
        new Requisition.FlashMessage "Order placed", "alert-success"
      .fail (xhr) ->
        msg = xhr.getResponseHeader("X-Message")
        msg ||= "Could not place order"
        new Requisition.FlashMessage msg, "alert-danger"
      false
