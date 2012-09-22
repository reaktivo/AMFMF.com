module.exports = (app) ->
  
  handler = (req, res) ->
    res.locals(req.query)
    res.render 'bands/index', title: 'AMFMF 2012'
  
  app.get "/", handler
  
  for band, data of app.locals.bands
    app.get "/lineup/#{band}", handler