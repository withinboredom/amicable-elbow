App.App = DS.Model.extend
  createdAt: DS.attr "date",
    defaultValue: -> new Date()
  displayName: DS.attr "string"
  perHour: DS.attr "number"
  toComplete: DS.attr "number"
  unlockAll: DS.attr "number"
  subscription: DS.attr "number"
  category: DS.belongsTo "appCategories"
  platform: DS.belongsTo "appPlatforms"
  specialCurrency: DS.hasMany "appCurrencyType"

App.AppPlatforms = DS.Model.extend
  displayName: DS.attr "string"
  apps: DS.hasMany "app"

App.AppCategories = DS.Model.extend
  displayName: DS.attr "string"
  apps: DS.hasMany "app"

App.AppCurrencyType = DS.Model.extend
  displayName: DS.attr "string"
  apps: DS.hasMany "app"
  packs: DS.hasMany "appCurrencyPack"

App.AppCurrencyPack = DS.Model.extend
  displayName: DS.attr "string"
  cost: DS.attr "number"
  exchange: DS.attr "number"
  exchangeCurrency: DS.belongsTo "appCurrencyType"