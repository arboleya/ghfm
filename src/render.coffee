fs = require 'fs'
path = require 'path'

request = require 'request'

register = require './register'

publ1c = path.join __dirname, '..', 'public'
index = path.join publ1c, 'index.html'
template = path.join publ1c, 'template.html'
template = fs.readFileSync template, 'utf-8'

css = []

module.exports = (filepath, done) ->
  buffer = fs.readFileSync filepath, 'utf-8'

  config_path = path.join __dirname, 'user.oauth.json'
  unless fs.existsSync config_path
    return register -> module.exports filepath, done

  token = require(config_path).token

  url = 'https://api.github.com/markdown?access_token=' + token
  data = text: buffer, mode: 'markdown'

  options = 
    headers: 'User-Agent': 'GHFM'
    json: data
    encoding: 'utf-8'

  request.post url, options, (req, res)->
    if ~'401 Unauthorized | 403 Forbidden'.indexOf(res.headers.status)
      register -> module.exports filepath, done
    else
      save res.body
      done res.body

get_css_paths = ( done )->
  request 'http://github.com', (err, res, body)->
    if err is null and res.statusCode is 200
      css = body.match /https?:\/\/github.+github2?-[0-9a-z]+\.css/g
      done()

save = (html)->
  if css.length is 0
    return get_css_paths -> save html

  buffer = template.replace '~CONTENT', html
  buffer = buffer.replace '~CSS1', css[0]
  buffer = buffer.replace '~CSS2', css[1]

  fs.writeFileSync index, buffer