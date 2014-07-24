# wait-on-lib

Use Iron-Router ```waitOn``` or ```onBeforeAction``` hooks to load external javascript libraries. 

Scripts will be cached for browser reuse.

## Load one or more independent libraries
```IRLibLoader``` returns a handle similar to a subscriptions handle. It is ready as soon as the external script is loaded.

```javascript
Router.map(function() {
  this.route('codeEditor',{
    waitOn: function() {
        return [
            IRLibLoader.load('https://some-external.com/some.js'), 
            IRLibLoader.load("https://some-external.com/another.js")
        ]
    }
  });
});
```

In case above scripts load order wasn't preserved. 

## Load dependend libraries
Here we have ```one.js``` and ```two.js```. ```two.js``` has to be loaded secondly because it depends on ```one.js```.

```javascript
Router.map(function() {
  this.route('home', {
    path: '/',
    onBeforeAction: function(pause){
      
      var one = IRLibLoader.load('/one.js', {
        success: function() { 
            console.log('SUCCESS CALLBACK'); 
        },
        error: function() { 
            console.log('ERROR CALLBACK'); 
        }
      });
      
      if(!one.ready()){ return pause(); }

      var two = IRLibLoader.load('/two.js');
      
      if(!two.ready()){ return pause(); }
    }
  });
});
```

Also notice that you can use an ```error``` and ```success``` callback in the ```IRLibLoader``` options.
