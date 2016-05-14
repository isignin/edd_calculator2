(function() {

  'use strict';

  //var db = new PouchDB('scheduler');
  //var remoteCouch = false;

  //db.changes({
  //	  since: 'now',
  //	  live: true
  //}).on('change', showDocs);
  
  var current_date, lmp_date, us_date, ga_us_weeks, ga_us_days, randomize_date;
  var edd_lmp, edd_us, edd_projected, ga_lmp, ga_proj, ga_us, ga_us_proj, ga_final, lmp_us, edd_lmp_only;
  var version, eligible;
  
  $("#calculate").click(function(){
	  current_date = convertToDate($('#current_date').val());
	  if(edd_lmp_only){
		  if ($('#lmp_date').val() !== "") {
		    lmp_date =  convertToDate($('#lmp_date').val());
		    edd_lmp = addDays(lmp_date,280);
			ga_lmp = daysBetween(current_date, lmp_date);
		    $("#edd_lmp").val(format_date_as_string(edd_lmp));
			$("#ga_lmp").val(getGestationalAgeStr(ga_lmp));
		  } else {
			  displayErrorMsg(curLang.errorMsg9);
		  }	
	  } else {
		  if (validateInputs()){ 
			  if ($("#lmp_date_unknown").is(":checked")) {
				  ga_lmp = 0;
				  edd_lmp = "Unknown";
				  $("#edd_lmp").val(edd_lmp);
			  } else {	
				  lmp_date =  convertToDate($('#lmp_date').val());
				  edd_lmp = addDays(lmp_date,280);
				  ga_lmp = daysBetween(current_date, lmp_date);
				  $("#edd_lmp").val(format_date_as_string(edd_lmp));
				  $("#ga_lmp").val(getGestationalAgeStr(ga_lmp));  
			  };
			  ga_us = (parseInt($("#ga_us_weeks").val())*7)+parseInt($("#ga_us_days").val());
			  ga_us_proj = ga_us + daysBetween(current_date, us_date);
			  lmp_us = minusDays(us_date, ga_us);
			  edd_us = addDays(lmp_us,280); 
			  $(".bs-alert").hide();

			  edd_choice_update();
			  eligibility();
		  
		  } else {
			  $(".result_input").val("");
		      $(".bs-alert").show();
		  };
	  }	  	  
  });
  
  $("#clear").click(function(){
  	 $(".result_input").val("");
	 $(".datepicker").val("");
	 $(".gestational_us").val("");
	 $("#eligibility").html("");
	 $("#patient-kit").html("");
	 $("#lmp_date_unknown").prop('checked', false);
	 $("#eligible-msg").hide();
     $(".bs-alert").hide();
	 $("#no_dates").html(curLang.comment1);
  });
  
  $("#french").click(function(){
	   $("#english").show();
	   $("#spanish").show();
	   $("#french").hide();
	   $(".bs-alert").hide();
	   setCookie("language","Fr", 365);
	   curLang = frLang;
	   $("#html-text").load("help-fr.html");
	   changeLanguage(curLang);
  });
  $("#english").click(function(){
	   $("#english").hide();
	   $("#spanish").show();
	   $("#french").show();
	   $(".bs-alert").hide();
	   setCookie("language","En", 365);
	   curLang = defaultLang;
	   $("#html-text").load("help.html");
	   changeLanguage(curLang);
  });
  $("#spanish").click(function(){
	   $("#spanish").hide();
	   $("#english").show();
	   $("#french").show();
	   $(".bs-alert").hide();
	   setCookie("language","Es", 365);
	   curLang = esLang;
	   $("#html-text").load("help-es.html");
	   changeLanguage(curLang);
  });
  
  $("#initial").click(function(){
	   $(".fullCalculator").slideUp();
	   $("#ga_lmp_section").show();
	   edd_lmp_only = true;
  });
  
  $("#randomization").click(function(){
	   $(".fullCalculator").slideDown();
	   $("#ga_lmp_section").hide();
	   edd_lmp_only = false;
  });
  
  $("#randomize_date").change(function(){
	  if($("#randomize_date").val() !== "" ){
        randomize_date = convertToDate($('#randomize_date').val());
	  }	
  });
  
  $("#lmp_date").change(function(){
	  if ($("#lmp_date").val() !== "") {
  	     lmp_date = convertToDate($('#lmp_date').val());
		 $("#lmp_date_unknown").prop('checked', false);
	  } else {
	  	lmp_date = ""
	  }	 
  });
  
  $("#lmp_date_unknown").change(function(){
  	   if($(this).is(':checked')){
  	   	 $("#lmp_date").val("");
  	   }
  });
  
  $("#edd_us").change(function(){
	  edd_us = convertToDate($('#edd_us').val());
  });
/*  
  $('input.datepicker').change(function(){
     var datestr = $(this).val();
     if(datestr.length == 8){
	   datestr = datestr.substring(0,2)+"-"+datestr.substring(2,4)+"-"+datestr.substring(4);
	   $(this).val(datestr);
     } else if(datestr.length != 10) {
		   alert("Date string must be 8 characters example: 01012016");
     }
  })
*/  
  function getGestationalAgeStr(gaProj){
	  var gestational_days = gaProj % 7;
	  var gestational_weeks = Math.floor(gaProj / 7);
	  var days_label = gestational_days > 1 ? curLang.inputLabel7 : curLang.inputLabel7.slice(0,-1);
	  return (gestational_weeks + " "+ curLang.inputLabel6 +" "+ gestational_days + " " + days_label)
  }
  
  function eligibility(){
	  ga_final = edd_projected === edd_lmp ? ga_lmp : ga_us_proj ;
	  var decision = (ga_final >= 42 && ga_final < 98) ? curLang.eligible : curLang.notEligible;
	  eligible = decision === curLang.eligible ? "YES" : "NO";
	  $("#eligibility").html(decision);
	  patient_kit(eligible);
  }
  
  function patient_kit(eligibility){
	  var patient_kit;
	  if (eligibility == "YES") {
	     patient_kit = ga_final < 70 ? curLang.select15 : curLang.select14;
		 $("#eligible-msg").removeClass().addClass("green-style");
	  }	else {
	  	patient_kit = "<span id='warning'>" + curLang.donotDispense + "</span>";
	    $("#biweekly_visit").val("");
	    $("#eligible-msg").removeClass().addClass("red-style");		
	  }

	  $("#eligible-msg").show();
      $("#patient-kit").html(patient_kit);
  }
  
  function edd_choice_update(){
	  if (edd_lmp === "Unknown") {
	  	edd_projected = edd_us;
	  } else {
		  var lmp_gestational_week = Math.floor(ga_lmp / 7);
		  var days_diff = Math.abs(ga_lmp - ga_us_proj);	  
		  switch(true) {
		  case (lmp_gestational_week < 9):
			  edd_projected = days_diff <= 5 ? edd_lmp : edd_us;
			  break;
		  case (lmp_gestational_week >= 9 && lmp_gestational_week < 14):
			  edd_projected = days_diff <= 7 ? edd_lmp : edd_us;	  
			  break; 
		  default:
			  edd_projected = edd_us;
		  }
      }	
	  ga_proj = edd_projected === edd_us ? ga_us_proj : ga_lmp ;
	  var last_day_to_randomize = minusDays(edd_projected, 183);
	  $('#gestational_age_proj').val(getGestationalAgeStr(ga_proj));
  	  $('#edd_projected').val(format_date_as_string(edd_projected));
	  $('#last_randomization_date').val(format_date_as_string(last_day_to_randomize));
	  biweekly_visits();
  }

  
  function convertToDate(datestr){
     var pattern = /(\d{2})\-(\d{2})\-(\d{4})/;
	 var tdate = new Date(datestr.replace(pattern,'$3-$2-$1'));
	 tdate = new Date(tdate.getUTCFullYear(), tdate.getUTCMonth(), tdate.getUTCDate());
	 return tdate;
  }
  
  function format_date_as_string(tdate){
	  var daystr = ("00" + tdate.getDate()).slice(-2);
	  var monthstr = ("00" + (tdate.getMonth()+1)).slice(-2);
	  return (daystr+"-"+ monthstr +"-"+tdate.getFullYear());
  }
  
  function format_with_month_label(l_date){
	  var mnth = l_date.getMonth();
	  var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      var mnthLabel = months[mnth];
	  return (l_date.getDate()+"-"+ mnthLabel+" " + l_date.getFullYear());
  }
  
  function biweekly_visits(){
	  var final_dose = format_date_as_string(minusDays(edd_projected, 4*7));
	  var bw = [];
	  for (var i = 1; i < 16; i++){
		  var bwv = addDays(randomize_date, i*14);
		  bw[i] = format_date_as_string(bwv);
	  }
	  $("#visit_1").val(bw[1]);
	  $("#visit_2").val(bw[2]);
	  $("#visit_3").val(bw[3]);
	  bi_weekly_fulllist(bw);
	  $("#final-dose").html(final_dose);
	  bpMonitor();
	  hbMonitor();
	  return
  }	
  
  function bi_weekly_fulllist(bw){
	  var listing = "<table class='table'><thead><tr>";
	  listing += "<th id='visit_no'>" + curLang.visitNo +"</th><th class='visit_planned''>"+curLang.plannedDate+"</th>";
	  listing += "</tr></thead><tbody>";
	  for (var i= 1; i< 16; i++){
		  listing += "<tr><td>"+i +"</td><td>" + bw[i] + "</td></tr>";
	  }
	  listing += "</tbody></table>";
	  $("#listings").html(listing);
  } 
   
  function bpMonitor(){
  	var bp = [];
	bp[0] = ""
	bp[1] = format_date_as_string(minusDays(edd_projected, 24*7)) +"<br/>"+ format_date_as_string(minusDays(edd_projected, 20*7));
	bp[2] = format_date_as_string(minusDays(edd_projected, 12*7)) +"<br/>"+ format_date_as_string(minusDays(edd_projected, 10*7));
	bp[3] = format_date_as_string(minusDays(edd_projected, 6*7));
	bp[4] = format_date_as_string(minusDays(edd_projected, 4*7));
	bp[5] = format_date_as_string(minusDays(edd_projected, 2*7));		
	bp[6] = format_date_as_string(edd_projected);
	bp[7] = format_date_as_string(addDays(edd_projected, 2*7));	
	for(var i=1; i<8; i++){
		$("#bp_"+i).html(bp[i]);
	}
  }

  function hbMonitor(){
  	var hb = [];
	hb[0] = "";
	hb[1] = format_date_as_string(addDays(randomize_date, 4*7));
	hb[2] = format_date_as_string(minusDays(edd_projected, 14*7))+"<br/>"+ format_date_as_string(minusDays(edd_projected, 10*7));
	$("#hb_1").html(hb[1]);
	$("#hb_2").html(hb[2]);
  }
  
    
  function adjustForWeekends(bwdate){
	  if (bwdate.getDay() == 0){
	  	bwdate = addDays(bwdate, 1);
	  };
	  if (bwdate.getDay() == 6){
	  	bwdate = addDays(bwdate, 2);
	  };
	  return bwdate;
  }
  
  
  function daysBetween(date1,date2){ 
	  var one_day = 1000*60*60*24;
	  var date1_ms = date1.getTime();
	  var date2_ms = date2.getTime();
	  var days_diff = (date1_ms - date2_ms)/one_day;	
	  return Math.floor(days_diff);
  }
  
  function addDays(theDate, days) {
	  var result = new Date(theDate);
	  result.setDate(result.getDate() + days);
      return result;
  }
  
  function minusDays(theDate, days) {
	  var result = new Date(theDate);
	  result.setDate(result.getDate() - days);
      return result;
  }
  
  function validateInputs(){
	  var valid_input = true;
	  var errMsg = "";
      if ($("#lmp_date").val() === "" && !($("#lmp_date_unknown").is(':checked'))){
		  errMsg = errMsg + "[ "+curLang.errorMsg1+" ] ";
      };
	  if ($("#us_date").val() === ""){
	  	errMsg = errMsg + "[ "+curLang.errorMsg2+" ] ";
	  } else {
		us_date = convertToDate($('#us_date').val());
	    if (us_date.getTime() > current_date.getTime()){
	 	  errMsg = errMsg + "[ "+curLang.errorMsg6+" ]" ;
	    }
	  };
	  if ($("#ga_us_weeks").val() === "" || $("#ga_us_days").val() === ""){
		  errMsg = errMsg + "[ "+curLang.errorMsg3+" ] ";
	  } else {
		  var ga_wks = parseInt($("#ga_us_weeks").val());
		  var ga_days = parseInt($("#ga_us_days").val());
		  if(ga_wks < 6 || ga_wks > 14) {
			errMsg = errMsg + "[ "+curLang.errorMsg7+" ] "
		  }
		  if (ga_days < 0 || ga_days > 6){
			  errMsg = errMsg + "[ "+curLang.errorMsg8+" ] "
		  } else {
		     if (ga_wks === 14 && ga_days === 6){
			     errMsg = errMsg + "[ "+curLang.errorMsg8+" ]"
			 }	 
		  };
	  };
	  if ($("#randomize_date").val() === ""){
	  	errMsg = errMsg + "[ "+curLang.errorMsg4+" ] ";
	  } else {
		  randomize_date = convertToDate($('#randomize_date').val());
		  if (randomize_date.getTime() < current_date.getTime()){
			  errMsg = errMsg + "[ "+curLang.errorMsg5+" ]" ;
		  }
	  };
	  if (errMsg !==""){
		  valid_input = false;
	  };
	  displayErrorMsg(errMsg)
	  return valid_input;
  }
  
  function checkEmpty(){
	var empty = $(".datepicker").filter(function(){
		return $(this).val() === "";
	});
  	return (empty.length == 0)
  }
  
  function validateGA(){
	  var valid_ga = true;
	  var ga_wks = $("#ga_us_weeks").val();
	  var ga_days = $("ga_us_days").val();
	  if(ga_wks<6 || ga_wks>14) {
		  valid_ga = false;
	  };
	  if(ga_wks=14 && ga_days>5){
		  valid_ga = false;
	  };
	  return valid_ga;
  }
  
  function fillInTodayDate(){
	  var today_date = new Date();
	  $('#current_date').val(format_date_as_string(today_date));
  }
  
  function displayErrorMsg(msg){
  	$("span#myAlert").text(msg);
	$(".bs-alert").show();
  }
  
  function changeLanguage(curLang){	
	  $("#appTitle").html(curLang.title1);
	  $("#results").html(curLang.title2);
      $("#initial").html(curLang.button1);
      $("#randomization").html(curLang.button2);
      $("#calculate").html(curLang.button3);
      $("#clear").html(curLang.button4);
	  $("#today").html(curLang.inputLabel1);
	  $("#LMPDate").html(curLang.inputLabel2);
	  $("#unknown").html(curLang.inputLabel3);
	  $("#USDate").html(curLang.inputLabel4);
	  $("#GA-US").html(curLang.inputLabel5);
	  $("#DateRandomization").html(curLang.inputLabel8);
	  $("#labelWeeks").html(curLang.inputLabel6);
	  $("#labelDays").html(curLang.inputLabel7);
	  $(".word-or").html(curLang.wordOR);
	  $(".word-and").html(curLang.wordAND);
	  $("#participant").html(curLang.idCARD);
	  $("#resultLabel1").html(curLang.resultLabel1);
	  $("#resultLabel2").html(curLang.resultLabel2);
	  $("#resultLabel3").html(curLang.resultLabel3);
	  $("#resultLabel4").html(curLang.resultLabel4);
	  $("#resultLabel5").html(curLang.resultLabel5);
	  $("#resultLabel6").html(curLang.resultLabel6); 
	  $("#resultLabel8").html(curLang.resultLabel8);
	  $(".labelVisit").html(curLang.resultLabel7);
	  $("#visitModalLabel").html(curLang.title3);
	  $("#biweekly_title").html(curLang.title4);
	  $("#bp_monitoring").html(curLang.title5);
	  $("#hb_monitoring").html(curLang.title6);
	  $("#visit_no").html(curLang.visitNo);
	  $(".visit_planned").html(curLang.plannedDate);
	  $("#no_dates").html(curLang.comment1);
	  $(".monitor_visit").html(curLang.resultLabel7);
	  $(".visit_planned").html(curLang.plannedDate);
	  $("#label9").html(curLang.resultLabel9);
	  $(".weeks").html(curLang.weeks);
	  $("#bp_monitor0").html(curLang.bp_monitor0);
	  $("#hb_monitor0").html(curLang.hb_monitor0);
	  $("#hb_monitor1").html(curLang.hb_monitor1);
	  $("#hb_monitor2").html(curLang.hb_monitor2);	  
	  $("#error").html(curLang.error);
	  if (typeof ga_proj != "undefined"){		  
  	    $('#gestational_age_proj').val(getGestationalAgeStr(ga_proj));
	  };
	  if (typeof ga_lmp != "undefined"){
	     $("#ga_lmp").val(getGestationalAgeStr(ga_lmp));
	  }	 
	  if (typeof eligible != "undefined"){	
	     patient_kit(eligible);
	  }
	  $(".close-btn").html(curLang.close);
	  $("#instructions").html(curLang.instructions);
	  $.datepicker.setDefaults($.datepicker.regional[curLang.name.toLowerCase()]); 
  };
  
  function getCookie(cname){
	  var name = cname + "=";
	      var ca = document.cookie.split(';');
	      for(var i=0; i<ca.length; i++) {
	          var c = ca[i];
	          while (c.charAt(0)==' ') c = c.substring(1);
	          if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
	      }
	      return "";
  };
  
  function setCookie(cname, cvalue, exdays) {
      var d = new Date();
      d.setTime(d.getTime() + (exdays*24*60*60*1000));
      var expires = "expires="+d.toUTCString();
      document.cookie = cname + "=" + cvalue + "; " + expires;
  };
  
  
  $(window).load(function(){
	  var cookie = getCookie("language");
	  if (cookie == ""){
		  cookie = "En";
		  setCookie("language","En", 365);
	  }
	  switch (cookie){
	    case "Es":
	  		curLang = esLang;  
	  		$("#english").show();
			$("#french").show();
			break;
	    case "Fr":
			curLang = frLang;
		  	$("#english").show();
			$("#spanish").show();
			break;
		default:
	  		curLang = defaultLang;  
	  		$("#french").show();
			$("#spanish").show();		
	  }
	
	  changeLanguage(curLang);
	  
	  switch (curLang.name){
	     case "Es":
			$("#html-text").load("help-es.html");
			break;
		 case "Fr":	
			 $("#html-text").load("help-fr.html");
			 break;
		 default:
			$("#html-text").load("help.html");  	 	 
	  }
	  
	  $("#eligible-msg").hide();
	  fillInTodayDate();
	  $("#no_dates").html(curLang.comment1);
  });
  
  
  
   //function showDocs() {
   //}
   
})();

