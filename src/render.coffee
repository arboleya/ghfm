fs = require 'fs'
path = require 'path'

request = require 'request'

register = require './register'

publ1c = path.join __dirname, '..', 'public'
index = path.join publ1c, 'index.html'
template = path.join publ1c, 'template.html'
template = fs.readFileSync template, 'utf-8'

module.exports = (filepath, done) ->
  buffer = fs.readFileSync filepath, 'utf-8'


  config_path = path.join __dirname, 'user.oauth.json'
  unless fs.existsSync config_path
    console.log 'Please, authenticate first'
    return register -> module.exports filepath, done

  token = require(config_path).token

  url = 'https://api.github.com/markdown?access_token=' + token
  data = text: buffer, mode: 'markdown'

  request.post url, {json: data, encoding: 'utf-8'}, (req, res)->
    if ~'401 Unauthorized | 403 Forbidden'.indexOf(res.headers.status)
      console.log 'Access denied, please authenticate again:'
      register -> module.exports filepath, done
    else
      save res.body
      done res.body

save = (html)->
  fs.writeFileSync index, template.replace '~CONTENT', html