## lineup.coffee

# Every route file is passed the app instance
# by the `express-load` module.
module.exports = (app) ->
  
  # We set the handler middleware to reuse it
  # by the `/` and `/bandName` routes.
  #
  # We create the bandName routes by 
  # looping thru each band name and creating a
  # GET route.
  handler = (req, res) ->
    res.locals req.query
    res.render 'lineup/index', title: 'AMFMF 2012'
  
  app.get "/", handler
  
  for band, data of app.locals.bands
    app.get "/lineup/#{band}", handler