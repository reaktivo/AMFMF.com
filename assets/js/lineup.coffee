# We start by creating the Lineup object in the `App` 
# namespace to prevent clashing with other js frameworks.

App.Lineup =
  
  bandSelector: '.band.selected'
  
  #### The init() function
  
  init: ->
    
    # We create a page handler to route `/bands/the-band` 
    # kind of uri to the `showBand` method.
    page '/lineup/:band', (ctx) =>
      @showBand ctx.params.band
    
    # We wait for `WebFontConfig.ready` to start the page router.
    WebFontConfig.ready -> 
      setTimeout(page.start, 200)

    $('.band').each (i, band) =>
 
      # Remove default css styles and hide the band's `.info` element
      # to prevent flickering when js is loaded
      $('.info', band) 
        .css(height: 'auto')
        .slideUp(0)
      
      # then add click event handlers to the band names.
      $('h1', band).click (e) => 
        
        # We find the closest `.band` element based on the
        # click event's `currentTarget` property.
        band = $(e.currentTarget).closest('.band')
 
        # Each band's html element has an id set with a url-safe
        # id, which is also used to identify a band's image or mp3 file
        # in the assets directory.  
        bandId = band.attr 'id'
        
        # Then we navigate to band page.
        page("/lineup/#{bandId}")
 
 
  #### The showBand() function
  
  showBand: (bandId) ->
    
    # First we find the band's html element.
    band = $ "##{bandId}"
    
    # If the clicked band is the same as the currently
    # selected band break out of the function.
    return if band.hasClass 'selected'
    
    # We set a reference to the currently selected band
    selected = $(@bandSelector)
    
    # And we remove it's selected class
    selected.removeClass 'selected'

    # We also hide the band's info using the
    # slide effect.
    $('.info', selected).slideUp()

    # We set the selectedBand to be the clicked band
    band.addClass 'selected'

    # and display the new selected band's info.
    $('.info', band).slideDown =>
      $.smoothScroll
        offset: -55
        scrollTarget: @bandSelector
    
    # We use the band's id to build their image uri
    imageSrc = "/bands/#{bandId}.jpg"
    
    # and then show the band image
    @showBandImage imageSrc
    
      
      
  
  ####  The showBandImage() function
  
  # `showBandImage` remove the previous band images
  # and builds a new element to append to the 
  # band images container (`#images`).
  showBandImage: (src) ->
    
    imagesEl = $ '#images'
    
    $('> :not(:last-child)', imagesEl).each ->          
      do $(this).remove
    
    $('<div>')
      .css(background: "url(#{src})")      
      .appendTo(imagesEl)


#### Last but not least

# We init the AMFMF singleton.
# Calling this on domready is not required
# because all elements selected should already
# be in place by the time the amfmf script
# is loaded.

do App.Lineup.init