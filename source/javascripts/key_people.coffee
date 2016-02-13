onClickPerson = (e) ->
  person = e.target.closest('[data-person-slug]')
  e.preventDefault()
  unless person.classList.contains('active')
    active_person_slug = person.dataset.personSlug
    activatePerson(active_person_slug)

activatePerson = (slug) ->
  $('[data-person-slug]').removeClass('active')
  $("[data-person-slug='#{slug}']").addClass('active')

document.querySelector('.people-choices')?.addEventListener('click', onClickPerson)
