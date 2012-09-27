## app.coffee 
# `app.coffee` is the central part of the AMFMF app.

# We require our `express` which handles requests,
# `connect-assets` which helps with handling my stylus
# and coffeescript files and we also require 'express-load'
# a tiny, but cool module, that handles loading config
# files (using `js-yaml`) and routes.
express = require 'express'
assets = require 'connect-assets'
load = require 'express-load'
require 'js-yaml'

# We also extract the required functions from the 
# `underscore` lib, so we don't have to use the 
# underscore prefix and from node's `path` module. 
{extend} = require 'underscore'
{join} = require 'path'

# Initialize the express app, and make it the
# module's export.
module.exports = app = express()

# We also do this tiny hack, which tries to load
# `./env` from the current directory. I use the 
# env file to set local environment variables, 
# specially when working with databases and cookies.
# Make sure we don't add the env file to the git repository.
try extend process.env, require './env' catch err

# We start by setting the root path to `__dirname`,
# this allows us to reference the app's main dir
# from other scripts, without any hacks.
#
# We extract the port number from the environment
# variables (at least on Heroku) or we use 3000.
#
# We set the views directory and engine and also
# a default title.
app.set 'root', __dirname
app.set 'port', process.env.PORT or 3000
app.set 'views', join __dirname, "views"
app.set 'view engine', 'jade'
app.set 'title', ""

## Middleware

# We load our basic express middleware,
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()

# and create a middleware function
# to pass the request object as a local
# to our views, which I think is kinda neat.
app.use (req, res, next) ->
  res.locals.request = req
  do next

# We use our `connect-assets` middleware
# we required above without passing any arguments
# so it uses it's defaults.
#
# I like setting the static directory to the same
# as the `connect-assets` middleware, `./assets`
# which is it's default.
#
# Then add the router. 
app.use assets()
app.use express.static join __dirname, "assets"
app.use app.router

# We use the express-load module to conveniently 
# add the yml files inside the locals directory 
# into the app locals and load our route files.
load('locals').into(app)
load('routes').into(app)

# Add the error handler when we're on the 
# development environment.
app.configure 'development', ->
  app.use express.errorHandler()

# Then we listen.
app.listen app.get('port')
console.log "Express server listening on port #{app.get('port')}"