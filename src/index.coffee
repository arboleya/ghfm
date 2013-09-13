require('source-map-support').install()

fs = require 'fs'
path = require 'path'

fsu = require 'fs-util'
colors = require 'colors'

cli = require './cli'
server = require './server'
render = require './render'
register = require './register'

filepath = null

init = ->
  unless fs.existsSync filepath
    return console.log 'File not found: ', arg

  render filepath, (html)->
    return unless html?
    fsu.watch( filepath ).on 'change', ->
      render filepath, (html)->
        server.push html

    server()

[action, arg] = process.argv.slice(2)
switch action
  when 'register' then register arg
  when 'help' then cli.help()
  else
    if action?
      filepath = action
      init() 
    else
      cli.help()