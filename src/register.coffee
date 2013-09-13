fs = require 'fs'
path = require 'path'

prompt = require 'prompt'
request = require 'request'

client_id = '4b5a6ab7eea4c6aaee37'
client_secret = '769602c9c4a0944a5386e883db4670e436f3af5a'

module.exports = (done)->
  login (user, pass)->

    url = 'https://api.github.com/authorizations/clients/' + client_id
    options = 
      auth: {user, pass}
      body: JSON.stringify
        note: 'GHFM - Github Flavored Markdown Previewer'
        scopes: ['public_repo']
        client_secret: client_secret

    request.put url, options, (req, res)->
      if ~'401 Unauthorized 403 Forbidden'.indexOf(res.headers.status)
        console.log 'Incorrect credentials, try again'
        return module.exports done

      fs.writeFileSync path.join(__dirname, 'user.oauth.json'), res.body
      done()

login = (done)->
  msg = """
    > Data will no be stored and you can revoke access at any time at:
        #{'https://github.com/settings/applications'.green}
  """.grey

  console.log "Enter your Github crendentials \n#{msg}"
  prompt.start()

  schema = 
    properties:
      username:
        pattern: /.+/,
        required: true
      password:
        hidden: true,
        pattern: /.+/
        required: true

  prompt.get schema, (err, res)->
    done res.username, res.password