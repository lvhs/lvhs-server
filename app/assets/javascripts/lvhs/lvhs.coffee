window.Lvhs = {
  Libs: {
    Layzr:
      init_or_update: ->
        if @layzr
          @layzr.updateSelector()
        else
          @layzr = new Layzr()
  }
}
