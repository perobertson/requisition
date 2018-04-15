$(document).on "turbolinks:load", ->
  if $("body[data-controller=inventory][data-action=index]").get 0
    $("input[type='checkbox']").bootstrapSwitch()

    $(".items-container").on 'switchChange.bootstrapSwitch', "input[type='checkbox'].attr-for_sale", (event, state) ->
      item_id = $(this).parents(".item-container").data "item-id"
      $.ajax "/api/items/#{item_id}",
        type: "put"
        contentType: "application/json"
        data: JSON.stringify item: for_sale: state
      .fail (jqXHR, status, errorThrown) =>
        # TODO: switch to using the response json
        msg = jqXHR.getResponseHeader("X-Message")
        new Requisition.FlashMessage(msg, "alert-danger") if msg?

    $(".items-container").on 'switchChange.bootstrapSwitch', "input[type='checkbox'].attr-rendered", (event, state) ->
      item_id = $(this).parents(".item-container").data "item-id"
      $.ajax "/api/items/#{item_id}",
        type: "put"
        contentType: "application/json"
        data: JSON.stringify item: rendered: state
      .done (data, textStatus, jqXHR) =>
        window.location.reload()
      .fail (jqXHR, status, errorThrown) =>
        # TODO: switch to using the response json
        msg = jqXHR.getResponseHeader("X-Message")
        new Requisition.FlashMessage(msg, "alert-danger") if msg?

    $(".items-container").on 'change', 'select', (event) ->
      self = $(this)
      item_id = self.parents(".item-container").data "item-id"
      categoryId = self.val()
      $.ajax "/api/items/#{item_id}",
        type: "put"
        contentType: "application/json"
        data: JSON.stringify item: category_id: categoryId
      .done (data, textStatus, jqXHR) =>
        window.location.reload()

    $("#new-item").on "ajax:success", (event, data, status, xhr) ->
      new Requisition.FlashMessage("Item added", "alert-success")
      setTimeout ->
        window.location.reload()
      , 2000

    $("#new-item").on "ajax:error", (event, jqXHR, errorThrown) ->
      msg = jqXHR.getResponseHeader("X-Message")
      new Requisition.FlashMessage(msg, "alert-danger") if not not msg
      data = jqXHR.responseJSON
      return unless data?
      $(data.error_messages).each (index, msg) ->
        new Requisition.FlashMessage(msg, "alert-danger")
