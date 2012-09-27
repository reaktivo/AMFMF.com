# Make sure the App namespace already exists.
window.App or= {}

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
    
    # Wait for `WebFontConfig.ready` to start the page router.
    # This is needed prevent the page from scrolling to the wrong
    # y position, because of the slabText effect. 
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
        
        # We use that id to navigate to the band's page.
        page "/lineup/" + bandId
 
 
  #### The showBand() function
  
  showBand: (bandId) ->
    
    # First we find the band's html element.
    # If the clicked band is the same as the currently
    # selected band break out of the function.
    
    band = $ "#" + bandId
    
    return if band.hasClass 'selected'
    
    # We set a reference to the currently selected band
    # and remove it's "unselect" it.
    selected = $(@bandSelector)
    
    selected.removeClass 'selected'

    # We also hide the band's info using the
    # slide effect.
    $('.info', selected).slideUp()

    # We set the clicked band as selected
    # and display it's description and image
    band.addClass 'selected'

    $('.info', band).slideDown =>
      $.smoothScroll
        offset: -55
        scrollTarget: @bandSelector
    
    @showBandImage band

  
  ####  The showBandImage() function
  
  # `showBandImage` will detect if the current device
  # is an iPhone or not; and display the band's image
  # in a different format based on that.
  showBandImage: (band) ->
    
    # We get the band's id
    bandId = band.attr('id')
    
    # then use it to build their image uri.
    src = "/bands/#{bandId}.jpg"
    
    # If the device is an iPhone, we change the image
    # container underneath the band's title
    # and set the image width to full.
    if App.isiPhone
      $('img', band)
        .attr({src})
        .width("100%")
        .show()

    # If it's not an iPhone, we use the background
    # image container and remove the last image
    # the container had and set the background 
    # url to the band's image.
    else
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