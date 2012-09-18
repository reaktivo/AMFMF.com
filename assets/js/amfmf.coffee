window.AMFMF =
        
  init: ->
        
    @backgrounds = $ '#backgrounds'
    @selectedBand = null
                    
    $('.band').each (i, band) =>

      # select elements
      band = $ band
      info = $ '.info', band
      h1 = $ 'h1', band
      
      # remove height 0
      info.css(height: 'auto')
      info.slideUp(0)
        
      # add click event
      h1.click (e) => @selectBand(e)
        
  selectBand: (e) ->
        
    # set band element
    band = $(e.currentTarget).closest('.band')
        
    # set band id
    bandId = band.attr 'id'
        
    # do nothing if band is selected
    return if @selectedBand is band
          
    # hide selectedBand info
    $('.info', @selectedBand).slideUp()
          
    # set selectedBand to clicked element
    @selectedBand = band
          
    # show newly selected band info
    $('.info', @selectedBand).slideDown()
          
    # create image container element
    image = $('<div>').css
          
      # set background to band image
      background: "url(#{band.data('image')})"
          
      # hide image element
      opacity: 0
            
    # fade in image
    image.animate({opacity: 1}, complete: => do @clearBackground)
          
    # add to backgrounds
    @backgrounds.append(image)
        
  clearBackground: ->
    $('*:not(:last-child)', @backgrounds).each -> do $(this).remove


# init AMFMF on domready
$ -> do AMFMF.init