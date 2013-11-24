$ ->
  A.loadMap()
  $(window).resize () ->
      A.updateMapDimensions()
  $('#search-form').on 'ajax:beforeSend', () ->
    $('.loading').removeClass('hide')
  $('#search-form').on 'ajax:success', (status, xhr) ->
    $('.alert').remove()
    A.updateUrl xhr.url, xhr.title
    if xhr.museums.length > 0
      A.loadMarkers(xhr.museums)
      A.setMapCenter(xhr.museums)
      A.setMuseumListWidth()
    else
      A.clearMarkers()
      $('.loading').addClass('hide')
      $('body').prepend(xhr.flash_message)
    
  $('body').on 'click', '.museum-list > li', () ->
    A.scrollToRelatedMarker(this)

window.A = {
  markers : []
  markerLayer : null
  updateMapDimensions : () ->
    $('#map-container')
      .height($(window).height() - $('.navbar').height() - 140)
      .width($(window).width())
  loadMap : () ->
    this.updateMapDimensions()
    window.map = L.map('map-container').setView([51.505, -0.09], 3)
    map.addLayer new L.StamenTileLayer('toner-lite')
    $('#search-form').trigger('submit') 
  loadMarkers : (museums) ->
    $('#museum-carousel').html('')
    this.clearMarkers()
    $.each museums, (index, museum) ->
      marker = L.marker([museum.latitude, museum.longitude], {
        clickable : true
        properties: {
          dialogLink: museum.dialog_link
          id : museum.id
          title : museum.name
        }
      })
      A.loadMarker(marker)
    this.markerLayer = L.featureGroup(this.markers)
    this.markerLayer.addTo(map)
    $('.loading').addClass('hide')
    $.each museums, (index, museum) ->
      A.loadMuseum(museum)
  loadMarker : (marker) ->
    this.markers.push marker
    marker.on 'click', () ->
      $('.loading').removeClass('hide')
      A.carousel.setActive(marker)
      $.ajax({
        url: this.options.properties.dialogLink
        dataType: 'script'
      })
  clearMarkers : () ->
    map.removeLayer(this.markerLayer) if this.markerLayer != null
    this.markers = []      
  loadMuseum : (museum) ->
    $('#museum-carousel').append museum.infobox
  setMuseumListWidth: () ->
    totalWidth = 0
    $('#museum-carousel > li').each (index) ->
        totalWidth += parseInt($(this).width(), 10)
    $('#museum-carousel').width(totalWidth)
  setMapCenter: (museums) ->
    map.fitBounds this.markerLayer.getBounds(), ->
      map.zoomOut()
  scrollToRelatedMarker: (museum) ->
    $(museum).data('markerID')
  updateUrl : (url, title) ->
    history.pushState window.reload, title, url
  loadMuseumDialogue : (dialogueBody) ->
    $('#full-map').addClass('blurred')
    $('.overlay, .dialogue').show()
    $('.dialogue-main').html(dialogueBody)
}

window.A.carousel = {
  setActive : (marker) ->
    $('.museum-list > li').removeClass('active')
    $('.museum-' + marker.options.id).addClass('active')
  scrollLeft : () ->

  scrollRight : () -> 

  scrollToActive : () ->


}