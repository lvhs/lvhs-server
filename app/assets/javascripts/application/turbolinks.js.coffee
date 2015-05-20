$(document).on 'ready page:load page:restore', ->
  $('img.lazy').lazyload?()
  $('.blink')
    .on 'touchstart', -> $(@).css opacity: 0.5
    .on 'touchend', -> $(@).css opacity: 1
  location.href = 'turbolinks://pageload'
