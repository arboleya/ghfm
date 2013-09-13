# GHFM - Github

[Github Flavored Markdown](http://github.github.com/github-flavored-markdown/)
previewer with 100% fidelity.

# Installation

```bash
npm install -g ghfm
````

# Usage

````bash
ghfm /path/to/your/markdown/file.md
````

# How it works:
  
  - Render your `markdown` file to `html` using
  [Github API](http://developer.github.com/v3/markdown/)
  - Serves it at [http://localhost:54321](http://localhost:54321)
  - Watch your `markdown` file for change
  - Re-render `html` on every change
  - Pushes updates down the wire to your browser

# Help

````
Usage:
    ghfm [path]
    ghfm [config] [token]

Options:
    config  Set your token to raise API limit to 5k/h

Examples:
    ghfm /path/to/my/file.md
    ghfm config da7d9999f91c74d11eee31beef852dd58ff0a357

To generate a new token, go to:
  https://github.com/settings/applications
````

# Why?

Because I got sick of editing `markdown` files locally, pushing them to Github
and detecting:

  - Syntax problems
  - Formatting issues
  - Incompatibilities in general

This project addresses all these problems you'll find with tools such as:

 1. [Mou](http://mouapp.com/)
 1. [Marked](http://markedapp.com/)
 1. And others

# Alternatives

The only alternative I've found to solve this situation was using the Github
default [Online Editor](https://github.com/arboleya/ghfm/edit/master/README.md)
which lets you preview your `markdown` exactly the way it'll behavior when
pushed to Github.

But it's kinda painful to edit files:
 - inside a `textarea`
 - pressing `preview` to see it live
 - detecting errors
 - pressing `code` to edit it again
 - making changes
 - pressing `preview` to see it live
 - detecting errors
 - pressing `code` to edit it again
 - [...]

# License

The MIT License (MIT)

Copyright (c) 2013 Anderson Arboleya

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.