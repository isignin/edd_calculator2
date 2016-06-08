class HelpView extends Backbone.View
  el: "#helpBlock"
  
  events:
    "click img.close": "closeHelp"

  closeAlert: (e) =>
    e.preventDefault
    $('#helpBlock').hide()

      
  render: =>
    helpText = switch App.curLang.name
      when 'En' then helpEn
      when 'Fr' then helpFr
      when 'Es'then helpEs
    $('#helpBlock').show()
    
    @$el.html "
      <div class='modal fade' id='helpModal' tabindex='-1' role='dialog' aria-labelledby='helpModalLabel'>
        <div class='modal-dialog' role='document'>
          <div class='modal-content'>
            <div class='modal-header'>
              <button type='button' class='close' data-dismiss='modal' aria-label='Close'>
                <span aria-hidden='true'>&times;</span>
              </button>
              <h4 class='modal-title'>#{App.curLang.instructions}</h4>
            </div>
            <div class='modal-body'>
              <div id='html-text'></div>
            </div>
            <div class='modal-footer'>
              <button type='button' class='btn btn-secondary' data-dismiss='modal'>#{App.curLang.close}</button>
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div><!-- /.modal -->
    "
    $("div#html-text").html(helpText)
    
  helpEn = "
      <div>This calculator will help you calculate the various dates required as for the completion of the ASP forms, based on the Date of LMP, Date of Ultrasound Exam, Gestational age by Ultrasound and the Date of Randomization.
      </div><br />
      <div><img src='images/language-en.png' class='f-l-mr-10 border-1'><p>The Calculator offers 2 languages of operation. The default language is English. The second language is French. Depending on what language is currently selected, you will see the alternate language icon on the top left hand corner. Click this icon to switch to a different language. For example. <img src='images/en-icon.png' width='25' height='25'> is for English and <img src='images/fr-icon.png' width='25' height='25'> is for French. The Calculator will remember the last language used and will start up in that language the next time around.<p></div>
      <hr/ >
      <div>
      <img src='images/mode-en.png' class='f-l-mr-10 border-1'><p>The Calculator has 2 modes for calculating the necessary dates depending on which stages of the process you are on. There is the Initial stage (screening) and the Randomization stage. Clicking either of the two top blue buttons will change the Calculator mode.<p>
      </div>
      <hr/ >
      <div style='height: 225px;'>
      	<img src='images/initial-mode-en.png' class='f-l-mr-10 border-1'><h4>Initial mode</h4><p>The <strong>Initial</strong> mode of the calculator will only calculate the EDD by LMP. This will be used during the completion of the <strong>APS01 form</strong>.</p><p> The screen on the left is what you will see when you click the [Initial] button at the top</p>
      </div>
      <hr/ >
      <div style='height: 315px;'>
      	<img src='images/randomize-en.png' class='f-l-mr-10 border-1'><h4>Randomization mode</h4><p>The <strong>Randomization</strong> mode of the calculator will do a more comprehensive calculation. This will be used during the completion of the <strong>APS05 form</strong>.</p><p> The screen on the left is what you will see when you click the [Randomization] button at the top</p>
      </div>
      <hr/ >	
      <div style='height: 560px;'>
      	<img src='images/inputs-data-en.png' class='f-l-mr-10 border-1'><h4>Calculation inputs</h4><p>To make a calculation, just enter the input fields on the left and click the Calculate button.</p>
      <p> All the fields are required except for Date of last LMP which is optional. If the Date of last LMP is unknown, then leave the field blank and tick the Unknown box. In which case the EDD by US will be used as the Projected EDD.</p>
      <p>Just above each input field is an indication of where the data for the field should come from. Eg. ASP01 QA7 which is ASP01 form question A7.</p>
      <p>Today's date is automatically set and cannot be changed. This date will be used to validate the Date of Randomization</p>
      <p>To enter the date, you may either type in the date manually, such as 31-12-2015, or you can select from the calendar that popups up when you click inside the input field.</p>
      <p>To start a new calculation, click the <b>Clear</b> button, which will clear the current inputs for you to select new dates.<p>
      </div>
      <hr/ >
      <div style='height: 245px;'>
      	<img src ='images/calendar-en.png' class='f-l-mr-10'><h4>Calendar</h4>When you click inside the input box, the calendar will popup. To select the date, just click the appropriate number. To change the month or the year, click the Month/Year on top and select appropriately.</p><p>Clicking the left and right arrow button will increase/reduce the month.</p>
      </div>
      <hr/ >
      <div style='height: 550px'>
      	<img src ='images/result-output-en.png' class='f-l-mr-10'><h4>Results</h4>The results will be displayed as soon as you click the Calculate button. This values will be entered into the appropriate form that you are completing. The result will also display the first three Bi-weekly visits dates.</p>
      <p><strong>Important</strong> to note at the bottom of the result table for eligibility. Based on the calculation, it will either display<br/> <span style='color:red'>NOT ELIGIBLE. Do not dispense study medication</span> <br />or <br /><span style='color:green'>ELIGIBLE. Select 15(14) card patient kit</span>
      <p><strong>Bi-Weekly Visits: </strong><br />The first three visits are displayed in the calculation results. To view the full visits schedules, click the <img src='images/dates-list.png' width='34' height='34'> icon.This will open up a popup window with the full list and other relevant planned dates.</p>
      </div>
      <hr/ >
      <div style='height: 180px'><h4>Updating the EDD Calculator App</h4>
      <img src ='images/version-en.png' class='f-l-mr-10'><p>From time to time, there may be updates to this app. You can tell if a new update is available for your device is by comparing the version number at the top of the screen.</p>
      <p>When you are connected to the internet, just visit the Calculator Url. Click this Sync icon <img src ='images/sync-icon.png' width='25' height='25'>. This will initiate a check for updates and apply the changes if there are any.</p>
      </div>
      <hr/ >
      <div>
      <h4>Add the App to the Home Screen on Android</h4>
      To add this app to the Home screen as a bookmark, while you have the App open, click the browser setting menu, and select <b>Add to Home Screen</b>. This will put an icon on your Home screen. When you click the icon, it will open up this app, even if you are not connected to the internet.
      </div>
    "
  
  helpEs = "
    <div>
    	Esta calculadora le ayudará a calcular varias fechas requeridas para el llenado de los formularios de aspirina, basados en fecha de última regla, fecha de ultrasonido, edad gestacional por ultrasonido y fecha de Randomización.
    </div><br />
    <div>
    	<img src='images/language-es.png' class='f-l-mr-10 border-1'><p>Esta calculadora ofrece 3 idiomas para su uso.  El idioma por defecto es inglés, el segundo es Francés. Dependiendo del idioma previamente seleccionado, usted vera el icono de idioma alternativo en la esquina superior izquierda de la pantalla.  Dele clic a este icono para cambiar a un idioma diferente. Por Ejemplo <img src='images/en-icon.png' width='25' height='25'> es para inglés , <img src='images/fr-icon.png' width='25' height='25'> es para francés y <img src='images/es-icon.png' width='25' height='25'> es para español.  La calculadora recordara el último idioma seleccionado y este es el que usara la próxima vez que lo inicie.<p>
    </div>
    <hr/ >
    <div>
    	<img src='images/mode-es.png' class='f-l-mr-10 border-1'><p>La calculadora tiene 2 modos para calcular las fechas necesarias dependiendo de qué fase del proceso este.  La fase inicial (tamizaje) y la segunda Fase Randomización.  Haciendo clic en cualquiera de los 2 botones azules cambiara el modo de uso de la calculadora. <p>
    </div>
    <hr/ >
    <div style='height: 225px;'>
    	<img src='images/initial-mode-es.png' class='f-l-mr-10 border-1'><h4>Modo Inicial:</h4><p>El modo <strong>inicial</strong> de la calculadora solo calculara la FPP por FUR.  Esto se usara cuando llene el <strong>formulario ASP01</strong>.  En la pantalla de la izquierda hasta arriba es donde deberá seleccionar el botón [Initial]</p>
    </div>
    <hr/ >
    <div style='height: 315px;'>
    	<img src='images/randomize-es.png' class='f-l-mr-10 border-1'><h4>Modo de Randomización</h4><p>El modo de <strong>Randomización</strong> realizara un cálculo más completo. Esto será usado durante el llenado del <strong>formulario ASP05</strong>. La pantalla en la izquierda es la que vera cuando usted de clic en el botón [Randomización] en la parte superior.</p>
    </div>
    <hr/ >	
    <div style='height: 560px;'>
    	<img src='images/inputs-data-es.png' class='f-l-mr-10 border-1'><h4>Cálculos</h4><p>Para hacer un cálculo, basta con introducir datos en los campos de entrada de la izquierda y haga clic en el botón Calcular.
    </p>
    <p> Se requiere que todos los campos excepto por Fecha de la última FUR que es opcional. Si la fecha del último FUR se desconoce, a continuación, deje el campo en blanco y marque la casilla Desconocida.  En cuyo caso el FPP POR US será utilizado como la FPP proyectada.</p>
    <p>Justo por encima de cada campo de entrada esta una indicación de que tipo datos se usan  para el campo el llenado de los distintos formularios. Por ejemplo. ASP01 QA7 nos indica que ese dato se usara en el formulario ASP01 en la pregunta A7.</p>
    <p>La fecha de hoy se ajusta automáticamente y no se puede cambiar. Esta fecha se utiliza para validar la fecha de la Randomización.</p>
    <p>Para introducir la fecha, es posible que cualquiera de los tipos en la fecha manualmente, como 31-12-2015, o puede seleccionar en el calendario que despliega un menú emergente cuando se hace clic en el interior del campo de entrada.</p>
    <p>Para iniciar un nuevo cálculo, haga clic en el botón <b>Borrar</b>, que borrara todos los datos ingresados para  que seleccione nuevas fechas<p>
    </div>
    <hr/ >
    <br />
    <div style='height: 245px;'>
    	<img src ='images/calendar-es.png' class='f-l-mr-10'><h4>Calendario</h4>Al hacer clic en el interior del espacio para ingresar una fecha se desplegará el calendario emergente. Para seleccionar la fecha, haga clic en el número apropiado. Para cambiar el mes o el año, haga clic en el mes / año en la parte superior y seleccione adecuadamente.
    </p><p>Al hacer clic en el botón de flecha izquierda y derecha aumentará / reducirá el mes.</p>
    </div>
    <hr/ >
    <div style='height: 550px'>
    	<img src ='images/result-output-es.png' class='f-l-mr-10'><h4>Resultados:</h4>Los resultados se mostrarán tan pronto como haga clic en el botón Calcular. Estos valores serán introducidos en el formulario correspondiente que está completando. El resultado también mostrará las tres primeras fechas visitas quincenales.</p>
    <p><strong>Importante</strong> tener en cuenta en la parte inferior de la tabla de resultados para la elegibilidad. Con base en el cálculo, lo hará cualquiera de las pantallas, podrá aparecer:
    <span style='color:red'>NO ELEGIBLE. No dispense la medicación del estudio</span>
    <br />o <br /><span style='color:green'>Seleccione Kit de 15 o 14 tarjetas </span>

    	o note at the bottom of the result table for eligibility. Based on the calculation, it will either display<br/> <span style='color:red'>NOT ELIGIBLE. Do not dispense study medication</span> <br />or <br /><span style='color:green'>ELIGIBLE. Select 15(14) card patient kit</span>
    <p><strong>Las visitas quincenales:</strong><br />Las tres primeras visitas se muestran en los resultados del cálculo. Para ver los horarios de visitas completo, haga clic en el icono <img src='images/dates-list.png' width='34' height='34'>. Esto abrirá una ventana emergente con la lista completa y otras fechas previstas pertinentes.</p>
    </div>
    <hr/ >
    <div style='height: 180px'><h4>La actualización de la aplicación Calculadora FPP</h4>
    <img src ='images/version-es.png' class='f-l-mr-10'><p>De vez en cuando, puede haber cambios a esta aplicación. Usted puede Comprobar si hay una nueva actualización disponible para el dispositivo, deberá comparar el número de versión en la parte superior de la pantalla.</p>
    <p>Cuando está conectado a Internet, sólo hay que abrir la Calculadora de FPP. Haga clic en el icono de sincronización <img src ='images/sync-icon.png' width='25' height='25'>. Esto iniciará una búsqueda de actualizaciones y aplicara los cambios, si los hay. .</p>
    </div>
    <hr/ >
    <div>
    <h4>Añadir la aplicación a la pantalla de inicio en Android</h4>
    TPara agregar esta aplicación a la pantalla de inicio como un marcador, mientras que usted tiene la aplicación abierta, haga clic en el menú de configuración del navegador y seleccione Añadir a pantalla de inicio. Esto pondrá un icono en la pantalla de inicio. Al hacer clic en el icono, se abrirá esta aplicación, incluso si no está conectado a internet.
    </div>
  "
  
  helpFr = "
    <div>
    	<p>Ce calculateur vous aidera à calculer différentes dates requises pour le remplissage des formulaires de l’étude Aspirine sur base de la DDR, date de l’examen échographique, âge gestationnel échographique et la date de randomisation.</p>
    	<p><img src='images/language-fr.png' class='f-l-mr-10 border-1'>Le Calculateur offre 2 langues opérationnelles. L’anglais est la langue par défaut. La deuxième langue est le français. En fonction de la langue sélectionnée, vous verrez l’icône d’alternance de langue au coin supérieur gauche. Cliquez sur l’icône pour passer d’une langue à une autre. Par exemple: <img src='images/en-icon.png' width='25' height='25'> signifie anglais et <img src='images/fr-icon.png' width='25' height='25'> signifie français. Le Calculateur se souviendra de la dernière langue utilisée et démarrera dans cette langue la prochaine fois.</p>
    </div>
    <hr/ >
    <div>
    	<img src='images/mode-fr.png' class='f-l-mr-10 border-1'><p>Le Calculateur a 2 modes pour calculer les dates nécessaires en fonction de l’étape du processus. Il y a une étape initiale (triage) et l’étape de randomisation. Vous allez changer de mode du Calculateur en cliquant sur l’un de deux boutons bleus qui se trouvent en haut.
    <p>
    </div>
    <hr/ >	
    <div style='height: 225px;'>
    	<img src='images/initial-mode-fr.png' class='f-l-mr-10 border-1'><h4>Mode Initial</h4>
    	<p>Le mode <strong>initial</strong> du calculateur calculera seulement la DPA sur base de la DDR. Cela sera utilisé pour le remplissage du <strong>formulaire ASP01</strong>.</p>
         <p> L’écran que vous voyez à gauche est ce que vous allez voir quand vous cliquez sur le bouton [Initial] en haut.</p>
    </div>
    <hr/ >
    <div style='height: 315px;'>
    	<img src='images/randomize-fr.png' class='f-l-mr-10 border-1'><h4>Mode de randomisation</h4>
    	<p>Le mode randomisation du calculateur fera des calculs beaucoup plus approfondis. Cela sera utilisé pour le remplissage du <strong>formulaire ASP05</strong>.</p>
    	<p> L’écran que vous voyez à gauche est ce que vous verrez quand vous cliquez sur le bouton [Randomisation]  en haut.</p>
    </div>
    <hr/ >	
    <div style='height: 560px;'>
    	<img src='images/inputs-data-fr.png' class='f-l-mr-10 border-1'><h4>Entrées de calculs</h4>
    	<p>Pour effectuer un calcul, entrez juste les données dans les champs à gauche et cliquez sur le bouton Calculez.
    </p>
    	<p>Tous les champs sont obligatoires à l’exception de la DDR qui est facultatif. Si la DDR est inconnue, laissez le champ vide et cochez la case Pas connu. Dans ce cas, la DPA par échographie sera utilisée comme la DPA prévue.</p>
    <p>Juste au-dessus de chaque champ, il y a une indication de là où les données du champ doivent provenir. Par exemple : ASP01 QA7 veut dire formulaire ASP01 question A7.</p>
    <p>La date d’aujourd’hui est automatiquement insérée et ne peut pas être modifiée. Cette date sera utilisée pour valider la Date de randomisation.</p>
    <p>Pour insérer la date, vous pouvez taper sur la date manuellement, comme 31-12-2015, soit sélectionner à partir d’un calendrier qui apparaît automatiquement quand vous cliquez à l’intérieur du champ.</p>
    <p>Pour commencer un nouveau calcul, cliquez sur le bouton Effacer et tout le contenu des champs sera effacé et vous pourrez sélectionner des nouvelles dates.<p>
    </div>
    <hr/ >
    <div style='height: 245px;'>
    	<img src ='images/calendar-fr.png' class='f-l-mr-10'><h4>Calendrier</h4>
    	<p>Quand vous cliquez à l’intérieur de la zone de saisie, le calendrier va s’afficher automatiquement. Pour sélectionner la date, cliquez juste sur le chiffre approprié. Pour changer de mois ou d’année, cliquez sur Mois/Année en haut et sélectionnez le chiffre approprié.</p>
    	<p>En cliquant sur le bouton flèche de gauche ou de droite, vous allez augmenter/réduire le mois.</p>
    </div>
    <hr/ >
    <div style='height: 550px'>
    	<img src ='images/result-output-fr.png' class='f-l-mr-10'><h4>Résultats</h4>
    	<p>Les résultats s’afficheront dès que vous cliquez sur le bouton Calculez. Ces valeurs seront saisies dans les formulaires appropriés que vous remplissez. Le résultat affichera aussi les dates de trois premières visites bimensuelles (bihebdomadaires).</p>
    <p>Il est <strong>important</strong> de prêter attention au bas de la page de résultats pour connaître le statut d’éligibilité. Sur base des calculs, ça va afficher soit</p>	
    <p><span style='color:red'><strong>NON ELIGIBLE</strong>. Ne distribuez pas le médicament de l’étude</span> <br />ou <br /><span style='color:green'><strong>ELIGIBLE</strong>. Sélectionnez le kit de la patiente à 15 (14) cartes.</span></p>

    <p><strong>Visites bimensuelles: </strong><br />Les trois premières visites sont affichées dans les résultats des calculs. Pour consulter les horaires des visites complètes, cliquez sur l'icône <img src='images/dates-list.png' width='34' height='34'>.Cela permettra d'ouvrir un message contextuel avec la liste complète et d'autres dates prévues pertinents.</p>
    </div>
    <hr/ >
    <div style='height: 180px'><h4>Mise à jour du logiciel du calculateur de la DPA</h4>
    <p><img src ='images/version-fr.png' class='f-l-mr-10'><p>De temps en temps, des mises à jour peuvent être disponibles pour ce logiciel. Vous pouvez savoir si de nouvelles mises à jour sont disponibles pour votre tablette en comparant le numéro de la version qui est affiché en haut de l’écran.</p>
    <p>Quand vous êtes connecté à l’Internet, visitez juste l’adresse URL du Calculateur. Cliquez sur l’icône Sync <img src ='images/sync-icon.png' width='25' height='25'>. Cela déclenchera la vérification des mises à jour et appliquera les changements s’il y en a.</p>
    </div>
    <hr/ >
    <div>
    <h4>Ajouter l’application sur l’écran d’accueil d’Android</h4>
    <p>Pour ajouter l’application sur l’écran d’accueil comme un signet, faites ceci : pendant que l’application est ouverte, cliquez sur le menu contextuel du navigateur, puis sélectionnez <strong>Add to Home Screen</strong> (Ajoutez sur l’écran d’accueil). Une icône sera alors placée sur votre écran d’accueil. Quand vous cliquez sur l’icône, ça va ouvrir cette application, même si vous n’êtes pas connecté à l’Internet.</p>
    </div>
  "
  
module.exports = HelpView