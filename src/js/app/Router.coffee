App.Router.map ->
  @resource 'app', ->
    @resource "search", ->
      @route "results",
        path: ":search_term"
    @route "new",
      path: "new/:id"
    @route "show",
      path: ":id"
    @route "edit",
      path: ":id/edit"