// Coffe Class fixed for Closure Compiler by este dev stack
// Generated by CoffeeScript 1.3.3
/**
  @fileoverview estemvclab.contact.View.
*/



goog.provide('estemvclab.contact.View');

goog.require('este.View');



  

  /**
    @constructor
    @extends {este.View}
  */


  estemvclab.contact.View = function() {
    estemvclab.contact.View.superClass_.constructor.apply(this, arguments);
  }

  goog.inherits(estemvclab.contact.View, este.View);

  /**
    @type {estemvclab.about.View}
  */


  estemvclab.contact.View.prototype.aboutView = null;

  estemvclab.contact.View.prototype.show = function() {
    estemvclab.contact.View.superClass_.show.apply(this, arguments);
    return document.title = 'show contact';
  };

  
