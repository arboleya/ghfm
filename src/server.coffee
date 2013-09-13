path = require 'path'
exec = require('child_process').exec

io = require 'socket.io'
connect = require 'connect'

refresher = null
root = path.join __dirname, '..', 'public'

module.exports = ->
  port = 54321
  app = connect()
    .use( connect.static root )
    .use( connect.static path.join __dirname, '..' )
    .listen port

  address = 'http://localhost:' + port
  console.log  "♫  Preview running at #{address}"

  refresher = io.listen 12345, 'log level': 0
  open()

  module.exports  

module.exports.push = (html)->
  refresher.sockets.emit 'refresh', html

opened = false
open = ->
  return if opened
  opened = true
  exec 'open http://localhost:54321 > /dev/null'