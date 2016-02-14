toThumb = ->
  root = $(this).attr('src')
  $(this).attr('src', "#{root}s.jpg")
    .data('src', "#{root}")

wrapWithFluidbox = ->
  root = $(this).data('src')
  link = $("<a class='fluidbox'>").attr('href', "#{root}.jpg")
  $(this).wrap(link)

$('.imgur')
  .map(toThumb)
  .map(wrapWithFluidbox)

$('.fluidbox').fluidbox()

activateEvent = (slug, scrollTo) ->
  $('[data-event-slug]').removeClass('active')
  $("[data-event-slug='#{slug}']").addClass('active')
  if scrollTo
    target = $("##{slug}")
    top = $('.travel-info').scrollTop() + target.position().top
    $('.travel-info').animate(scrollTop: top)

onClickEvent = (e) ->
  list_item = e.target.closest('[data-event-slug]')
  return unless list_item?
  stopper = window.getComputedStyle(list_item.querySelector('.scroll-stopper'), ':after').getPropertyValue('content')
  e.preventDefault() if stopper
  unless list_item.classList.contains('active')
    active_event_slug = list_item.dataset.eventSlug
    activateEvent(active_event_slug, stopper)

document.querySelector('.travel-list')?.addEventListener('click', onClickEvent)

window.findActiveSection = ->
  $('.travel-info section').filter ->
    $(this).position().top < 1
  .last()

onScrollTravel = ->
  section = findActiveSection()
  slug = section.data('event-slug')
  activateEvent(slug)

$('.travel-info').on('scroll', $.throttle(50, onScrollTravel))
