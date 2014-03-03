Ember.Handlebars.registerBoundHelper 'money', (value) ->
  accounting.formatMoney(value/100)

Handlebars.registerHelper "login", ->
  widget = new Auth0Widget
    domain:           'appti2ude.auth0.com'
    clientID:         '4QBrlEZHS38TjIeyubMXCasvau2bJALW'
    callbackURL:      'https://appti2ude.auth0.com/mobile'
    callbackOnLocationHash: true
    scope: "openid"

  # authentication result comes back in `window.location.hash`
  widget.parseHash window.location.hash, (profile, id_token, access_token, state) ->
    ###
     #store the profile and id_token in a cookie or local storage
     $.cookie('profile', profile)
     $.cookie('id_token', id_token)
     ###
    console.log profile
    console.log id_token


  widget.signin
    container: 'root'
    chrome: true

  ""