App.AMFMF = 

  init: ->
    
    WebFontConfig.ready -> 
      $('.band h1').slabText()
    
    $('#menu a').on 'click', (e) => 
      a = $ e.currentTarget 
      section = a.data('section')
      if section
        @showSection section
        e.preventDefault()

  showSection: (section) ->
    
    return unless section

    $.smoothScroll
      offset: -20
      scrollTarget: "##{section}"     
     

 

do App.AMFMF.init