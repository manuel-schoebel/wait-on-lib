IRLibLoader = {} if typeof IRLibLoader is "undefined"

IRLibLoader._libs = IRLibLoader._libs or {}
  
IRLibLoader.load = (src, options) ->
  self = @
  opt = options
  unless @_libs[src]
    @_libs[src] =
      src: src
      ready: false
      readyDeps: new Deps.Dependency
      options: options
    $.ajax({
      url: src
      dataType: 'script'
      success: (data, textStatus, jqxhr) ->        
        lib = self._libs[src]        
        if jqxhr.status is 200
          lib.ready = true
          lib.readyDeps.changed()
          options.success() if options and options.success

      error: () ->
        options.error(arguments) if options.error
    })

  handle =
    ready: () ->      
      lib = self._libs[src]
      lib.readyDeps.depend()
      return lib.ready

  return handle