onClickEvent = (e) ->
  list_item = e.target.closest('[data-event-slug]')
  return unless list_item?
  stopper = window.getComputedStyle(list_item.querySelector('.scroll-stopper'), ':after').getPropertyValue('content')
  e.preventDefault() if stopper
  unless list_item.classList.contains('active')
    active_event_slug = list_item.dataset.eventSlug
    activateEvent(active_event_slug, stopper)

activateEvent = (slug) ->
  $('[data-event-slug]').removeClass('active')
  $("[data-event-slug='#{slug}']").addClass('active')

document.querySelector('.events-list')?.addEventListener('click', onClickEvent)
