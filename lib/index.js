// Generated by CoffeeScript 1.6.3
var action, arg, cli, colors, filepath, fs, fsu, init, path, register, render, server, _ref;

require('source-map-support').install();

fs = require('fs');

path = require('path');

fsu = require('fs-util');

colors = require('colors');

cli = require('./cli');

server = require('./server');

render = require('./render');

register = require('./register');

filepath = null;

init = function() {
  if (!fs.existsSync(filepath)) {
    return console.log('File not found: ', arg);
  }
  return render(filepath, function(html) {
    if (html == null) {
      return;
    }
    fsu.watch(filepath).on('change', function() {
      return render(filepath, function(html) {
        return server.push(html);
      });
    });
    return server();
  });
};

_ref = process.argv.slice(2), action = _ref[0], arg = _ref[1];

switch (action) {
  case 'register':
    register(arg);
    break;
  case 'help':
    cli.help();
    break;
  default:
    if (action != null) {
      filepath = action;
      init();
    } else {
      help();
    }
}

/*
//@ sourceMappingURL=index.map
*/