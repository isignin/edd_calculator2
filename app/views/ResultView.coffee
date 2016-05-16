_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
Backbone.$  = $
Common = require '../Common'

class ResultView extends Backbone.View
  el: "#resultBlock"

  events:
    "click button#calculate": "calculate"
    "click button#clear": "clear"

  calculate: (e) =>

  clear: (e) =>

  render: =>
    @$el.html "
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
							   <span class='aspQ'>(ASP05 Q.C5)</span></div>
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
		   </div>
		   <div class='col-xs-1 col-md-1'></div>  
		  </div>
    "
    edd_choice_update: () ->
      if (edd_lmp == "Unknown")
        edd_projected = edd_us
      else
        lmp_gestational_week = Math.floor(ga_lmp / 7)
        days_diff = Math.abs(ga_lmp - ga_us_proj)	  
        switch true
          when (lmp_gestational_week < 9) then edd_projected = days_diff <= 5 ? edd_lmp : edd_us
          when (lmp_gestational_week >= 9 && lmp_gestational_week < 14)
            if edd_projected = days_diff <= 7 then edd_lmp else edd_us
          else edd_projected = edd_us

      ga_proj = if (edd_projected == edd_us) then ga_us_proj else ga_lmp
      last_day_to_randomize = minusDays(edd_projected, 183)
      $('#gestational_age_proj').val(Common.getGestationalAgeStr(ga_proj))
      $('#edd_projected').val(Common.format_date_as_string(edd_projected))
      $('#last_randomization_date').val(Common.format_date_as_string(last_day_to_randomize))
  	  biweekly_visits()
    }
    
module.exports = ResultView