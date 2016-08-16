_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$  = $
moment = require 'moment'
Pikaday = require 'pikaday'
Common = require '../Common'
AlertView = require './AlertView'
SchedulesView = require './SchedulesView'
LoginView = require './LoginView'

class DashboardView extends Backbone.View
  initialize: =>
    global.App = 
      edd_projected: "Test"
      us_date: ""
      ga_us_weeks: ""
      ga_us_days: ""
      lmp_date: ""
      randomize_date: ""
      edd_lmp: ""
      edd_us: ""
      lmp_us: ""
      ga_lmp: ""
      ga_us: ""
      ga_us_proj: ""
      ga_final: ""
      edd_lmp_only: ""
      eligible: ""
      version: ""
      curLang: Common.languageSwitch(Env.currentLang)

   
  el: "#content"

  events:
    "click button#calculate": "calculate"
    "click button#clear": "clear"
    "change #randomize_date": "convertRandomizeDate"
    "change #lmp_date": "convertLMPDate"
    "change #lmp_date_unknown": "lmpDateUnknown"
    "change #edd_us": "eddUS"
    "click img#full-list": "ScheduleList"
    "click img#key": "login"
  
  login: (e) ->
    e.preventDefault
    App.LoginView = new LoginView() unless App.LoginView
    App.LoginView.render()
    
  convertRandomizeDate: (e) ->
    if($("#randomize_date").val() != "" ) then App.randomize_date = @convertToDate('#randomize_date')

  convertLMPDate: (e) ->
    if ($("#lmp_date").val() != "")
      App.lmp_date = @convertToDate('#lmp_date')
      $("#lmp_date_unknown").prop('checked', false)
    else
      App.lmp_date = ""

  lmpDateUnknown: (e) =>
    if($('#lmp_date_unknown').is(':checked')) 
      $("#lmp_date").val("").prop('disabled', true)
    else
      $("#lmp_date").prop('disabled', false)

  eddUS: (e) ->
    App.edd_us = @convertToDate('#edd_us')
	
  ScheduleList: (e) =>
    e.preventDefault
    App.SchedulesView = new SchedulesView() unless App.SchedulesView
    App.SchedulesView.render()
    
  calculate: (e) =>
    $("#errorAlert").hide()
    if(Env.LMPOnly)
      if ($('#lmp_date').val() != "")
        App.lmp_date =  @convertToDate('#lmp_date')
        App.edd_lmp = App.lmp_date.clone().add(280,'days')
        App.ga_lmp = Math.abs(moment(Env.currentDate, Env.dateFormat).diff(App.lmp_date, 'days'))
        $("#edd_lmp").val(Common.format_date_as_string(App.edd_lmp))
        $("#ga_lmp").val(Common.getGestationalAgeStr(App.ga_lmp))
      else
        AlertView.displayErrorMsg(App.curLang.errorMsg9)
    else
      if (@validateInputs(App.curLang))
        if ($("#lmp_date_unknown").is(":checked"))
          App.ga_lmp = 0
          App.edd_lmp = "Unknown"
          $("#edd_lmp").val(App.edd_lmp)
        else
          App.lmp_date =  @convertToDate('#lmp_date')
          App.edd_lmp = App.lmp_date.clone().add(280,'days')
          App.ga_lmp = Math.abs(moment(Env.currentDate, Env.dateFormat).diff(App.lmp_date, 'days'))
          $("#edd_lmp").val(Common.format_date_as_string(App.edd_lmp))
          $("#ga_lmp").val(Common.getGestationalAgeStr(App.ga_lmp))
        App.ga_us = (parseInt($("#ga_us_weeks").val())*7)+parseInt($("#ga_us_days").val())
        App.ga_us_proj = App.ga_us + moment(Env.currentDate, Env.dateFormat).diff(App.us_date, 'days')
        App.lmp_us = App.us_date.clone()
        App.lmp_us.subtract(App.ga_us, 'days')
        App.edd_us = App.lmp_us.clone()
        App.edd_us.add(280, 'days')
        $("#errorAlert").hide()
        @edd_choice_update()
        Common.eligibility()
      else
        $(".result_input").val("")
        $("#errorAlert").show()

  clear: (e) =>
    Common.clearAll()

  render: =>
    @$el.html "
      <div class='row'>
        <div class='col-xs-5 col-md-5' id='leftBlock'>
          <div class='question-block'>
            <div class='question' id='today'>Today's Date: </div>
            <input type='text' id='current_date' class='datepicker' readonly><span><a data-toggle='modal' data-target='#loginModal'><img src='images/key-icon.png'  id='key' title='Admin unlock'></a></span>
          </div>
          <div class='question-block'>
            <div class='question' id='LMPDate'>Date of LMP: </div>
            <div class='aspQ'>(ASP01 Q.A7 <span class='word-or'>or</span> ASP05 Q.A1)</div>
            <input type='text' id='lmp_date' class='datepicker' readonly><br />
            <input type='checkbox' id='lmp_date_unknown'> <span id='unknown'>Unknown</span>
          </div>
          <div class='fullCalculator'>
            <div class='question-block'>
              <div class='question' id='USDate'>Date of US Exam: </div>
              <div class='aspQ'>(ASP05 Q.B1)</div>
              <input type='text' id='us_date' class='datepicker' readonly>
            </div>
            <div class='question-block'>
              <div class='question' id='GA-US'>GA by US: </div>
              <div class='aspQ'>(ASP05 Q.B2)</div>
              <input type='number' id='ga_us_weeks' class='gestational_us' min='6' max='14'> <span id='labelWeeks'>Weeks</span> 
              <input type='number' id='ga_us_days' class='gestational_us' min='0' max='6'> <span id='labelDays'>Days</span>
            </div>
            <div class='question-block'>
                <div class='question' id='DateRandomization'>Date of Randomization: </div>
                <div class='aspQ'>(ASP05 Q.C2)</div>
                <input type='text' id='randomize_date' class='datepicker' readonly>
            </div>
          </div>
          <div class='question-block'>	 
            <button id='calculate' class='btn btn-warning'>Calculate</button>&nbsp 
            <button id='clear' class='btn btn-success'>Clear</button>
          </div>
        </div>
        <div class='col-xs-7 col-md-6'>
          <div id='calc_result'>   
            <h3 id='results'>Results: </h3>	
            <div class='result-block'>
              <div class='question'><span id='resultLabel1'>EDD by LMP</span>: <span class='aspQ'>(ASP01 Q.A8)</span></div>
              <input id='edd_lmp' class='result_input' readonly>
            </div>
            <div class='result-block' id='ga_lmp_section'>
              <div class='question'><span id='resultLabel2'>GA by LMP:</span></div>
              <input id='ga_lmp' class='result_input' readonly>
            </div>
            <div class='fullCalculator'>
              <div class='result-block'>
                <div class='question'><span id='resultLabel3'>Projected EDD:</span> <span class='aspQ'>(ASP05 Q.C3)</span></div>
                <input id='edd_projected' class='result_input' readonly>
              </div>		 
              <div class='result-block'>
                <div class='question'><span id='resultLabel4'>GA by Projected EDD</span>: <span class='aspQ'>(ASP05 Q.C4)</span></div>
                <input id='gestational_age_proj' class='result_input' readonly>
              </div> 
              <div class='result-block'>
                <div class='question'><span id='resultLabel5'>Last Date to Randomize</span>:<br /> 
                  <span class='aspQ'>(ASP05 Q.C5)</span>
                </div>
                <input id='last_randomization_date' class='result_input' readonly>
              </div>
              <div class='result-block'>
                  <div class='question'><span id='resultLabel6'>Bi-Weekly Visits: </span> <a data-toggle='modal' data-target='#visitsModal'><img src='images/dates-list.png' id='full-list' title='Full List'></a></div>
                  <div><span class='aspQ'>(ASP05 Q.C9 <span class='word-and'>and</span> <span id='participant'>Participant ID Card</span>)</span></div>
                  <b><span class='labelVisit'>Visit</span> 1: </b><input id='visit_1' class='result_input visits' readonly><br />
                  <b><span class='labelVisit'>Visit</span> 2: </b><input id='visit_2' class='result_input visits' readonly><br />
                  <b><span class='labelVisit'>Visit</span> 3: </b><input id='visit_3' class='result_input visits' readonly>
              </div>
              <div class='result-block'>
                <div><strong><span id='resultLabel8'>Eligibility</span>:</strong> <span class='aspQ'>(ASP05 Q.C6 <span class='word-and'>and</span> ASP05 Q.C7)</span></div> 
                <div id='eligible-msg'> 
                  <div id='eligibility'> </div>
                  <div id='patient-kit'> </div>
                </div>	
              </div>
            </div>
          </div>
          <div class='col-xs-1 col-md-1'></div>  
        </div>
      </div>
    "
    # global.currentDatePicker = new Pikaday
#       field: $('.datepicker')[0]
#       position: 'bottom right'
#       format: 'DD-MM-YYYY'
#       reposition: false
      
    lmpDatePicker = new Pikaday
      field: $('.datepicker')[1]
      position: 'bottom right'
      format: 'DD-MM-YYYY'
      reposition: false

    usDatePicker = new Pikaday
      field: $('.datepicker')[2]
      position: 'bottom right'
      format: 'DD-MM-YYYY'
      reposition: false

    randomizeDatePicker = new Pikaday
      field: $('.datepicker')[3]
      position: 'bottom right'
      format: 'DD-MM-YYYY'
      reposition: false
      
    $('#current_date').val(Env.currentDate)

  convertToDate: (cdate) ->
    convDate = $(cdate).val()
    moment(convDate, Env.dateFormat)

  validateInputs: (curLang) ->
    valid_input = true
    errMsg = ""
    if ($("#lmp_date").val() == "" && !($("#lmp_date_unknown").is(':checked'))) then errMsg = errMsg + "[ #{curLang.errorMsg1} ] "
    if ($("#us_date").val() == "")
      errMsg = errMsg + "[ #{curLang.errorMsg2} ] "
    else
      App.us_date = @convertToDate('#us_date')
      current_date = moment(Env.currentDate, Env.dateFormat)
      if (App.us_date.isAfter(current_date,'day')) then errMsg = errMsg + "[ #{curLang.errorMsg6} ]"

    if ($("#ga_us_weeks").val() == "" || $("#ga_us_days").val() == "")
      errMsg = errMsg + "[ #{curLang.errorMsg3} ] "
    else
      ga_wks = parseInt($("#ga_us_weeks").val())
      ga_days = parseInt($("#ga_us_days").val())
      if(ga_wks < 6 || ga_wks > 14)
        errMsg = errMsg + "[ #{curLang.errorMsg7} ] "
      if (ga_days < 0 || ga_days > 6) then errMsg = errMsg + "[ #{curLang.errorMsg8} ] "
      else
        if (ga_wks == 14 && ga_days == 6) then errMsg = errMsg + "[ #{curLang.errorMsg8} ]"

    if ($("#randomize_date").val() == "")
      errMsg = errMsg + "[ #{curLang.errorMsg4} ] "
    else
      App.randomize_date = @convertToDate('#randomize_date')
      Env.currentDate = @convertToDate('#current_date')
      if (moment(Env.currentDate, Env.dateFormat).isAfter(moment(App.randomize_date),'day')) then errMsg = errMsg + "[ #{curLang.errorMsg5} ]" 

    if (errMsg !="")
      valid_input = false
      AlertView.displayErrorMsg(errMsg)
      
    return valid_input;
  
  edd_choice_update: () ->
    if (App.edd_lmp == "Unknown")
      App.edd_projected = App.edd_us
    else
      lmp_gestational_week = Math.floor(App.ga_lmp / 7)
      days_diff = Math.abs(App.ga_lmp - App.ga_us_proj)	  
      switch true
        when (lmp_gestational_week < 9)
          App.edd_projected = if(days_diff <= 5) then App.edd_lmp else App.edd_us
        when (lmp_gestational_week >= 9 && lmp_gestational_week < 14)
          App.edd_projected = if(days_diff <= 7) then App.edd_lmp else App.edd_us
        else App.edd_projected = App.edd_us
    App.ga_proj = if (App.edd_projected == App.edd_us) then App.ga_us_proj else App.ga_lmp
    last_day_to_randomize = App.edd_projected.clone().subtract(183, 'days')
    $('#gestational_age_proj').val(Common.getGestationalAgeStr(App.ga_proj))
    $('#edd_projected').val(App.edd_projected.format(Env.dateFormat))
    $('#last_randomization_date').val(moment(last_day_to_randomize).format(Env.dateFormat))
    Common.biweekly_visits
      edd_projected: App.edd_projected
      randomize_date: App.randomize_date
      
module.exports = DashboardView