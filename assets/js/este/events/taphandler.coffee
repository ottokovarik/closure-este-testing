###*
  @fileoverview TapHandler is general tap event both for mobile and desktop.
  For touch devices, touchstart is used, which fixes 300ms click delay.
  This approach is also known as FastButton, but TapHandler implementation
  is better, because works fine with native mobile scroll momentum.

  todo
    simulate native behavior on middle/right-click and when ctrl or command are
    pressed (e.button != 1, e.ctrlKey, e.metaKey)

###
goog.provide 'este.events.TapHandler'
goog.provide 'este.events.TapHandler.EventType'

goog.require 'este.Base'
goog.require 'este.mobile'
goog.require 'goog.dom'
goog.require 'goog.math.Coordinate'
goog.require 'goog.userAgent'

class este.events.TapHandler extends este.Base

  ###*
    @param {Element} element
    @param {boolean=} touchSupported
    @constructor
    @extends {este.Base}
  ###
  constructor: (@element, touchSupported) ->
    super
    @registerEvents touchSupported

  ###*
    @type {number}
  ###
  touchMoveSnap: 10

  ###*
    @type {number}
  ###
  touchEndTimeout: 10

  ###*
    @enum {string}
  ###
  @EventType:
    START: 'start'
    END: 'end'
    TAP: 'tap'

  ###*
    Touchstart on iOS<5 slowdown native scrolling, 4.3.2 does not fire
    touchstart on search input field etc..., so that's why iOS5 is required.
    todo: check Android
    @return {boolean}
  ###
  @touchSupported: ->
    return false if !goog.userAgent.MOBILE
    !este.mobile.iosVersion || este.mobile.iosVersion >= 5

  ###*
    @param {goog.events.BrowserEvent} e
    @return {!goog.math.Coordinate}
  ###
  @getTouchClients: (e) ->
    touches = e.getBrowserEvent().touches[0]
    new goog.math.Coordinate touches.clientX, touches.clientY

  ###*
    @param {Node} target
    @return {Node}
  ###
  @ensureTargetIsElement: (target) ->
    # IOS4 bug: touch events are fired on text nodes
    target = target.parentNode if target.nodeType == 3
    target

  ###*
    @type {Element}
    @protected
  ###
  element: null

  ###*
    @type {goog.math.Coordinate}
    @protected
  ###
  coordinate: null

  ###*
    @type {boolean}
    @protected
  ###
  scrolled: false

  ###*
    @param {boolean=} touchSupported
    @protected
  ###
  registerEvents: (touchSupported) ->
    if touchSupported ? TapHandler.touchSupported()
      scrollElement = if @element.tagName == 'BODY'
        goog.dom.getWindow @element.ownerDocument
      else
        @element
      @getHandler().
        listen(@element, 'touchstart', @onTouchStart).
        listen(scrollElement, 'scroll', @onScroll)
    else
      @getHandler().
        listen(@element, 'click', @onClick)

  ###*
    @param {goog.events.BrowserEvent} e
    @protected
  ###
  onTouchStart: (e) ->
    @coordinate = TapHandler.getTouchClients e
    @scrolled = false
    @enableTouchMoveEndEvents true
    @dispatchTapEvent TapHandler.EventType.START, e.target

  ###*
    @param {boolean} enable
    @protected
  ###
  enableTouchMoveEndEvents: (enable) ->
    html = @element.ownerDocument.documentElement
    if enable
      @getHandler().
        listen(html, 'touchmove', @onTouchMove).
        listen(@element, 'touchend', @onTouchEnd)
    else
      @getHandler().
        unlisten(html, 'touchmove', @onTouchMove).
        unlisten(@element, 'touchend', @onTouchEnd)

  ###*
    @param {string} type
    @param {Node} target
    @protected
  ###
  dispatchTapEvent: (type, target) ->
    target = TapHandler.ensureTargetIsElement target
    return if !target
    @dispatchEvent
      type: type
      target: target

  ###*
    @param {goog.events.BrowserEvent} e
    @protected
  ###
  onTouchMove: (e) ->
    return if !@coordinate? # because compiler needs !null
    distance = goog.math.Coordinate.distance @coordinate,
      TapHandler.getTouchClients e
    return if distance < @touchMoveSnap
    @dispatchTapEvent TapHandler.EventType.END, e.target
    @enableTouchMoveEndEvents false

  ###*
    @param {goog.events.BrowserEvent} e
    @protected
  ###
  onTouchEnd: (e) ->
    target = e.target
    @enableTouchMoveEndEvents false
    setTimeout =>
      @dispatchTapEvent TapHandler.EventType.END, target
      return if @scrolled
      @dispatchTapEvent TapHandler.EventType.TAP, target
    , @touchEndTimeout

  ###*
    @param {goog.events.BrowserEvent} e
    @protected
  ###
  onScroll: (e) ->
    @scrolled = true

  ###*
    @param {goog.events.BrowserEvent} e
    @protected
  ###
  onClick: (e) ->
    @dispatchTapEvent TapHandler.EventType.START, e.target
    @dispatchTapEvent TapHandler.EventType.END, e.target
    @dispatchTapEvent TapHandler.EventType.TAP, e.target