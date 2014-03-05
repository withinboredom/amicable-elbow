App.Router.map ->
  @resource 'app', ->
    @resource "search", ->
      @route "results",
        path: ":search_term"
    @resource "new",
      path: "new/:id", ->
        @route "rechargePacks"
        @route "creditPacks"
        @route "subscriptions"
    @route "show",
      path: ":id"
    @route "edit",
      path: ":id/edit"