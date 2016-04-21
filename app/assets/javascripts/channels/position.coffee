window.Application ||= {}

App.position = App.cable.subscriptions.create "PositionChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    json = JSON.parse(data)

    console.log("PositionChannel: received: [ENTRY]")
    console.log("PositionChannel: json=#{data}")

    if gon.deviceSettings.realtimeEnabled == false
      console.log("PositionChannel: deviceSettings.realtimeEnabled is false, dont care")
      return

    # If the device is coming in is the one which is
    # selected.
    #
    if json.device_id == Application.selectedDevice
      console.log("PositionChannel: received: json.device_id matches selected device")
      Application.addDeviceMapMarker(json)
    else
      console.log("PositionChannel: received: Ignoring")

    # Exit
    console.log("PositionChannel: received: [EXIT]")
