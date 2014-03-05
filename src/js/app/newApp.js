// Generated by CoffeeScript 1.7.1

/*
  Get Search results from the parameter and build the model
 */

(function() {
  App.SearchResultsRoute = Em.Route.extend({
    model: function(params) {
      console.log(params);
      return this.getResults(params.search_term);
    },
    setupController: function(controller, model) {
      console.log("Model set");
      return controller.set("model", model);
    },
    getResults: function(terms) {
      console.log(terms);
      if ((terms == null) || terms === "undefined") {
        return [];
      } else {
        return $.ajax({
          url: "https://itunes.apple.com/search",
          data: {
            term: terms.replace(/%20/g, '+'),
            country: "US",
            media: "software",
            limit: "5"
          },
          dataType: "jsonp",
          cache: true
        }).then(function(data) {
          return data.results;
        });
      }
    }
  });


  /*
    Handle search submissions
   */

  App.SearchController = Em.Controller.extend({
    actions: {
      submit: function() {
        console.log(this.get("searchTerm"));
        return this.transitionToRoute("search.results", encodeURIComponent(this.get("searchTerm")));
      }
    }
  });


  /*
    Handle the displaying of the results
   */

  App.SearchResultsController = Em.ArrayController.extend({
    numberResults: (function() {
      return this.get("length");
    }).property("@length")
  });

  App.NewRoute = Em.AuthenticatedRoute.extend({
    model: function(params) {
      if ((params.search_term == null) || params.search_term === "undefined") {
        return [];
      } else {
        return $.ajax({
          url: "https://itunes.apple.com/search",
          data: {
            term: encodeURIComponent(params.search_term).replace(/%2520/g, '+'),
            country: "US",
            media: "software",
            limit: "5"
          },
          dataType: "jsonp",
          cache: true
        }).then(function(data) {
          return data.results;
        });
      }
    }
  });

  App.NewController = Em.ArrayController.extend({
    actions: {
      search: function() {}
    },
    searchTermUrl: (function() {
      return encodeURIComponent(this.get("searchTerm"));
    }).property("searchTerm"),
    numberResults: (function() {
      return this.get("length");
    }).property("@length")
  });

}).call(this);

//# sourceMappingURL=newApp.map
