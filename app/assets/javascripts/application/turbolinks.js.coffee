$(document).on 'ready page:load page:restore', ->
  $('img.lazy').lazyload?()
  location.href = 'turbolinks://pageload'
