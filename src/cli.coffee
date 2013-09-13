exports.help = ->
  version = require(path.join __dirname, '..', 'package.json').version
  console.log """
    GHFM #{('v' + version).grey}
    #{'Github Flavored Markdown previwer'.grey}

    Usage:
      ghfm [#{'path'.green}]

    Examples:
        ghfm #{'/path/to/my/file.md'.green}
  """