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
  needs: "search"
  itemController: "searchResult"
  numberResults: (->
    @get "length"
  ).property "length"
  actions:
    select: (id) ->
      selected = @filter (result) ->
        result.get("isSelected") is true
      item.set("isSelected", false) for item in selected

      selection = @filter (result) ->
        result.get("bundleId") is id
      item.set("isSelected", true) for item in selection

      if selection.length > 0
        @set "hasSelection", true
      else
        @set "hasSelection", false

      @set "selectedBundleId", id


###
  Individual search results
###
App.SearchResultController = Em.ObjectController.extend
  shortDescription: (->
    "#{@get("description").substring(0, 256)} [...]"
  ).property "description"
  style: (->
    if @get "isSelected"
      "list-group-item active"
    else
      "list-group-item"
  ).property "isSelected"

###
  Create a new app, if it doesn't already exist
###
App.NewRoute = Em.AuthenticatedRoute.extend
  model: (params) ->

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


App.NewController = Em.ArrayController.extend
  actions:
    search: ->

  searchTermUrl: (->
    encodeURIComponent @get "searchTerm")
    .property "searchTerm"
  numberResults: (->
    @get("length"))
    .property "@length"