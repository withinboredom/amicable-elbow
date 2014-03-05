###
  Get Search results from the parameter and build the model
###
App.SearchResultsRoute = Em.Route.extend
  model: (params) ->
    console.log params
    @getResults params.search_term

  setupController: (controller, model) ->
    console.log "Model set" 
    controller.set "model", model

  getResults: (terms) ->
    console.log terms
    if not terms? or terms is "undefined"
      []
    else
      $.ajax
        url: "https://itunes.apple.com/search"
        data:
          term: terms.replace(/%20/g, '+')
          country: "US"
          media: "software"
          limit: "5"
        dataType: "jsonp"
        cache: true
      .then (data) ->
          data.results

###
  Handle search submissions
###
App.SearchController = Em.Controller.extend
  actions:
    submit: ->
      console.log(@get("searchTerm"))
      @transitionToRoute "search.results", encodeURIComponent(@get("searchTerm"))

###
  Handle the displaying of the results
###
App.SearchResultsController = Em.ArrayController.extend
  numberResults: (->
    @get "length"
  ).property "@length"

App.NewRoute = Em.AuthenticatedRoute.extend
  model: (params) ->
    if not params.search_term? or params.search_term is "undefined"
      []
    else
      $.ajax
        url: "https://itunes.apple.com/search"
        data:
          term: encodeURIComponent(params.search_term).replace(/%2520/g, '+')
          country: "US"
          media: "software"
          limit: "5"
        dataType: "jsonp"
        cache: true
      .then (data) ->
          data.results

App.NewController = Em.ArrayController.extend
  actions:
    search: ->

  searchTermUrl: (->
    encodeURIComponent @get "searchTerm")
    .property "searchTerm"
  numberResults: (->
    @get("length"))
    .property "@length"