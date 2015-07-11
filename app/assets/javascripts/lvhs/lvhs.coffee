window.Lvhs =
  Libs:
    Layzr:
      init_or_update: ->
        if @layzr
          @layzr.updateSelector()
        else
          @layzr = new Layzr()

  onLoad: (cb) ->
    $(document).on 'ready page:load page:restore', cb
