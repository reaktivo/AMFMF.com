# AMFMF.coffee is a global singleton object used for
# miscellaneous purposes.

App.AMFMF = 
  
  # We set some constants:
  #
  # - The date of the event
  # - And the twitter user to grab news from
  date: "20121117"
  username: 'infoamf'
  
  # And then we start calling all our setup
  # functions.
  init: ->
    do @slabText
    do @setupMenu
    do @showTimeLeft
    do @loadNews
  
  #### setupMenu
    
  # `setupMenu` intercepts click events 
  # to do the smooth scroll effect.
  setupMenu: ->
    $('#menu a').on 'click', (e) => 
      a = $ e.currentTarget 
      section = a.data('section')
      if section
        @showSection section
        e.preventDefault()
  
  #### slabText      

  # Because slabText takes too much space, we
  # only apply the effect when the user is
  # browsing from a normal size non-iOS device.
  slabText: ->
    unless App.isiPhone
      WebFontConfig.ready -> 
        $('.band h1').slabText()

  #### showSection

  # `showSection` is used to smoothly scroll into a 
  # page section.
  showSection: (section) ->
    return unless section
    $.smoothScroll
      offset: -55
      scrollTarget: "#" + section     
  
  #### showTimeLeft

  # `showTimeLeft` takes care of adding the time til' the event
  # date in the browser's title.     
  showTimeLeft: ->
    fromNow = moment(@date, "YYYYMMDD").fromNow()
    document.title += " " + fromNow
  
  
  #### loadNews
  
  # `loadNews` fills the #news with the twitter feed.
  loadNews: ->
    @news = $ '#news .container'
    @news.tweet {@username}
 
#### App.isiPhone

# `App.isiPhone` is set to true when a small iOS device
# (iPhone or iPod touch) is used to browse the site.
App.isiPhone =
  (navigator.platform.indexOf("iPhone") != -1) or
  (navigator.platform.indexOf("iPod") != -1)

#### App.AMFMF.init
 
# We don't need to wait for `domready` to 
# initialize AMFMF.
do App.AMFMF.init