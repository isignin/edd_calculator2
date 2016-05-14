_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$  = $
moment = require 'moment'
Pikaday = require 'pikaday'

class InputView extends Backbone.View
  el: "#inputBlock"

  events:
    "click button#calculate": "calculate"
    "click button#clear": "clear"
    "change #randomize_date": "convertRandomizeDate"
    "change #lmp_date": "convertLMPDate"
    "change #lmp_date_unknown": "lmpDateUnknown"
    "change #edd_us": "eddUS"

  convertRandomizeDate: (e) ->
    if($("#randomize_date").val() != "" ) then randomize_date = @convertToDate('#randomize_date')

  convertLMPDate: (e) ->
    if ($("#lmp_date").val() != "")
      lmp_date = @convertToDate('#lmp_date')
      $("#lmp_date_unknown").prop('checked', false)
    else
      lmp_date = ""

  lmpDateUnknown: (e) ->
    if($(this).is(':checked')) then $("#lmp_date").val("")

  eddUS: (e) ->
    edd_us = @convertToDate('#edd_us')
	
  calculate: (e) =>
    if(Env.LMPOnly)
      if ($('#lmp_date').val() != "")
        edd_lmp = lmp_date =  @convertToDate('#lmp_date')
        edd_lmp.add(280,'days')
        ga_lmp = current_date.diff(lmp_date, 'days')
        $("#edd_lmp").val(format_date_as_string(edd_lmp))
        $("#ga_lmp").val(getGestationalAgeStr(ga_lmp))
      else
        displayErrorMsg(curLang.errorMsg9)
    else
      if (@validateInputs())
        if ($("#lmp_date_unknown").is(":checked"))
          ga_lmp = 0
          edd_lmp = "Unknown"
          $("#edd_lmp").val(edd_lmp)
        else
          edd_lmp = lmp_date =  @convertToDate('#lmp_date')
          edd_lmp.add(280,'days')
          ga_lmp = current_date.diff(lmp_date, 'days')
          $("#edd_lmp").val(format_date_as_string(edd_lmp))
          $("#ga_lmp").val(getGestationalAgeStr(ga_lmp))
        ga_us = (parseInt($("#ga_us_weeks").val())*7)+parseInt($("#ga_us_days").val())
        ga_us_proj = ga_us + current_date.diff(us_date, 'days')
        lmp_us = us_date
        lmp_us.subtract(ga_us, 'days')
        edd_us = lmp_us
        edd_us.add(280, 'days')
        $("#errorMsg").hide()
        edd_choice_update()
        eligibility()
      else
        $(".result_input").val("")
        $("#errorMsg").show()

  clear: (e) =>
    $(".result_input").val("")
    $(".datepicker").val("")
    $(".gestational_us").val("")
    $("#eligibility").html("")
    $("#patient-kit").html("")
    $("#lmp_date_unknown").prop('checked', false)
    $("#eligible-msg").hide()
    $("#errorMsg").hide()
    $("#no_dates").html(Env.currentLang.comment1)

  render: =>
    @$el.html "
       <div class='col-xs-5 col-md-5'>
          <div class='question-block'> </div><br />
          <div class='question-block'>
            <div class='question' id='today'>Today's Date: </div>
            <input type='text' id='current_date' readonly>
          </div>
          <div class='question-block'>
            <div class='question' id='LMPDate'>Date of LMP: </div>
            <div class='aspQ'>(ASP01 Q.A7 <span class='word-or'>or</span> ASP05 Q.A1)</div>
            <input type='text' id='lmp_date' class='datepicker'><br />
            <input type='checkbox' id='lmp_date_unknown'> <span id='unknown'>Unknown</span>
          </div>
          <div class='fullCalculator'>
            <div class='question-block'>
              <div class='question' id='USDate'>Date of US Exam: </div>
              <div class='aspQ'>(ASP05 Q.B1)</div>
              <input type='text' id='us_date' class='datepicker'>
            </div>
            <div class='question-block'>
              <div class='question' id='GA-US'>GA by US: </div>
              <div class='aspQ'>(ASP05 Q.B2)</div>
              <input type='number' id='ga_us_weeks' class='gestational_us' min='6' max='14'> <span id='labelWeeks'>Weeks</span> 
              <input type='number' id='ga_us_days' class='gestational_us' min='0' max='6'> <span id='labelDays'>Days</span>
            </div>
            <div class='question-block'>
                <div class='question' id='DateRandomization'>Date of Randomization: </div>
                <div class='aspQ'>(ASP05 Q.C1)</div>
                <input type='text' id='randomize_date' class='datepicker'>
            </div>
          </div>
          <div class='question-block'>	 
            <button id='calculate' class='btn btn-warning'>Calculate</button>&nbsp 
            <button id='clear' class='btn btn-success'>Clear</button>
          </div>
       </div>
    "
    lmpDatePicker = new Pikaday
      field: $('.datepicker')[0]
      position: 'bottom right'
      reposition: false

    usDatePicker = new Pikaday
      field: $('.datepicker')[1]
      position: 'bottom right'
      reposition: false

    randomizeDatePicker = new Pikaday
      field: $('.datepicker')[2]
      position: 'bottom right'
      reposition: false

    $('#current_date').val(Env.currentDate)

  convertToDate: (cdate) ->
    moment($(cdate).val()).format(Env.dateFormat) 

  validateInputs: () ->
    valid_input = true
    errMsg = ""
    if ($("#lmp_date").val() == "" && !($("#lmp_date_unknown").is(':checked')))
      errMsg = errMsg + "[ "+curLang.errorMsg1+" ] "
    if ($("#us_date").val() == "")
      errMsg = errMsg + "[ "+curLang.errorMsg2+" ] "
    else
      us_date = @convertToDate($('#us_date').val())
      if (moment(us_date).valueOf() > moment(current_date).valueOf())
        errMsg = errMsg + "[ "+curLang.errorMsg6+" ]"
    if ($("#ga_us_weeks").val() == "" || $("#ga_us_days").val() == "")
      errMsg = errMsg + "[ "+curLang.errorMsg3+" ] "
    else
      ga_wks = parseInt($("#ga_us_weeks").val())
      ga_days = parseInt($("#ga_us_days").val())
      if(ga_wks < 6 || ga_wks > 14)
        errMsg = errMsg + "[ "+curLang.errorMsg7+" ] "
      if (ga_days < 0 || ga_days > 6)
        errMsg = errMsg + "[ "+curLang.errorMsg8+" ] "
      else
        if (ga_wks == 14 && ga_days == 6)
          errMsg = errMsg + "[ "+curLang.errorMsg8+" ]"

    if ($("#randomize_date").val() == "")
      errMsg = errMsg + "[ "+curLang.errorMsg4+" ] "
    else
      randomize_date = @convertToDate($('#randomize_date').val())
      if (moment(randomize_date).valueOf() < moment(current_date).valueOf())
        errMsg = errMsg + "[ "+curLang.errorMsg5+" ]" 

    if (errMsg !="") then valid_input = false
    
    @displayErrorMsg(errMsg)
    return valid_input;

  displayErrorMsg: (msg) ->
    $("span#myAlert").text(msg)
    $(".errorMsg").show()
 
module.exports = InputView