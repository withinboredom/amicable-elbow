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

      $.cookie "currentUser", JSON.stringify(App.user.baseObj()),
        domain: ".appti2ude.com"

      window.location.href = "http://www.appti2ude.com/#/app/search"
      console.log "Moving routes"
    ))

  window.location.hash = "#/"
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

  authenticationChanged: (->
    if not @get("isAuthenticated")
      @transitionTo "index"
      console.log "Tried accessing authenticated page, redirected to index."
  ).observes "authState"

  beforeModel: ->
    @authenticationChanged()

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
      $.removeCookie "currentUser",
        domain: ".appti2ude.com"
      App.LoginStateManager.send "logout"