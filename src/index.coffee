require('source-map-support').install()

fs = require 'fs'
path = require 'path'
request = require 'request'
exec = require('child_process').exec

fsu = require 'fs-util'
connect = require 'connect'
io = require 'socket.io'

require 'colors'

filepath = null
publ1c = path.join __dirname, '..', 'public'
index = path.join publ1c, 'index.html'
template = path.join publ1c, 'template.html'

template = fs.readFileSync template, 'utf-8'

init = (file)->
  unless fs.existsSync file
    return console.log 'File not found: ', arg

  fsu.watch( filepath = file ).on 'change', onchange
  render (html)->
    save html
    serve()
    open()

onchange = (done)->
  render (html)->
    save html
    refresh()

render = (done) ->

  buffer = fs.readFileSync filepath, 'utf-8'
  url = 'https://api.github.com/markdown'
  data = text: buffer, mode: 'markdown'
    
  token_path = path.join __dirname, 'token.secret'
  if fs.existsSync token_path
    token = fs.readFileSync token_path, 'utf-8'
    data.oauth = consumer_secret: token

  request.post url, {json: data, encoding: 'utf-8'}, (req, res)->
    done res.body
    # console.log res.body

save = (html)->
  fs.writeFileSync index, template.replace '~CONTENT', html

port = null
app = null
refresher = null

serve = ->
  port = 54321
  app = connect()
    .use( connect.static publ1c )
    .listen port

  address = 'http://localhost:' + port
  console.log  "♫ Preview running at #{address}"

  refresher = io.listen 12345, 'log level': 0

open = ->
  exec 'open http://localhost:54321 > /dev/null'

refresh = ->
  refresher.sockets.emit 'refresh'


config = (token) ->
  if token?
    fs.writeFileSync path.join(__dirname, 'token.secret'), token
    console.log 'Token saved successfully!'
  else
    console.log 'Token not informed, i.e.'
    console.log '\t➜  ghfm config <token>'

help = ->
  version = require(path.join __dirname, '..', 'package.json').version
  console.log """
    GHFM #{('v' + version).grey}
    #{'Github Flavored Markdown previwer'.grey}

    Usage:
        ghfm [#{'path'.green}]
        ghfm [#{'config'.green}] [#{'token'.green}]

    Options:
        config  Set your token to raise API limit to 5k/h

    Examples:
        ghfm #{'/path/to/my/file.md'.grey}
        ghfm config #{'da7d9999f91c74d11eee31beef852dd58ff0a357'.grey}
    
    #{'To generate a new token, go to:'.grey}
      #{'https://github.com/settings/applications'.cyan}
  """


[action, arg] = process.argv.slice(2)
switch action
  when 'config' then config arg
  when 'help' then help()
  else
    if action?
      init action 
    else
      help()