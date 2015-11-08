/*
  We need to cheat specs so they think they're running in a web environment and not NODE env.
*/
if (global.window) {
  global.jQuery = require('jquery');
  global.Backbone = require('backbone');
  global.Backbone.$ = global.jQuery;
} else {
  var jsdom = require('jsdom').jsdom;
  var document = jsdom('');
  var window = document.defaultView;
  var backbone = require('backbone');
  global.document = document;
  global.window = window;
  global.$ = global.jQuery = require('jquery');
  global.Backbone = backbone;
  backbone.$ = global.$;
}
