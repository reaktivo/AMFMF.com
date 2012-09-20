module.exports = (app) ->
  
  app.get '/', (req, res) ->
    res.locals(req.query)
    res.render 'bands/index', title: 'AMFMF 2012'