# Entry point for creating bundle.js
# Only packages that get required here or inside the packages that are required here will be included in the bundle.js
# New packages are added to the node_modules directory by running 'npm install --save package-name'

global.jQuery = global.$ = require 'jquery'
global._ = require 'underscore'
global.Backbone = require 'backbone'
Backbone.$ = $
jqueryUI = require 'jquery-ui'
Cookies = require 'js-cookie'
moment = require 'moment'
bootstrap = require 'bootstrap'

#Router = require "./Router"
MenuView = require "./views/MenuView"
InputView = require './views/InputView'
ResultView = require './views/ResultView'

global.Env = {
   dateFormat: Cookies.get('dateFormat') || 'DD-MM-YYYY'
   currentLang: Cookies.get('language') || 'En'
   currentDate: ""
   LMPOnly: false	
}
Env.currentDate = moment().format(Env.dateFormat)

# These are the views that will always be shown
menuView = new MenuView
menuView.render()

inputView = new InputView
inputView.render()

resultView = new ResultView
resultView.render()

menuView.changeLanguage(Env.currentLang)

Backbone.history.start()

