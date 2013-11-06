IRLibLoader = {} if typeof IRLibLoader is "undefined"

IRLibLoader._libs = IRLibLoader._libs or {}
  
IRLibLoader.load = (src) ->
  console.log 'LibLoader.load', src, @_libs
  self = @
  unless @_libs[src]
    @_libs[src] =
      src: src
      ready: false
      readyDeps: new Deps.Dependency
    console.log '$.getScript'
    $.getScript(src, () ->
      console.log '$.getScript loaded'
      # todo: handle error
      lib = self._libs[src]
      lib.ready = true
      lib.readyDeps.changed()
    )

  handle =
    ready: () ->
      lib = self._libs[src]        
      console.log 'LibLoader.handle.ready', src, lib
      lib.readyDeps.depend()
      return lib.ready

  return handle