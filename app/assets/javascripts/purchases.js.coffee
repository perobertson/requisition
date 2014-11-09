$(document).on "page:change", ->
  if $("body[data-controller=purchases][data-action=index]").get 0

    incrementQuantity = (input, img)->
      input.val parseInt(input.val()) + 1
      img.addClass "bg-primary"
      input.trigger "change"

    $("input.quantity").change ->
      self = $(this)
      if parseInt(self.val()) < 1
        img = self.parents(".item-container").find("img")
        img.removeClass "bg-primary"

    $(".item-thumb").click ->
      self = $(this)
      id = self.parent().data "item-id"
      input = $("#quantity-item-#{id}")
      incrementQuantity input, self.children "img"

    $("#submit-order").click ->
      order_items = []

      $(".item-container input").each (index, element) ->
        elem = $(element)
        if elem.val() isnt "0"
          id = elem.parents(".item-container").data "item-id"
          quantity = parseInt elem.val()
          order_items.push { item_id: id, quantity: quantity }

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
