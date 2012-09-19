window.Player = 
    
  isPlaying: null
      
  sounds: {}
    
  init: ->
        
    # add click events to .play elements
    $('.play').click (e) =>  
        
      # stop from following link
      do e.preventDefault
      
      $('.playing').removeClass 'playing'
        
      # get sound element
      sound = $ e.currentTarget
      
      # set sound source
      src = sound.attr 'href'
      
      # create new sound
      unless @sounds[src]
        @sounds[src] = soundManager.createSound
          id: src
          url: src
      
      # stop playing sound
      do @isPlaying?.stop
      
      # check if same as playing sound
      if @isPlaying is @sounds[src]
        
        # set playing sound to null
        @isPlaying = null
        
      else
      
        # set new playing sound
        @isPlaying = @sounds[src]
        
        # play new sound
        do @isPlaying.play
        
        # add class to button
        sound.addClass 'playing'
      

soundManager.setup
  url: '/soundmanager/'
  onready: => do Player.init