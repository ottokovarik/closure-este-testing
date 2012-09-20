###*
  @fileoverview Stay tuned for TodoMVC demo.
###

goog.provide 'app.start'

goog.require 'este.dev.Monitor.create'
goog.require 'goog.dom'
goog.require 'goog.events'
goog.require 'goog.dom.DomHelper'
goog.require 'goog.ui.Component'
goog.require 'goog.ui.HsvPalette'
goog.require 'goog.dom.query'
goog.require 'goog.ui.LabelInput'

goog.require 'este.ui.InvisibleOverlay'
goog.require 'este.ui.FieldReset'

goog.require 'fflibrary.ui.InvisibleOverlay'

###*
  @param {Object} data JSON from server
###
app.start = (data) ->

  el = goog.dom.createDom 'div', {class: 'helloWorld', style: 'width:450px; margin: 20px; padding: 20px; background-color: #eee;'}, 'nejaky obsah'
  
  body = goog.dom.query 'body'
  body = body[0]

  goog.dom.append body, el


  inputCol = new goog.ui.LabelInput 'napis "open"'
  inputCol.render body

  inputHandler = new goog.events.InputHandler inputCol.getElement()



  invisibleOverlay = new fflibrary.ui.InvisibleOverlay
  invisibleOverlay.render el

  goog.events.listen invisibleOverlay, fflibrary.ui.InvisibleOverlay.EventType.REMOVE, (e) ->
    invisibleOverlay.dispose()

  #if input has value "open" remove invisibleOverlay
  goog.events.listen inputHandler, 'input', (e) ->
    if e.target.value == 'open'
      #alert 'oteviram'
      #invisibleOverlay.onClick()   #funguje, ale asi neni spravne 
      #invisibleOverlay.dispatchEvent fflibrary.ui.InvisibleOverlay.EventType.REMOVE    #tohle taky funguje, ale jina eventType ne
      invisibleOverlay.dispatchEvent fflibrary.ui.InvisibleOverlay.EventType.START_REMOVE


  colorPallete = new goog.ui.HsvPalette
  colorPallete.render el


  if goog.DEBUG
    este.dev.Monitor.create()

# ensures the symbol will be visible after compiler renaming
goog.exportSymbol 'app.start', app.start