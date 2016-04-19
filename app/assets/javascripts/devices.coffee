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

  console.log("lat=#{parseFloat(data.latitude)}")
  console.log("lng=#{parseFloat(data.longitude)}")
  console.log("addMarker() [EXIT]")

Application.initMap = ->
  console.log("initMap() [ENTRY]")
  Application.deviceMap = new (google.maps.Map)(document.getElementById('map'),
    center:
      lat: -25.363
      lng: 131.044
    zoom: 4)
  console.log("initMap() [EXIT]")
  return

documentReady = ->
  console.log("documentReady() [ENTRY]")
  Application.initMap()
  console.log("documentReady() [EXIT]")

$(document).ready(documentReady)
$(document).on('page:load', documentReady)
