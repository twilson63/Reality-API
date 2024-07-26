local api = { _version = "0.0.1" }
local world = require('@reality/World')
local template = require('@reality/WorldTemplate')
local chat = require('@reality/Chat')
local agent = require('@reality/Agent')

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
    addAgent = function (agentId, config)
      RealityEntitiesStatic[agentId] = agent.config(config)
      print('Static Agent Added')
    end,
    printLink = function ()
      print('https://reality-viewer.g8way.io/#/' .. ao.id)
    end
  }
end

function api.createAgent( world, config)
  -- register agent
  agent.register(world, config)
  
  return {
    watchChat = function(fn) 
      Handlers.add("WatchChat", "ChatMessage", fn)
    end,
    moveAgent = function (x,y)

    end,
    sendMessage = function (msg, recipient)
    
    end,
    setSchema = function (schema, callback)
    
    end
  }
end


return api