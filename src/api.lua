local api = { _version = "0.0.1" }
local world = require('@reality/World')
local template = require('@reality/WorldTemplate')
local chat = require('@reality/Chat')

function api.createWorld(name)
  -- create World
  world()
  print('World Created!')
  template(name)
  print('World Template Created!')
  
  return {
    addChat = function () 
      chat()
      print('Chat Loaded!')
    end,
    addAgent = function ()
      
    end,
    printLink = function ()
      print('https://reality-viewer.g8way.io/#/' .. ao.id)
    end
  }
end

function api.createAgent()
  local world = nil
  return {
    register = function(id)
      world = id
      
    end,
    watchChat = function(fn) 
      Handlers.add("WatchChat", "ChatMessage", fn)
    end,
    move = function ()

    end
  }
end


return api