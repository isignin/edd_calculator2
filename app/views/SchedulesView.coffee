Common = require '../Common'

class SchedulesView extends Backbone.View
  el: "#listing"
  
  events:
    "click img.close": "closeList"

  closeList: (e) =>
    e.preventDefault
    $('#listing').hide()

  render: =>
    $('#listing').show()
    @.$el.html "
      <div class='modal fade' id='visitsModal' tabindex='-1' role='dialog' aria-labelledby='visitsModalLabel'>
        <div class='modal-dialog' role='document'>
          <div class='modal-content'>
            <div class='modal-header'>
              <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
              <h4 class='modal-title' id='visitModalLabel'>#{App.curLang.title3}</h4>
            </div>
            <div class='modal-body' id='home_visit'>
              <div id='html-visits'>
                <div class='col-xs-5 col-md-6'>
                  <div id='biweekly_title'><strong>#{App.curLang.title4}</strong></div>
                  <div id='listings'>
                  <table class='table'>
                    <thead>
                      <tr><th id='visit_no'>#{App.curLang.visitNo}</th><th class='visit_planned'>#{App.curLang.plannedDate}</th></tr>
                    </thead>
                    <tbody>
                      <tr><td colspan='2'><span id='no_dates'>#{App.curLang.comment1}</span></td>
                    </tbody>
                  </table>		   
                </div>		
              </div>	
              <div class='col-xs-7 col-md-6'>
                <div id='bp_monitoring'><strong>#{App.curLang.title5}</strong></div>
                <div id='bp_monitor'>
                  <table class='table'>
                    <thead>
                      <tr><th class='monitor_visit'>#{App.curLang.visitNo}</th><th class='visit_planned'>#{App.curLang.plannedDate}</th></tr>
                    </thead>
                    <tbody id='test'>
                      <tr><td>16-20 <span class='weeks'>#{App.curLang.weeks}</span></td><td id='bp_1'> </td></tr>
                      <tr><td>28-30 <span class='weeks'>#{App.curLang.weeks}</span></td><td id='bp_2'> </td></tr>
                      <tr><td>34 <span class='weeks'>#{App.curLang.weeks}</span></td><td id='bp_3'> </td></tr>
                      <tr><td>36 <span class='weeks'>#{App.curLang.weeks}</span></td><td id='bp_4'> </td></tr>
                      <tr><td>38 <span class='weeks'>#{App.curLang.weeks}</span></td><td id='bp_5'> </td></tr>
                      <tr><td>40 <span class='weeks'>#{App.curLang.weeks}</span></td><td id='bp_6'> </td></tr>
                      <tr><td>42 <span class='weeks'>#{App.curLang.weeks}</span></td><td id='bp_7'> </td></tr>
                    </tbody>
                  </table>			
                </div>
                <div id='hb_monitoring'><strong>#{App.curLang.title6}</strong></div>
                <div id='hb_monitor'>
                  <table class='table'>
                    <thead>
                      <tr><th class='monitor_visit' style='width: 35%'>#{App.curLang.visitNo}</th><th class='visit_planned'>#{App.curLang.plannedDate}</th></tr>
                    </thead>
                    <tbody>
                      <tr><td id='hb_monitor1'>#{App.curLang.hb_monitor1}</td><td id='hb_1'> </td></tr>
                      <tr><td id='hb_monitor2'>#{App.curLang.hb_monitor2}</td><td id='hb_2'> </td></tr>
                    </tbody>
                  </table>			
                </div>
                <div id='dose-final'><span id='label9'>#{App.curLang.resultLabel9} </span> : <span id='final-dose'> </span></div>
              </div>	 
            </div>
          </div>
          <div class='modal-footer'>
            <button type='button' class='btn btn-primary close-btn' data-dismiss='modal'>#{App.curLang.close}</button>
          </div>		 
        </div>
      </div>
    "
    Common.bi_weekly_fulllist
      bw: App.bw
      edd_projected: App.edd_projected
      randomize_date: App.randomize_date
    
module.exports = SchedulesView