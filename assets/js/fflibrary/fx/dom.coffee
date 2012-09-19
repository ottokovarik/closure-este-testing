###*
	@fileoverview
###

goog.provide 'fflibrary.fx.dom.FadeAndZoom'

goog.require 'goog.fx.dom.PredefinedEffect'


class fflibrary.fx.dom.FadeAndZoom extends goog.fx.dom.PredefinedEffect

	###*
    Creates an animation object that fades the opacity of an element and zoom between two
    limits.

    Start and End should be floats between 0 and 1

    @param {Element} element Dom Node to be used in the animation.
    @param {Array.<number>|number} start 1D Array or Number with start opacity.
    @param {Array.<number>|number} end 1D Array or Number for end opacity.
    @param {number} time Length of animation in milliseconds.
    @param {Function=} opt_acc Acceleration function, returns 0-1 for inputs 0-1.
    @extends {goog.fx.dom.PredefinedEffect}
    @constructor
  ###

	constructor: (element, start, end, time, opt_acc)->
    super element, start, end, time, opt_acc


  ###*
    @protected
  ###
  updateStyle: ->
    # element and coords
    goog.style.setOpacity @element, @coords[0]
    goog.style.setStyle @element, '-webkit-transform', "scale(#{@coords[0]})"
    