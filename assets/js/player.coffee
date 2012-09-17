window.Player = 
    
  isPlaying: null
      
  sounds: {}
    
  init: ->
        
    # add click events to .play elements
    $('.play').click (e) =>
        
      # stop from following link
      do e.preventDefault
        
      # get sound element
      sound = $ e.currentTarget
          
      # set sound source
      src = sound.attr 'href'
          
      # toggle pause if clicked same sound
      return do @isPlaying.togglePause if @isPlaying is @sounds[src]
          
      # stop currently playing sound
      do @isPlaying?.stop
            
      # create new sound
      unless @sounds[src]
        @sounds[src] = soundManager.createSound
          id: src
          url: src
      
      # set new isPlaying
      @isPlaying = @sounds[src]
            
      # play new sound
      do @isPlaying.play
      

soundManager.setup
  url: '/soundmanager/'
  onready: => do Player.init