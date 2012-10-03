###*
  @fileoverview twofresh.work.View.
###
goog.provide 'twofresh.work.View'

goog.require 'este.app.View'

class twofresh.work.View extends este.app.View

  ###*
    @constructor
    @extends {este.app.View}
  ###
  constructor: ->
    super()

  ###*
    '' is root.
    @inheritDoc
  ###
  url: 'work/'


  ###*
    @inheritDoc
  ###
  load: (params) ->
    result = new goog.result.SimpleResult
    setTimeout =>
      
      result.setValue true
    , 2000
    result

  ###*
    @inheritDoc
  ###
  onLoad: ->
    window['console']['log'] "work rendered"

    @getElement().innerHTML = """
      <div class="frame" id="work" style="opacity: 1; display: block; margin: 105.48px 201.6px;">
        <div class="part selectedWork"><a href="" style="opacity: 1; -moz-transform: scale(1); -moz-transition-duration: 800ms; -moz-transition-timing-function: cubic-bezier(0, 1, 0, 1);"><span style="height: auto; display: block; padding-top: 117px; padding-bottom: 117px; opacity: 1; -moz-transition-duration: 800ms; -moz-transition-timing-function: cubic-bezier(0, 1, 0, 1); -moz-transition-property: opacity;">Selected<br>work</span></a></div>
        <div class="part services"><a href="" style="opacity: 1; -moz-transform: scale(1); -moz-transition-duration: 800ms; -moz-transition-timing-function: cubic-bezier(0, 1, 0, 1);"><span style="height: auto; display: block; padding-top: 142px; padding-bottom: 142px; opacity: 1; -moz-transition-duration: 800ms; -moz-transition-timing-function: cubic-bezier(0, 1, 0, 1); -moz-transition-property: opacity;">Services</span></a></div>
        <div class="part awards"><a href="" style="opacity: 1; -moz-transform: scale(1); -moz-transition-duration: 800ms; -moz-transition-timing-function: cubic-bezier(0, 1, 0, 1);"><span style="height: auto; display: block; padding-top: 142px; padding-bottom: 142px; opacity: 1; -moz-transition-duration: 800ms; -moz-transition-timing-function: cubic-bezier(0, 1, 0, 1); -moz-transition-property: opacity;">Awards</span></a></div>
        <div class="part clients"><a href="" style="opacity: 1; -moz-transform: scale(1); -moz-transition-duration: 800ms; -moz-transition-timing-function: cubic-bezier(0, 1, 0, 1);"><span style="height: auto; display: block; padding-top: 142px; padding-bottom: 142px; opacity: 1; -moz-transition-duration: 800ms; -moz-transition-timing-function: cubic-bezier(0, 1, 0, 1); -moz-transition-property: opacity;">Clients</span></a></div>
      </div>
    """
    return

  ###*
    @inheritDoc
  ###
  enterDocument: ->
    super()
    @on @getElement(), 'click', @onClick

  ###*
    @param {goog.events.BrowserEvent} e
    @protected
  ###
  onClick: (e) ->
    return if !e.target.hasAttribute 'e-href'
    # example of explicit redirection (without link with href)
    @redirect twofresh.hp.View