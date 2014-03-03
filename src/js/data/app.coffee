App.App = DS.Model.extend
  id: DS.attr "string"
  createdAt: DS.attr "date",
    defaultValue: -> new Date()
  displayName: DS.attr "string"
  perHour: DS.attr "number"
  toComplete: DS.attr "number"
  unlockAll: DS.attr "number"
  subscription: DS.attr "number"
  category: DS.attr "string"