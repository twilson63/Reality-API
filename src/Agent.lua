local agent = { _version = "0.0.1" }

local function merge(t1, t2)
  for k, v in pairs(t2) do
      if type(v) == "table" and type(t1[k]) == "table" then
          merge(t1[k], v)
      else
          t1[k] = v
      end
  end
  return t1
end

local default = {
  Position = {10,10},
  Type = 'Avatar',
  Metadata = {
    DisplayName = 'Test Avatar',
    SkinNumber = 5,
    Interaction = {
      Type = "Default"
    }
  }
}
local WORLD = ""
local AGENT_CONFIG = default 
local AGENT_SCHEMA = {}

function agent.config(cfg)
  return cfg and merge(default, cfg) or default
end

function agent.register(world, config)
  WORLD = world
  AGENT_CONFIG = agent.config(config)
  Send({ 
    Target = world, 
    Action = "Reality.EntityCreate",
    Data = require('json').encode(AGENT_CONFIG)
  }).onReply(function (msg)
    print('created agent')
  end)
end

function agent.listen(fn)
  Handlers.add("Agent.Listen", "ChatMessage", fn)
end

function agent.move(x,y)
  Send({
    Target = WORLD, 
    Action = "Reality.EntityUpdatePosition", 
    Data = require('json').encode({ Position = {x,y}}) 
  })
  print('moved avatar')
end

function agent.speak(txt)
  Send({
    Target = WORLD,
    Tags = {
      Action = "ChatMessage",
      ['Author-Name'] = AGENT_CONFIG.Metadata.DisplayName
    },
    Data = txt
  })
end

function agent.fix()
  Send({
    Target = WORLD,
    Tags = {
      Action = "Reality.EntityFix",
    }
  })
end

function agent.hide()
  Send({
    Target = WORLD,
    Tags = {
      Action = "Reality.EntityHide",
    }
  })
end

function agent.schema(name, schema, callback)
  assert(type(schema) == 'table', 'schema MUST be table')
  assert(type(callback) == 'function', 'callback MUST be function') 
  
  AGENT_SCHEMA = { [name] = schema }
  Handlers.add("Agent.Schema", "Schema", {
    [{Action = "Schema"}] = function (msg)
      msg.reply({
        Tags = { Type = "Schema" },
        Data = require('json').encode(AGENT_SCHEMA)
      })
    end
  })
end

function agent.onSubmit(fn)
  local action = AGENT_SCHEMA.Form.Schema.Tags.properties.Action.const
  Handlers.add("Agent.SchemaSubmit", action, fn)
end

return agent