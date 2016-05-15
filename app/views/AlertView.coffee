class AlertView extends Backbone.View
  el: "#alertBlock"
  
  events:
    "click img.close": "closeAlert"

  closeAlert: (e) =>
    e.preventDefault
    $('#errorAlert').hide()

  @displayErrorMsg: (msg) ->
    $("span#errorMsg").text(msg)
    $(".errorAlert").show()
      
  render: =>
    @$el.html "
      <div id='errorAlert' class='alert alert-danger'>
  			<img src='images/close.png' class='close'>
  			<strong>ERROR! </strong> <span  id='errorMsg'>  
  	  </div>
    "
module.exports = AlertView