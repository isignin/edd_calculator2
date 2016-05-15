Localization = require './Localization'
language = new Localization

class Common
  @getGestationalAgeStr: (gaProj) ->
    gestational_days = gaProj % 7
    gestational_weeks = Math.floor(gaProj / 7)
    days_label = if gestational_days > 1 then App.curLang.inputLabel7 else App.curLang.inputLabel7.slice(0,-1)
    gestational_weeks + " "+ App.curLang.inputLabel6 +" "+ gestational_days + " " + days_label

  @languageSwitch: (lang) ->
    switch lang
      when 'En' then language.EN
      when 'Fr' then language.FR
      when 'Es'then language.ES

module.exports = Common