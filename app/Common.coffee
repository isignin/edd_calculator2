moment = require 'moment'
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
    return moment(tdate,Env.dateFormat).format(Env.dateFormat)
  
  @biweekly_visits: (options) ->
    edd_projected = options.edd_projected
    randomize_date = options.randomize_date
    final_dose = @format_date_as_string(edd_projected.subtract(4*7, 'days').format('DD-MM-YYYY'))
    bw = []
    for i in [1..15]
      bwv = randomize_date.clone().add(i*14,'days')
      bw[i] = @format_date_as_string(bwv)
      
    $("#visit_1").val(bw[1])
    $("#visit_2").val(bw[2])
    $("#visit_3").val(bw[3])
    @bi_weekly_fulllist(bw)
    $("#final-dose").html(final_dose)
    @bpMonitor(edd_projected)
    @hbMonitor(randomize_date, edd_projected)
    return

  @bi_weekly_fulllist: (bw) ->
    listing = "<table class='table'><thead><tr>"
    listing += "<th id='visit_no'> #{App.curLang.visitNo} </th><th class='visit_planned''> #{App.curLang.plannedDate} </th>"
    listing += "</tr></thead><tbody>"
    for i in [1..15]
      listing += "<tr><td>#{i}</td><td>#{bw[i]}</td></tr>"
    listing += "</tbody></table>"
    $("#listings").html(listing)

  @bpMonitor: (eddProj) =>
    bp = []
    bp[0] = ""
    bp[1] = "#{@format_date_as_string(eddProj.subtract(24*7,'days'))}<br/>#{ @format_date_as_string(eddProj.subtract(20*7,'days'))}"
    bp[2] = "#{@format_date_as_string(eddProj.subtract(12*7, 'days'))}<br/>#{@format_date_as_string(eddProj.subtract(10*7,'days'))}"
    bp[3] = @format_date_as_string(eddProj.subtract(6*7, 'days'))
    bp[4] = @format_date_as_string(eddProj.subtract(4*7, 'days'))
    bp[5] = @format_date_as_string(eddProj.subtract(2*7, 'days'))
    bp[6] = @format_date_as_string(eddProj)
    bp[7] = @format_date_as_string(eddProj.add(2*7,'days'))
    for i in [1..7]
      $("#bp_"+i).html(bp[i]);

  @hbMonitor: (randomizeDate, eddProj) =>
    hb = []
    hb[0] = ""
    hb[1] = @format_date_as_string(randomizeDate.add(4*7, 'days'))
    hb[2] = "#{@format_date_as_string(eddProj.subtract(14*7, 'days'))}<br/>#{@format_date_as_string(eddProj.subtract(10*7,'days'))}"
    $("#hb_1").html(hb[1])
    $("#hb_2").html(hb[2])
    
  @eligibility: () ->
    ga_final = if(App.edd_projected == App.edd_lmp) then App.ga_lmp else App.ga_us_proj
    decision = if(App.ga_final >= 42 && App.ga_final < 98) then App.curLang.eligible else App.curLang.notEligible
    eligible = if(decision == App.curLang.eligible) then "YES" else "NO"
    $("#eligibility").html(decision);
    @patient_kit(eligible);


  @patient_kit: (eligibility) ->
    if (eligibility == "YES")
      patient_kit = if(ga_final < 70) then App.curLang.select15 else App.curLang.select14
      $("#eligible-msg").removeClass().addClass("green-style")
    else
      patient_kit = "<span id='warning'>#{App.curLang.donotDispense}</span>"
      $("#biweekly_visit").val("")
      $("#eligible-msg").removeClass().addClass("red-style")

  @clearAll: () ->
    $(".result_input").val("")
    $(".datepicker").val("")
    $(".gestational_us").val("")
    $("#eligibility").html("")
    $("#patient-kit").html("")
    $("#lmp_date_unknown").prop('checked', false)
    $("#eligible-msg").hide()
    $("#errorAlert").hide()
    $("#no_dates").html(Env.currentLang.comment1)
    
module.exports = Common