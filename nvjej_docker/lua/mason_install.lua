-- File: ~/.config/nvim/lua/custom/mason_install.lua
local M = {}

-- Get the shared list of LSP servers.
local lsp_servers = require("custom.lsp_servers")

-- Define additional tools (linters and formatters)
local extra_tools = {
  -- Linters:
  "shellcheck",
  "markdownlint",
  -- Formatters:
  "stylua",
  "clang-format",
}

-- Combine LSP servers with the extra tools
M.ensure_installed = vim.tbl_extend("force", lsp_servers, extra_tools)

return M
