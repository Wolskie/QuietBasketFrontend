# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.Application ||= {}

Application.addDeviceMapMarker = (data) ->
  console.log("addMarker: [ENTRY]")
  console.log("addMarker: [data=#{data}]")


Application.initMap = ->
  console.log("initMap() [ENTRY]")
  map = undefined
  map = new (google.maps.Map)(document.getElementById('map'),
    center:
      lat: -34.397
      lng: 150.644
    zoom: 8)
  console.log("initMap() [EXIT]")
  return

documentReady = ->
  console.log("documentReady() [ENTRY]")
  Application.initMap()
  console.log("documentReady() [EXIT]")

$(document).ready(documentReady)
$(document).on('page:load', documentReady)
