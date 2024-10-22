--#region Model

return function(name)
  RealityInfo = {
    Dimensions = 2,
    Name = name,
    ['Render-With'] = '2D-Tile-0',
  }

  RealityParameters = {
    ['2D-Tile-0'] = {
      Version = 0,
      Spawn = { 5, 7 },
      -- This is a tileset themed to Llama Land main island
      Tileset = {
        Type = 'Fixed',
        Format = 'PNG',
        TxId = 'h5Bo-Th9DWeYytRK156RctbPceREK53eFzwTiKi0pnE', -- TxId of the tileset in PNG format
      },
      -- This is a tilemap of sample small island
      Tilemap = {
        Type = 'Fixed',
        Format = 'TMJ',
        TxId = 'koH7Xcao-lLr1aXKX4mrcovf37OWPlHW76rPQEwCMMA', -- TxId of the tilemap in TMJ format
        -- Since we are already setting the spawn in the middle, we don't need this
        -- Offset = { -10, -10 },
      },
    },
  }

  RealityEntitiesStatic = {}

  --#endregion

  Handlers.add("NPC.ChatMessage", 
    function (msg)
      return msg.Action == "ChatMessage" and "continue"
    end,
    function (msg)
      print('got message')
      local authorId = msg.From
      local authorName = msg.Tags['Author-Name']
      local recipient = msg.Tags['Recipient']
      local content = msg.Data

      print('Broadcasting msg to static avatars')
      Utils.map(function (key)
        print('checking...' .. key)
        if RealityEntitiesStatic[key].Type == "Avatar" then
           print('forwarding message...')
           Send({
             Target = key,
             Action = "ChatMessage",
             ["Author-Name"] = authorName,
             ["Recipient"] = recipient,
             Data = content
           })
        end
      end, 
        Utils.keys(RealityEntitiesStatic)
      )
      print('Broadcasting msg to dynamic avatars')
      local avatars = RealityDbAdmin:exec[[select Id from Entities where Type = 'Avatar']]
      Utils.map(function (o) 
        Send({
          Target = o.Id,
          Action = "ChatMessage",
          ["Author-Name"] = authorName,
          ["Recipient"] = recipient,
          Data = content
        })
      end, avatars)
    end

  )

  return "Loaded Reality Template"
end
