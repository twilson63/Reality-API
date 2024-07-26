/**
 * os update
 * 
 * this command will load all of the latest aos process modules into memory on an existing 
 * process. This should allow us to have a better devX experience when building the os, 
 * as well as make it easier for users to update their processes.
 */
import fs from 'node:fs'
import os from 'node:os'
import * as url from 'url'


let __dirname = url.fileURLToPath(new URL('.', import.meta.url));
if (os.platform() === 'win32') {
  __dirname = __dirname.replace(/\\/g, "/").replace(/^[A-Za-z]:\//, "/")
}

export function bundle() {
  // let luaFiles = fs.readdirSync(__dirname + "../../process")
  //   .filter(n => /\.lua$/.test(n))
  let luaFiles = ['DbAdmin.lua', 'Chat.lua', 'World.lua', 'WorldTemplate.lua', 'Agent.lua']
    .map(name => {
      const code = fs.readFileSync(__dirname + "src/" + name, 'utf-8')
      const mod = name.replace(/\.lua$/, "")
      return template(mod, code)
    })

    .concat(`
 print([[

Congrats! You just installed the @reality/api

Are you creating an Agent or World?

Reality = require('@reality/api')

For instructions for Agent:

Reality.help('agent')

For instructions fro World:

Reality.help('world')


]])
      `)
    .concat(function () {
      const code = fs.readFileSync(__dirname + "src/api.lua", 'utf-8')
      return `
function load_api() 
  ${code}
end
return load_api()
        `
    }())
    .join('\n\n')


  luaFiles = luaFiles + '\n'

  fs.writeFileSync('bundle.lua', luaFiles)
}

function template(mod, code) {
  return `
local function load_${mod.replace("-", "_")}() 
  ${code}
end
_G.package.loaded["@reality/${mod}"] = load_${mod.replace("-", "_")}()
-- print("loaded ${mod}")
  `
}


bundle()