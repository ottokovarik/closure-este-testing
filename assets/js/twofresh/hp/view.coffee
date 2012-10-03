###*
  @fileoverview twofresh.hp.View.
###
goog.provide 'twofresh.hp.View'

goog.require 'este.app.View'

class twofresh.hp.View extends este.app.View

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
  url: ''

  ###*
    @type {este.demos.app.simple.products.Collection} products
    @protected
  ###
  products: null

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
    window['console']['log'] "hp rendered"
    
    # no url hardcoding, urls are always generated
    url = @getUrl twofresh.work.View

    @getElement().innerHTML = """
      <div class="twoChoices" id="peopleWork" style="opacity: 1; display: block;">
        <a e-href class="people"><span style="opacity: 1;">People</span></a>
        <a e-href="#{url}" class="work" style="right: 0%;"><span style="opacity: 1;">Work</span></a>
      </div>
    """
    return