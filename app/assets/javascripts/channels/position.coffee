window.Application ||= {}

App.position = App.cable.subscriptions.create "PositionChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    json = JSON.parse(data)
    Application.addDeviceMapMarker(data)
