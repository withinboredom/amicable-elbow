Ember.Handlebars.registerBoundHelper 'money', (value) ->
  accounting.formatMoney(value/100)