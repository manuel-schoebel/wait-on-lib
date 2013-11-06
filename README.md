wait-on-lib
===========

Use Iron-Router waitOn to load external javascript libraries


IRLibLoader returns a handle similar to a subscriptions handle. It is ready as soon as the external script is loaded.

    Router.map( function () {
      this.route('codeEditor',{
        waitOn: IRLibLoader.load('https://some-external.com/javascript.js')
      });
    });
