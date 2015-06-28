window.Lvhs =
  Libs:
    Layzr:
      init_or_update: ->
        if @layzr
          @layzr.updateSelector()
        else
          @layzr = new Layzr()

  onLoad: ->
    $(document).on 'ready page:load page:restore'

