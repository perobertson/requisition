$(document).on "page:change", ->
  if $("body[data-controller=inventory][data-action=index]").get 0
    $("input[type='checkbox']").bootstrapSwitch()
    $("input[type='checkbox']").on 'switchChange.bootstrapSwitch', (event, state) ->
      item_id = $(this).parents(".item-container").data "item-id"
      $.ajax "/api/items/#{item_id}",
        type: "put"
        contentType: "application/json"
        data: JSON.stringify item: for_sale: state
