App.AMFMF = 

  date: "20121117"

  init: ->
    
    WebFontConfig.ready -> 
      $('.band h1').slabText()
    
    $('#menu a').on 'click', (e) => 
      a = $ e.currentTarget 
      section = a.data('section')
      if section
        @showSection section
        e.preventDefault()
        
    do @showTimeLeft

  showSection: (section) ->
    
    return unless section

    $.smoothScroll
      offset: -20
      scrollTarget: "##{section}"     
     
  showTimeLeft: ->
    document.title += " " + moment(@date, "YYYYMMDD").fromNow()
 

do App.AMFMF.init