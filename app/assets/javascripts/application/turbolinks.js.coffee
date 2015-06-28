Lvhs.onLoad ->
  Lvhs.Libs.Layzr.init_or_update()
  $('.blink')
    .on 'touchstart', -> $(@).css opacity: 0.5
    .on 'touchend', -> $(@).css opacity: 1
  location.href = 'turbolinks://pageload'
