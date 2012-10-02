### All My Friends Music Festival
### AMFMF.com

This is the source code for the AMF Music Festival website. You can also checkout `groc`'s [generated documentation](http://amfmf.com/docs).

### Getting Started

To install all the dependencies

    npm install


To start the amfmf.com server

    npm start


To generate the documentation

    npm run-script docs
    
### Source

Unfortunately almost every piece of code is written on a language that compiles to another, the only javascript file you will find is `server.js` which handles requiring `coffee-script` and loading the main `app.coffee` file.

Style files are written in [`stylus`](http://learnboost.github.com/stylus/), compilation is handled on runtime, by the `connect-assets` module, so there is no need to manually compile anything. This includes the coffeescript files located at `assets/js`.
  
### Bands

Band info is located on the `locals/bands.yml`. Every band has a web safe url which is used to reference the band's image and sound file on `assets/bands`.

### Documentation

Generated documentation is placed under the assets folder, therefore available for the public at [amfmf.com/docs](http://amfmf.com/docs).