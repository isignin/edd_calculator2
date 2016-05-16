class SchedulesView extends Backbone.View
  el: "#listing"
  
  render: ->
    @.$el.html "
       <div class='modal fade' id='visitsModal' tabindex='-1' role='dialog' aria-labelledby='visitsModalLabel'>
            <div class='modal-dialog' role='document'>
              <div class='modal-content'>
                <div class='modal-header'>
                  <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
                  <h4 class='modal-title' id='visitModalLabel'>HOME VISIT SCHEDULE</h4>
                </div>
                <div class='modal-body' id='home_visit'>
       			 <div id='html-visits'>
       				 <div class='col-xs-5 col-md-6'>
       					 <div id='biweekly_title'><strong>BI-WEEKLY HOME VISIT</strong></div>
       				    <div id='listings'>
       					 	<table class='table'>
       							<thead>
       								<tr><th id='visit_no'>Visit</th><th class='visit_planned'>Planned Date</th></tr>
       							</thead>
       							<tbody>
       						       <tr><td colspan='2'><span id='no_dates'>No dates Calculated yet</span></td>
       							</tbody>
       						</table>		   
       					</div>		
       				 </div>	
       				 <div class='col-xs-7 col-md-6'>
       					 <div id='bp_monitoring'><strong>BP MONITORING</strong></div>
       					 <div id='bp_monitor'>
       					 	<table class='table'>
       							<thead>
       								<tr><th class='monitor_visit'>Visit</th><th class='visit_planned'>Planned Date</th></tr>
       							</thead>
       							<tbody id='test'>
       								<tr><td>16-20 <span class='weeks'>Weeks</span></td><td id='bp_1'> </td></tr>
       								<tr><td>28-30 <span class='weeks'>weeks</span></td><td id='bp_2'> </td></tr>
       								<tr><td>34 <span class='weeks'>weeks</span></td><td id='bp_3'> </td></tr>
       								<tr><td>36 <span class='weeks'>weeks</span></td><td id='bp_4'> </td></tr>
       								<tr><td>38 <span class='weeks'>weeks</span></td><td id='bp_5'> </td></tr>
       								<tr><td>40 <span class='weeks'>weeks</span></td><td id='bp_6'> </td></tr>
       								<tr><td>42 <span class='weeks'>weeks</span></td><td id='bp_7'> </td></tr>
       							</tbody>
       						  </table>			
       					 </div>
       					 <div id='hb_monitoring'><strong>HB MONITORING</strong></div>
       					 <div id='hb_monitor'>
       					 	<table class='table'>
       							<thead>
       								<tr><th class='monitor_visit' style='width: 35%'>Visit</th><th class='visit_planned'>Planned Date</th></tr>
       							</thead>
       							<tbody>
       								<tr><td id='hb_monitor1'>4 weeks after randomization</td><td id='hb_1'> </td></tr>
       								<tr><td id='hb_monitor2'>26-30 weeks GA</td><td id='hb_2'> </td></tr>
       							</tbody>
       						  </table>			
       					 </div>
       					 <div id='dose-final'><span id='label9'>Date of final dose </span> : <span id='final-dose'> </span></div>
       				 </div>	 
       			 </div>
                </div>
       		 <div class='modal-footer'>
       		         <button type='button' class='btn btn-primary close-btn' data-dismiss='modal'>Close</button>
       		 </div>		 
              </div>
            </div>
    "
module.exports = SchedulesView