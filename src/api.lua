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
      print(RealityEntitiesStatic)
      RealityEntitiesStatic[agentId] = agent.config(config)
      print(RealityEntitiesStatic)
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
    listen = function(fn) 
      agent.listen(fn)
    end,
    move = function (x,y)
      agent.move(x,y)
    end,
    speak = function (msg)
      agent.speak(msg)
      print('posted to chat...')
    end,
    schema = function (schema, callback)
      agent.schema(schema)
      agent.onSubmit(callback)
      print('Schema Updated.')
    end
  }
end

function api.help(model)
  if model == "world" then
    print([[

To create a world:

Reality = require('@reality/api')

World = Reality.createWorld('DreamLand')

World.printLink()

-- to add chat

World.addChat()

-- add a static agent
-- * note you need to create an agent process (see CreateAgent below)
World.addAgent(agent, config)

    ]])
  elseif model == "agent" then
    print([[
To create an agent:

Reality = require('@reality/api')

-- Register Agent
Agent = Reality.createAgent('WORLD_ID', {
  Position = { 0, 0 },
  Metadata = {
    DisplayName = "Cool Llama",
    SkinNumber = 9
  }
})

-- Move Agent
Agent.move(-1,-2)

-- Listen to Chats
Agent.listen(function (msg) 
  print('chat: ' .. msg.Data)
end)

-- Message World
Agent.message("Hello I am Larry the Cool Llama")

-- on Interaction (default)
Agent.onInteraction(function (msg) 
  print('someone clicked me')
end)

-- on Schema Interaction 
Agent.schema(name, schema, function (msg) 
  print('User Completed Form')
end)


    ]])
  else
    print('must enter "world" or "agent"')
  end
end


return api