###
Handle logins
###

Ember.User = Ember.Object.extend
  userId: null
  token: null
  name: null
  nick: null
  picture: null
  identities: null
  init: () ->
    @_super()
    client.currentUser =
      userId: @get "userId"
      mobileServiceAuthenticationToken: @get "token"
  baseObj: ->
    return {
      userId: @get "userId"
      token: @get "token"
      name: @get "name"
      nick: @get "nick"
      picture: @get "picture"
      identities: @get "identities"
    }

if window.location.hash.match /^#access_token/

  widget = new Auth0Widget
    domain:           'appti2ude.auth0.com'
    clientID:         '4QBrlEZHS38TjIeyubMXCasvau2bJALW'
    callbackURL:      'http://appti2ude.com/'
    callbackOnLocationHash: true

  widget.parseHash(window.location.hash, (profile, id_token, access_token, state) ->
    widget.getClient().getDelegationToken("TiM6jLgzB6kRD28zrnoB9XsiIAP9vKme", id_token, { scope: "openid" }, (err, delegationResult) ->
      App.user = Ember.User.create
        userId: profile.user_id
        token: delegationResult.id_token
        name: profile.name
        nick: profile.nickname
        picture: profile.picture
        identities: profile.identities
      App.LoginStateManager.send "login"

      if App? and App.LoginStateManager?
        window.location.hash = "#/app/new"
        window.location.hash.substring 1

      $.cookie "currentUser", JSON.stringify(App.user.baseObj())
    ))

  window.location.hash = "#/app/new"
  window.location.hash.substring 1

###
  End logins
###

###
  Create the application
###
window.App = Ember.Application.create()

###
  Temp: todo: Create fixture adapter for testing
###
App.ApplicationAdapter = DS.FixtureAdapter.extend()

###
  Handles authenticated state
###
App.LoginStateManager = Ember.StateManager.create
  initialState: (->
    if $.cookie("currentUser")? and not App.user?
      App.user = Ember.User.create(JSON.parse($.cookie("currentUser")))

    if client.currentUser?
      "Authenticated"
    else
      "NotAuthenticated")()

  completed: false

  Authenticated: Ember.State.create
    enter: ->
      console.log "enter #{@name}"
    logout: (manager, context) ->
      manager.transitionTo "NotAuthenticated"
  NotAuthenticated: Ember.State.create
    enter: ->
      console.log "enter #{@name}"
    login: (manager, credentials) ->
      console.log credentials
      manager.transitionTo "Authenticated"

###
  An authenticated controller
###
Ember.AuthenticatedController = Ember.Controller.extend
  authStateBinding: Ember.Binding.oneWay "App.LoginStateManager.currentState.name"
  authState: null

  pictureBinding: "App.user.picture"
  picture: null

  nickBinding: Ember.Binding.oneWay "App.user.nick"
  nick: null

  isAuthenticated: (->
    if @get("authState") is "Authenticated"
      #pbinding = Ember.Binding.from(@pictureBinding).to("App.user.picture")
      #pbinding.connect @
      Ember.bind @, "picture", "App.user.picture"
      #nbinding = Ember.Binding.from(@nickBinding).to("App.user.nick")
      #nbinding.connect @
      Ember.bind @, "nick", "App.user.nick"

      console.log @get("nick")

      true
    else
      false
  ).property "authState"

###
  An authenticated route
###
Ember.AuthenticatedRoute = Ember.Route.extend
  authStateBinding: Ember.Binding.oneWay "App.LoginStateManager.currentState.name"
  authState: null

  isAuthenticated: (->
    (@get("authState") is "Authenticated")
  ).property "authState"

  beforeModel: ->
    if not @get("isAuthenticated")
      @transitionTo "index"

###
  The application controller
###
App.ApplicationController = Ember.AuthenticatedController.extend
  actions:
    login: (provider) ->
      widget = new Auth0Widget
        domain:           'appti2ude.auth0.com'
        clientID:         '4QBrlEZHS38TjIeyubMXCasvau2bJALW'
        callbackURL:      'http://appti2ude.com/'
        callbackOnLocationHash: true

      widget.signin()

    logout: ->
      $.removeCookie "currentUser"
      App.LoginStateManager.send "logout"