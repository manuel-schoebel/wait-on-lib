wait-on-lib
===========

Use Iron-Router waitOn to load external javascript libraries

###Load one or more independend libraries
IRLibLoader returns a handle similar to a subscriptions handle. It is ready as soon as the external script is loaded.

    Router.map( function () {
      this.route('codeEditor',{
        waitOn: function(){
            return [IRLibLoader.load('https://some-external.com/javascript.js'), IRLibLoader.load("smthels.js")]
        }
      });
    });

###Load dependend libraries
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

###Order preserving load with waitOn
The method `IRLibLoader.loadInOrder` accepts an array of urls and loads them in that order one by one. This is light-weight and easy to use mechanism that works with any number of urls (since you do not need to explicitly dove-tail the callbacks). 
````
Router.map( function () {
  this.route('codeEditor',{
    waitOn: function(){
        return 	IRLibLoader.loadInOrder([
							"//www.google.com/jsapi",
							"//d26b395fwzu5fz.cloudfront.net/3.2.0/keen.js",
							"//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min.js",
							"//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.2/backbone-min.js",
							"//cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js",
							"//okfnlabs.org/elasticsearch.js/elasticsearch.js",
							"//okfnlabs.org/recline.backend.gdocs/backend.gdocs.js",
							"//okfnlabs.org/recline/dist/recline.js",
							"//cdnjs.cloudflare.com/ajax/libs/codemirror/4.10.0/codemirror.min.css",
							"//cdnjs.cloudflare.com/ajax/libs/codemirror/4.10.0/codemirror.min.js",
							"//cdnjs.cloudflare.com/ajax/libs/codemirror/4.10.0/addon/display/fullscreen.min.css",
							"//cdnjs.cloudflare.com/ajax/libs/codemirror/4.10.0/addon/display/fullscreen.min.js",
							"//cdnjs.cloudflare.com/ajax/libs/codemirror/4.10.0/addon/display/placeholder.min.js",
							"//handsontable.com/dist/handsontable.full.css",
							"//handsontable.com/dist/handsontable.full.js"
							]);
       	}
  });
});
````
The implementation of `IRLibLoader.loadInOrder` guarantees that the above files are loaded in that above indicated order. If any one of them fails to load, the load will continue with the next one in the order (rather than breaking or halting the load). 
Note: Loading the css files may require the patch: https://github.com/DerMambo/wait-on-lib/pull/9
