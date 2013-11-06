IRLibLoader = {} if typeof IRLibLoader is "undefined"

IRLibLoader._libs = IRLibLoader._libs or {}
  
IRLibLoader.load = (src) ->
  self = @
  unless @_libs[src]
    @_libs[src] =
      src: src
      ready: false
      readyDeps: new Deps.Dependency
    $.getScript(src, (data, textStatus, jqxhr) ->      
      lib = self._libs[src]
      if jqxhr.status is 200
        lib.ready = true
        lib.readyDeps.changed()
    )

  handle =
    ready: () ->
      lib = self._libs[src]
      lib.readyDeps.depend()
      return lib.ready

  return handle