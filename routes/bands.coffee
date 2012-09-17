module.exports = (app) ->
  
  app.get '/', (req, res) ->
    res.render 'bands/index', title: 'AMFMF 2012'