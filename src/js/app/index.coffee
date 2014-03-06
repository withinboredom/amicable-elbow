App.IndexRoute = Ember.Route.extend
  authStateBinding: Ember.Binding.oneWay "App.LoginStateManager.currentState.name"
  authState: null

  isAuthenticated: (->
    (@get("authState") is "Authenticated")
  ).property "authState"

  model: ->
    return @store.find('app')

App.AppRoute = Ember.Route.extend
  actions:
    willTransition: (transition) ->
      if $("a.brand.dropdown-toggle").is(":visible") is true
        $("button.navbar-toggle").click()
      true