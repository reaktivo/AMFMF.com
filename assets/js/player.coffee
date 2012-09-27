# Make sure the App namespace already exists.
window.App or= {}

# `App.Player` is responsible for playing
# and stoping sounds. And managing the visual
# state of the buttons used to play & pause.
App.Player = 
  
  sounds: {}

  # `init` adds click handlers to the bands
  # play buttons.
  init: ->
        
    $('.play').click (e) => 
      do e.preventDefault
      
      # The `playing` css class is added
      # or removed from the clicked play button. 
      $('.playing').removeClass 'playing'
      btn = $(e.currentTarget)
      if @playSound(btn.attr('href'))
        btn.addClass 'playing'
  
  # `playSound` stop the currently playing sound
  # and start the new one, also return the sound instance
  playSound: (src) ->
            
    do @sound?.stop
      
    newSound = @getSound src
    if @sound is newSound  
      @sound = null
    else
      do newSound.play
      $("*[href=\"#{src}\"]").addClass 'playing'
      @sound = newSound

  # `getSound` returns a reference to the
  # soundmanager2's sound object or creates
  # one if none exists.
  getSound: (src) ->
    unless @sounds[src]
      @sounds[src] = soundManager.createSound
        id: src
        url: src

# We also call the global `soundManager.setup` method
# to initialize `App.Player` when the soundmanager is ready
soundManager.setup
  url: '/soundmanager/'
  onready: => do App.Player.init