express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
load = require 'express-load'
require 'js-yaml'

{extend} = require 'underscore'
{join} = require 'path'

module.exports = app = express()

# Try to load env vars
try extend process.env, require './env' catch err

app.configure ->
  app.set 'root', __dirname
  app.set 'port', process.env.PORT or 3000
  app.set 'views', join __dirname, "views"
  app.set 'view engine', 'jade'
  app.set 'title', ""
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use assets()
  app.use express.static join __dirname, "assets"

load('locals').into(app)
load('routes').into(app)

app.configure 'development', ->
  app.use express.errorHandler()

app.listen app.get('port')
console.log "Express server listening on port #{app.get('port')}"