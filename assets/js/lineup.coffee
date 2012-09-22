# We start by creating the Lineup object in the `App` 
# namespace to prevent clashing with other js frameworks.

App.Lineup =
  
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
        bandEl = $(e.currentTarget).closest('.band')
 
        # Each band's html element has an id set with a url-safe
        # id, which is also used to identify a band's image or mp3 file
        # in the assets directory.  
        band = bandEl.attr 'id'
        
        # Then we navigate to band page.
        page("/lineup/#{band}")
 
 
  #### The showBand() function
  
  showBand: (band) ->
    
    console.log 'showBand', band
    
    # First we find the band's html element.
    bandEl = $ "##{band}"
    
    # If the clicked band is same as the currently selected band
    # break out of the function.
    return if @selectedBand is bandEl

    # If not, hide the currently select band's info using the
    # slide effect.
    $('.info', @selectedBand).slideUp()

    # We set the selectedBand to be the clicked band
    @selectedBand = bandEl

    # and display the new selected band's info.
    $('.info', @selectedBand).slideDown =>
      $.smoothScroll
        offset: -20
        scrollTarget: "##{band}"
        afterScroll: =>          
    
    # We use the band's id to build their image uri
    imageSrc = "/bands/#{band}.jpg"
    
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