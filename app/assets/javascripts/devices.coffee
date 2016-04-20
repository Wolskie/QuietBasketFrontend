# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.Application ||= {}

Application.addDeviceMapMarker = (data) ->
  console.log("addMarker() [ENTRY]")
  console.log("addMarker() [data=#{data}]")

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


  # Draw a circle of 100 metres around the
  # marker, to show general innacuracy.
  #
  circle = new (google.maps.Circle)(
    map: Application.deviceMap
    radius: 100
    fillColor: '#AA0000')

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
    zoom: 14)
  console.log("initMap() [EXIT]")
  return

Application.initDeviceHistory = ->
  console.log("initDeviceHistory() [ENTRY]")
  for position in gon.deviceHistory
    do (position) ->
      Application.addDeviceMapMarker(position)
  console.log("initDeviceHistory() [EXIT]")

documentReady = ->
  console.log("documentReady() [ENTRY]")

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
