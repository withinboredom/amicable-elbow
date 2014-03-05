App.Router.map ->
  @resource 'app', ->
    @resource "search", ->
      @route "results",
        path: ":search_term"
    @resource "app", ->
      @route "new"
      @route "show",
        path: ":id"
      @route "edit",
        path: ":id/edit"