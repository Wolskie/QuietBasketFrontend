# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.Application ||= {}

# Clear the map of the markers.
#
Application.clearMarkers = ->
  i = 0
  while i < Application.mapMarkers.length
    Application.mapMarkers[i].setMap(null)
    i++

  # Remove the map markers.
  Application.mapMarkers = []

Application.addDeviceMapMarker = (data) ->
  console.log("addMarker() [ENTRY]")
  console.log("addMarker() [data=#{data}]")

  # If we dont want to keep history
  # we clear the markers.
  #
  if gon.deviceSettings.showHistory == false
    Application.clearMarkers()

  # Add Marker to the map to show the
  # most recent log.
  #
  marker = new (google.maps.Marker)(
    map: Application.deviceMap
    position:
      lat: parseFloat(data.latitude)
      lng: parseFloat(data.longitude)
      animation: google.maps.Animation.DROP
    title: "Time: #{data.created_at}")

    # Add this marker to the array of markers
  Application.mapMarkers.push(marker)

  # Draw a circle of 100 metres around the
  # marker, to show general innacuracy.
  #
  circle = new (google.maps.Circle)(
    map: Application.deviceMap
    strokeWeight: 0
    fillOpacity: 0.1
    radius: 10)

  # Bind the circle to the marker.
  #
  circle.bindTo 'center', marker, 'position'

  # Center the map agains the latest marker
  #
  Application.deviceMap.panTo(marker.getPosition())

  console.log("lat=#{parseFloat(data.latitude)}")
  console.log("lng=#{parseFloat(data.longitude)}")
  console.log("addMarker() [EXIT]")

Application.initMap = ->
  console.log("initMap() [ENTRY]")
  Application.deviceMap = new (google.maps.Map)(document.getElementById('map'),
    center:
      lat: -25.363
      lng: 131.044
    zoom: 17)
  console.log("initMap() [EXIT]")
  return

Application.initDeviceHistory = ->
  console.log("initDeviceHistory() [ENTRY]")

  # Check if the device has history display enabled.
  if gon.deviceSettings.showHistory

    # Loop Over all the history objects and
    # add them to the map as a marker.
    #
    for position in gon.deviceSettings.history
      do (position) ->
        Application.addDeviceMapMarker(position)
  else
    # Put the last piece of history on the map
    console.log(gon.deviceSettings.history[gon.deviceSettings.history.length - 1])
    Application.addDeviceMapMarker(gon.deviceSettings.history[gon.deviceSettings.history.length - 1])

  # Exit
  console.log("initDeviceHistory() [EXIT]")

documentReady = ->
  console.log("documentReady() [ENTRY]")

  # Array to store current markers in
  Application.mapMarkers = []

  # If there is no map element on the page
  # we dont wan to load the map.
  #
  if document.getElementById("map")?
    console.log("documentReady() Initialize device map")
    Application.initMap()
    Application.initDeviceHistory()

  console.log("documentReady() [EXIT]")

$(document).ready(documentReady)
$(document).on('turbolinks:load', documentReady)
