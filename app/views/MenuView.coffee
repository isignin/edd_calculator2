_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$  = $
Cookies = require 'js-cookie'
Common = require '../Common'
HelpView = require './HelpView'

class MenuView extends Backbone.View
  el: "#menuHeader"

  events:
    "click button#initial.btn": "initial"
    "click button#randomization.btn": "randomization"
    "click img#english": "english"
    "click img#french": "french"
    "click img#spanish": "spanish"
    "click img#sync": "sync"
    "click img#help": "help"
          
  initial: (e) ->
    Common.clearAll()
    $(".fullCalculator").slideUp()
    $("#ga_lmp_section").show()
    Env.LMPOnly = true

  randomization: (e) ->
    Common.clearAll()
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
    App.HelpView = new HelpView() unless App.HelpView
    App.HelpView.render()	
      
  changeLanguage: (lang) ->
    $("#spanish").show()
    $("#english").show()
    $("#french").show()
    switch lang
      when 'En' then $("#english").hide()
      when 'Fr' then $("#french").hide()
      when 'Es'then $("#spanish").hide()
      else $("#english").hide()
    $("#errorAlert").hide();
    Cookies.set("language",lang, 365);
    Env.currentLang = lang;
    App.curLang = Common.languageSwitch(lang)
    @languageDisplay(App.curLang)
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
  languageDisplay: (curLang) ->
    $("#appTitle").html(curLang.title1)
    $("#results").html(curLang.title2)
    $("#initial").html(curLang.button1)
    $("#randomization").html(curLang.button2)
    $("#calculate").html(curLang.button3)
    $("#clear").html(curLang.button4)
    $("#today").html(curLang.inputLabel1)
    $("#LMPDate").html(curLang.inputLabel2)
    $("#unknown").html(curLang.inputLabel3)
    $("#USDate").html(curLang.inputLabel4)
    $("#GA-US").html(curLang.inputLabel5)
    $("#DateRandomization").html(curLang.inputLabel8)
    $("#labelWeeks").html(curLang.inputLabel6)
    $("#labelDays").html(curLang.inputLabel7)
    $(".word-or").html(curLang.wordOR)
    $(".word-and").html(curLang.wordAND)
    $("#participant").html(curLang.idCARD)
    $("#resultLabel1").html(curLang.resultLabel1)
    $("#resultLabel2").html(curLang.resultLabel2)
    $("#resultLabel3").html(curLang.resultLabel3)
    $("#resultLabel4").html(curLang.resultLabel4)
    $("#resultLabel5").html(curLang.resultLabel5)
    $("#resultLabel6").html(curLang.resultLabel6) 
    $("#resultLabel8").html(curLang.resultLabel8)
    $(".labelVisit").html(curLang.resultLabel7)
    $("#visitModalLabel").html(curLang.title3)
    $("#biweekly_title").html(curLang.title4)
    $("#bp_monitoring").html(curLang.title5)
    $("#hb_monitoring").html(curLang.title6)
    $("#visit_no").html(curLang.visitNo)
    $(".visit_planned").html(curLang.plannedDate)
    $("#no_dates").html(curLang.comment1)
    $(".monitor_visit").html(curLang.resultLabel7)
    $(".visit_planned").html(curLang.plannedDate)
    $("#label9").html(curLang.resultLabel9)
    $(".weeks").html(curLang.weeks)
    $("#bp_monitor0").html(curLang.bp_monitor0)
    $("#hb_monitor0").html(curLang.hb_monitor0)
    $("#hb_monitor1").html(curLang.hb_monitor1)
    $("#hb_monitor2").html(curLang.hb_monitor2)
    $("#error").html(curLang.error)
#    if (typeof ga_proj != "undefined") then $('#gestational_age_proj').val(Common.getGestationalAgeStr(ga_proj))
#    if (typeof ga_lmp != "undefined") then $("#ga_lmp").val(Common.getGestationalAgeStr(ga_lmp))
#    if (typeof eligible != "undefined") then patient_kit(eligible)
    $(".close-btn").html(curLang.close)
    $("#instructions").html(curLang.instructions)
#    $.datepicker.setDefaults($.datepicker.regional[curLang.name.toLowerCase()])

module.exports = MenuView
