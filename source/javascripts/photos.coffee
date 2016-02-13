packImages = ->
  $('.photo-grid').css('width', '')
  .packery
    layoutMode: 'packery'

right = (el) ->
  $(el).position().left + $(el).outerWidth()

rightmostEdge = (elements) ->
  Math.max.apply(null, elements.map(right))

centerPhotoGrid = ->
  photos = $('.photo').toArray()
  width = $('.photo-grid').width()
  emptySpace = width - rightmostEdge(photos)
  $('.photo-grid').css
    width: width - emptySpace
    left: emptySpace/2

$('.photo-grid').on('layoutComplete', centerPhotoGrid)
$('.photo-grid img').on('load', $.debounce(100, packImages))
$(window).on('resize', $.debounce(100, packImages))
