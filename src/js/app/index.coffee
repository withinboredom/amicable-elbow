App.IndexRoute = Ember.Route.extend
  model: ->
    return @store.find('app')