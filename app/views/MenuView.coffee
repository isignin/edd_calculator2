_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$  = $
Cookies = require 'js-cookie'

class MenuView extends Backbone.View
  el: "#menuHeader"

  events:
    "click button#initial": "initial"
    "click button#initial": "randomization"
    "click img#english": "english"
    "click img#french": "french"
    "click img#spanish": "spanish"
    "click img#sync": "sync"
    "click img#help": "help"

  initial: (e) ->
    $(".fullCalculator").slideUp()
    $("#ga_lmp_section").show()
    Env.LMPOnly = true

  randomization: (e) ->
    $(".fullCalculator").slideDown()
    $("#ga_lmp_section").hide()
    Env.LMPOnly = false

  english: (e) =>
    e.preventDefault
    @changeLanguage('En')

  french: (e) =>
    e.preventDefault
    @changeLanguage('Fr')

  spanish: (e) =>
    e.preventDefault
    @changeLanguage('Es')
	
  sync: (e) =>
    e.preventDefault
    window.applicationCache.update()
    window.location.reload()
	
  help: (e) =>
    e.preventDefault	

  changeLanguage: (lang) ->
    $("#spanish").show()
    $("#english").show()
    $("#french").show()
    switch lang
      when 'En' then $("#english").hide()
      when 'Fr' then $("#french").hide()
      when 'Es'then $("#spanish").hide()
      else $("#english").hide()
    $("#errorMsg").hide();
    Cookies.set("language",lang, 365);
    Env.currentLang = lang;
    $("#html-text").load("help-#{lang.lowercase}.html");

  render: =>
    @$el.html "
          <div id='calc-type'>
            <button id='initial' class='btn btn-xs btn-primary'>Initial</button>
            <button id='randomization' class='btn btn-xs btn-primary'>Randomization</button>
          </div>
          <div id='menuButtons'>
             <img src='images/en-icon.png'  id='english' title='English'> 
             <img src='images/fr-icon.png'  id='french' title='Française'>
             <img src='images/es-icon.png'  id='spanish' title='Español'>  
             <img src='images/sync-icon.png'  id='sync' title='Sync for Updates'>
             <a data-toggle='modal' data-target='#helpModal'><img src='images/help_icon.png' id='help' title='Click for Instructions'></a> 
          </div>
    "
module.exports = MenuView
