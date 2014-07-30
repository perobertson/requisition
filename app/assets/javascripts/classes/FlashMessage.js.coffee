class @Requisition.FlashMessage

  #
  # Public methods
  #

  constructor: (message, type, autoHide = false) ->
    Requisition.FlashMessage.showMessage(message, type, autoHide)

  remove: ->
    Requisition.FlashMessage.hideAlerts()

  #
  # Static methods
  #

  @showMessage: (message, type, autoHide = false) ->
    msgAlert =$("<div class='alert #{type} alert-dismissable col-md-offset-2 col-md-8'>
      #{message}
      <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>
    </div>")
    $(".page-alert .row").show().append(msgAlert)

    Requisition.FlashMessage.hideAlerts() if autoHide

  @hideAlerts: (delay = 5000) ->
    window.setTimeout ->
      $(".page-alert .row").slideUp(500, -> $(this).empty())
    , delay
