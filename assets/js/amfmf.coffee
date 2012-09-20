# We start by setting a global AMFMF namespace to prevent
# clashing with other js frameworks.

window.AMFMF =
  
  #### The init() function
  
  # We then create an initialization function which
  # caches the band images container element `#backgrounds`.
  init: ->
    
    @backgrounds = $ '#backgrounds'

    $('.band').each (i, band) =>
 
      # Remove default css styles and hide the band's `.info` element
      # to prevent flickering when js is loaded
      $('.info', band) 
        .css(height: 'auto')
        .slideUp(0)
      
      # then add click event handlers to the band names.
      $('h1', band).click (e) => @selectBand(e)
 
 
  #### The selectBand() function
  
  # `selectBand` is what happens after we click a band name.
  selectBand: (e) ->
        
    # First we find the closest `.band` element based on the
    # click event's `currentTarget` property.
    band = $(e.currentTarget).closest('.band')
    
 
    # Each band's html element has an id set with a url-safe
    # id, which is also used to identify a band's image or mp3 file
    # in the assets directory.  
    bandId = band.attr 'id'
    
    # We use this value to build the band's image uri.
    imageSrc = "/bands/#{bandId}.jpg"
    
    # If the clicked band is same as the currently selected band
    # break out of the function.
    return if @selectedBand is band
    
    # If not, hide the currently select band's info using the
    # slide effect.
    $('.info', @selectedBand).slideUp()
    
    # We set the selectedBand to be the clicked band
    @selectedBand = band
    
    # and display the new selected band's info.
    $('.info', @selectedBand).slideDown()
    
    # and then show the band image         
    @showBandImage imageSrc
  
  ####  The showBandImage() function
  
  # `showBandImage` remove the previous band images
  # and adds builds a new element to append to the 
  # band images container (`#backgrounds`).
  showBandImage: (src) ->
    
    $('> :not(:last-child)', @backgrounds).each ->          
      do $(this).remove
    
    $('<div>')
      .css(background: "url(#{src})")      
      .appendTo(@backgrounds)


#### Last but not least

# We init the AMFMF singleton.
# Calling this on domready is not required
# because all elements selected should already
# be in place by the time the amfmf script
# is loaded

do AMFMF.init