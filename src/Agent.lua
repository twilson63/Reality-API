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

function agent.config(cfg)
  return cfg and merge(default, cfg) or default
end

function agent.register(world, config)
  Send({ 
    Target = world, 
    Action = "Reality.EntityCreate",
    Data = require('json').encode(agent.config(config))
  }).onReply(function (msg)
    print(msg.Data)
  end)
end

return agent