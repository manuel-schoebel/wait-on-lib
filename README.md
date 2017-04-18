wait-on-lib
===========

Use Iron-Router waitOn to load external javascript libraries

### Load one or more independend libraries
IRLibLoader returns a handle similar to a subscriptions handle. It is ready as soon as the external script is loaded.

    Router.map( function () {
      this.route('codeEditor',{
        waitOn: function(){
            return [IRLibLoader.load('https://some-external.com/javascript.js'), IRLibLoader.load("smthels.js")]
        }
      });
    });

### Load dependend libraries
Here we have one.js and two.js. two.js has to be loaded secondly because it depends on one.js. This is how you can do this:

    Router.map(function(){
      this.route('home', {
        path: '/',
        onBeforeAction: function(){
          var one = IRLibLoader.load('/one.js', {
            success: function(){ console.log('SUCCESS CALLBACK'); },
            error: function(){ console.log('ERROR CALLBACK'); }
          });
          if(one.ready()){

            var two = IRLibLoader.load('/two.js');
            if(two.ready()){
              this.next();
            }
          }
        }
      });
    });

Also notice that you can use an error and success callback in the IRLibLoader options.
