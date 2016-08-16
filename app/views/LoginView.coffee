Pikaday = require 'pikaday'

class LoginView extends Backbone.View
  el: "#loginBlock"
  
  events:
    "click button.close": "closeLogin"
    "click button#loginSubmit": "Login"
    
  closeLogin: (e) =>
    e.preventDefault
    $('#loginBlock').hide()

  Login: (e) =>
    e.preventDefault
    dt = new Date()
    code = (("0"+dt.getDate()).slice(-2)) + (("0"+(dt.getMonth()+1)).slice(-2))
    if ($('input#login').val() == "edd#{code}")
      $('input#current_date').css('background-color','white')
      $('#loginModal').modal("hide")
      $('input#login').val('')
      global.currentDatePicker = new Pikaday
        field: $('.datepicker')[0]
        position: 'bottom right'
        format: 'DD-MM-YYYY'
        reposition: false
    else
      $("div#errMsg").html("Wrong password. Please retry...")
    
  render: =>
    $('#loginBlock').show()
    
    @$el.html "
      <div class='modal fade' id='loginModal' tabindex='-1' role='dialog' aria-labelledby='loginModalLabel'>
        <div class='modal-login' role='document'>
          <div class='modal-content'>
            <div class='modal-header'>
              <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'><img src='images/close.png'></span></button>
              <h4 class='modal-title' id='instructions'>Admin Unlock Current Date</h4>
            </div>
            <div class='modal-body'>
              <div id='html-text'>
                <form id='login'>
          			  <div class='question-block'>
             		    <div class='question' id='adminPass'><span class='glyphicon glyphicon-eye-open'></span> Admin Password </div>
                     <input id='login' type='password' value='' autofocus=true>
                 </div>
                 <div class='question-block'>
                    <div id='errMsg'></div>
                 </div>
                </form>   
              </div>
            </div>
            <div class='modal-footer'>
              <button id='loginSubmit' class='btn btn-success' type='submit'><span class='glyphicon glyphicon-off'></span> Submit</button>
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div><!-- /.modal -->
    "

module.exports = LoginView
