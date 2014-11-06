$(document).on "page:change", ->
  if $("body[data-controller=inventory][data-action=index]").get 0
    $("input[type='checkbox']").bootstrapSwitch()

    $(".items-container").on 'switchChange.bootstrapSwitch', "input[type='checkbox']", (event, state) ->
      item_id = $(this).parents(".item-container").data "item-id"
      $.ajax "/api/items/#{item_id}",
        type: "put"
        contentType: "application/json"
        data: JSON.stringify item: for_sale: state
      .fail (jqXHR, status, errorThrown) =>
        msg = jqXHR.getResponseHeader("X-Message")
        new Requisition.FlashMessage(msg, "alert-danger") if msg?

    $("#new-item").on "ajax:success", (event, data, status, xhr) ->
      $.ajax "/api/items/#{data.id}.html",
        contentType: "html"
      .done (html) ->
        $(".items-container").append(html)
        $(".item-container[data-item-id='#{data.id}'] input[type='checkbox']").bootstrapSwitch()
        new Requisition.FlashMessage("Item added", "alert-success")
      .fail ->
        window.location.reload()

    $("#new-item").on "ajax:error", (event, jqXHR, errorThrown) ->
      msg = jqXHR.getResponseHeader("X-Message")
      new Requisition.FlashMessage(msg, "alert-danger") if msg?
      data = JSON.parse(jqXHR.responseText)
      return unless data?
      $(data.error_messages).each (index, item) ->
        new Requisition.FlashMessage(item.message, "alert-danger")
