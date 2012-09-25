App.AMFMF = 

  date: "20121117"

  init: ->
    
    unless @isiPhone
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
      offset: -55
      scrollTarget: "##{section}"     
     
  showTimeLeft: ->
    document.title += " " + moment(@date, "YYYYMMDD").fromNow()
 
  isiPhone:
    (navigator.platform.indexOf("iPhone") != -1) or
    (navigator.platform.indexOf("iPod") != -1)
 

do App.AMFMF.init