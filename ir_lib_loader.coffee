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
        options.error(arguments) if options and options.error
    })

  handle =
    ready: () ->      
      lib = self._libs[src]
      lib.readyDeps.depend()
      return lib.ready

  return handle
  
IRLibLoader.loadRecurse = (srcArray, index, handle) ->
  if index < 0 or index >= srcArray.length
    handle.setReady()
    return
  IRLibLoader.load srcArray[index],
    success: ->
      console.log "Loaded: " + srcArray[index]
      IRLibLoader.loadRecurse srcArray, index + 1, handle
      return
    error: (e) ->
      # this one failed - but we continue with the rest
      console.log "Error loading: " + srcArray[index]
      IRLibLoader.loadRecurse srcArray, index + 1, handle
      return
  return

IRLibLoader.loadInOrder = (srcArray) ->
  allReady = false
  readyDeps = new Deps.Dependency
  handle =
    ready: ->
      readyDeps.depend()
      return allReady
    setReady: ->
      allReady = true
      readyDeps.changed()
      return
  IRLibLoader.loadRecurse srcArray, 0, handle
  return handle
