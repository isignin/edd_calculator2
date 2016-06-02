_ = require 'underscore'

$ = jQuery = require 'jquery'
Backbone = require 'backbone'
Backbone.$  = $
moment = require 'moment'

DashboardView = require './views/DashboardView'

class Router extends Backbone.Router
  routes:
    "": "dashboard"
    "*noMatch": "noMatch"

  noMatch: =>
    console.error "Invalid URL, no matching route: "
    $("#content").html "Page not found."
  
  dashboard: () ->
    App.dashboardView = new DashboardView() unless App.dashboardView
    App.dashboardView.render()
    
module.exports = Router