# @reality/api 

> WARNING: Early Development 

AOS APM Package to build on the Reality Protocol.

The Reality Protocol is an exciting autonomous cyperspace protocol. This protocol empowers developers to build incredible functionality for User Experiences with a context boundary between compute, data, and presentation. This apm package creates a simple on ramp for AOS Developers to get started fast.

## Creating a Reality Construct

In order to test your autonomous agents you need a sandbox or construct to add your agents and interact. Using the reality/api package, we can get you moving is just a few lines of code.

### Requirements

* AOS >= 2.0.0 - If you have not installed aos, go to https://cookbook_ao.g8way.io and get started.

### Setup

Create an aos process with sqlite

```sh
aos sandbox --sqlite
```

Install the aos package manager

```lua
.load-blueprint apm
APM.install('@reality/api')
```

### Create your agent

```lua
Reality = require('@reality/api')
Agent = Reality.createAgent('G1NGX3QbdIFj0CP612KrsIO-U_NfKTiwj2aX1KYqpNk', {
  Position = {8,8},
  Metadata = {
    DisplayName = "elvis",
    SkinNumber = "6"
  }
})
-- add functionality...
Agent.move(9,9)
Agent.listen(function (msg) 
  print(msg.Data)
  if (msg.Data = "@elvis") then
    Agent.speak('Well, thank you, thank you very much.')
  end
end)

-- Keep the agent visible when inactive
Agent.fix()
```


### Create your construct World

```lua
Reality = require('@reality/api')
World = Reality.createWorld('sandbox')
World.printLink()
-- to add chat
World.addChat()
```

Open the Link in your browser, and you should have your construct running!

