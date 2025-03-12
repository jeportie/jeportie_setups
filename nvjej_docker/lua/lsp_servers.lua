-- File: ~/.config/nvim/lua/custom/lsp_servers.lua
local servers = {
  "clangd",              -- C/C++
  "lua_ls",				 -- Lua
  "pyright",             -- Python
  "ts_ls",				 -- TypeScript/JavaScript (make sure this matches your LSP name)
  "bashls",              -- Bash
  "html",                -- HTML
  "cssls",               -- CSS
  "cmake",               -- CMake
  "dockerls",            -- Docker
  "jsonls",              -- JSON
}

return servers
