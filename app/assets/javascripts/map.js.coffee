$ ->
  A.loadMap()
  $(window).resize () ->
      A.updateMapDimensions()
  $('#search-form').on 'ajax:beforeSend', () -> 
    $('.loading').removeClass('hide')
  $('#search-form').on 'ajax:success', (status, xhr) ->
    $('.loading').addClass('hide')
    A.loadMarkers(xhr.museums)

A = {
  updateMapDimensions : () ->
    $('#map-container')
      .height($(window).height() - $('.navbar').height())
      .width($(window).width())
  loadMap : () ->
    this.updateMapDimensions()
    window.map = L.map('map-container').setView([51.505, -0.09], 4)
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution : '<a href="http://www.openstreetmap.org/">Open Street Maps</a>'
      maxZoom: 18
    }).addTo(map)
    #map.addLayer new L.StamenTileLayer('watercolor')
    $('#search-form').trigger('submit')
  loadMarkers : (museums) ->
    console.log(museums)
    this.clearMarkers()  
    $.each museums, (index, museum) ->
      marker = L.marker([museum.latitude, museum.longitude], {
        clickable : true
      })
      marker.addTo(map)
      markers.push marker
      marker.on 'click', () ->
        console.log "hello"
  clearMarkers : () ->
    if typeof window.markers != 'undefined'
      $.each window.markers, (index, marker) -> 
        map.removeLayer(marker)
    window.markers = []
} 