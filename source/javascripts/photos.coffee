MINIMUM_LOAD_TIME = 2000

packImages = ->
  dfd = $.Deferred();
  $('.photo-grid').css('width', '')
    .one('layoutComplete', dfd.resolve)
    .packery
      layoutMode: 'packery'
  dfd

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

thisHasLoaded = ->
  dfd = $.Deferred();
  if this.naturalHeight
    dfd.resolve()
  else
    $(this).on('load', dfd.resolve)
  dfd

waitABit = ->
  dfd = $.Deferred();
  setTimeout(dfd.resolve, MINIMUM_LOAD_TIME)
  dfd

allImagesLoaded = ->
  $.when.apply(null, $('.photo-grid img').map(thisHasLoaded))

$('.photo-grid').on('layoutComplete', centerPhotoGrid)
$(window).on('resize', $.debounce(100, packImages))
$.when(waitABit(), allImagesLoaded())
  .then(packImages)
  .then -> $(document.body).addClass('loaded')
