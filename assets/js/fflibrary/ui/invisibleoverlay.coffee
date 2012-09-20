###*
  @fileoverview fflibrary.ui.InvisibleOverlay.
###
goog.provide 'fflibrary.ui.InvisibleOverlay'

goog.require 'goog.ui.Component'
goog.require 'goog.fx.Animation'
goog.require 'goog.style'
goog.require 'fflibrary.fx.dom.FadeAndZoom'

class fflibrary.ui.InvisibleOverlay extends este.ui.InvisibleOverlay

  ###*
    @constructor
    @extends {este.ui.InvisibleOverlay}
  ###
  constructor: ->
    super()

  ###*
    @enum {string}
  ###
  @EventType:
    REMOVE: 'remove'
    START_REMOVE: 'startremove'

  ###*
    @inheritDoc
  ###
  decorateInternal: (element) ->
    super element

    @getElement().style.cssText = """
      position: absolute;
      left: 0; right: 0; top: 0; bottom: 0;
      z-index: 2147483647;
      background-color: #000
    """

    goog.style.setOpacity @getElement(), 0.8
    return


  ###*
    @inheritDoc
  ###
  enterDocument: ->
    super()
    @getElement().parentNode.style.position = 'relative'
    @getHandler().
      listen(@getElement(), 'click', @onClick).
      listen(@, InvisibleOverlay.EventType.START_REMOVE, @onClick)
    return

  ###*
    @protected
  ###
  onClick: (e) ->

    fx = new fflibrary.fx.dom.FadeAndZoom @getElement(), [0.8], [0.0], 1000
    @getHandler().
      listen(fx, goog.fx.Transition.EventType.END, @onRemoveAnimEnd)
    fx.play()


  onRemoveAnimEnd: (e) ->

    @dispatchEvent InvisibleOverlay.EventType.REMOVE