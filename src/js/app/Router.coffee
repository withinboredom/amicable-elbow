App.Router.map ->
  @resource 'app', ->
    @resource "new", ->
      @resource "appPack", ->
        @route "new"

App.AppNewRoute = Ember.AuthenticatedRoute.extend()