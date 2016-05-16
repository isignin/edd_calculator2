Localization = require './Localization'
language = new Localization

class Common
  @getGestationalAgeStr: (gaProj) ->
    gestational_days = gaProj % 7
    gestational_weeks = Math.floor(gaProj / 7)
    days_label = if gestational_days > 1 then App.curLang.inputLabel7 else App.curLang.inputLabel7.slice(0,-1)
    return [String(gestational_weeks), App.curLang.inputLabel6 ,String(gestational_days) , days_label].join(" ")

  @languageSwitch: (lang) ->
    switch lang
      when 'En' then language.EN
      when 'Fr' then language.FR
      when 'Es'then language.ES

  @format_date_as_string: (tdate) ->
    return moment(tdate, Env.dateFormat)

  @biweekly_visits: () ->
    final_dose = @format_date_as_string(minusDays(edd_projected, 4*7))
    bw = [];
    for (var i = 1; i < 16; i++)
      var bwv = addDays(randomize_date, i*14)
      bw[i] = format_date_as_string(bwv)
    $("#visit_1").val(bw[1])
    $("#visit_2").val(bw[2])
    $("#visit_3").val(bw[3])
    bi_weekly_fulllist(bw)
    $("#final-dose").html(final_dose)
    bpMonitor()
    hbMonitor()
    return

  @bi_weekly_fulllist: (bw) ->
    listing = "<table class='table'><thead><tr>"
    listing += "<th id='visit_no'>" + curLang.visitNo +"</th><th class='visit_planned''>"+curLang.plannedDate+"</th>"
    listing += "</tr></thead><tbody>"
    for (var i= 1; i< 16; i++)
      listing += "<tr><td>"+i +"</td><td>" + bw[i] + "</td></tr>"
    listing += "</tbody></table>"
    $("#listings").html(listing)
     
module.exports = Common