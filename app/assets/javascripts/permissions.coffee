$(document).on "turbolinks:load", ->
  if $("body[data-controller=permissions][data-action=index]").get 0
    $("input[type='checkbox']").bootstrapSwitch()

    $(".users-container").on 'switchChange.bootstrapSwitch', "input[type='checkbox']", (event, state) ->
      self = $(this)
      kind = self.parents(".ability-container").data "ability-kind"
      user_id = self.parents(".user-container").data "user-id"
      user_ability_id = self.data "user-ability-id"

      if state
        $.post "/api/users/#{user_id}/user_abilities",
          user_ability:
            kind: kind
        .done (data, textStatus, jqXHR) ->
          self.data "user-ability-id", data.id
        .fail (jqXHR, textStatus, errorThrown) ->
          window.location.href = window.location.href
      else
        $.ajax
          url: "/api/user_abilities/#{user_ability_id}"
          type: "delete"
        .done (data, textStatus, jqXHR) ->
          self.data "user-ability-id", null
        .fail (jqXHR, textStatus, errorThrown) ->
          window.location.href = window.location.href
