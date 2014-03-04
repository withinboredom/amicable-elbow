App.Router.map ->
  @resource 'app', ->
    @route "new"

App.AppNewRoute = Ember.AuthenticatedRoute.extend()