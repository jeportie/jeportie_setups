return {
  {
    "42Paris/42header",
    keys = {
      { "<F1>", "<cmd>Stdheader<CR>", desc = "Insert 42 Header" },
    },
    config = function()
      vim.cmd([[
        let g:user42 = 'jeportie'
        let g:mail42 = 'jeportie@student.42.fr'
      ]])
    end,
  },
  {
    "jeportie/NorminetteRun",
    keys = {
      { "<F12>", "<cmd>NorminetteRun<CR>", desc = "Run Norminette" },
    },
    config = function()
      -- Default state: enabled (1) means auto-check on save is active.
      vim.g.norminette42 = 1

      -- Create a user command to toggle auto-checking.
      vim.api.nvim_create_user_command("Norminette42", function(opts)
        local arg = opts.args
        if arg == "0" or arg == "1" then
          vim.g.norminette42 = tonumber(arg)
          print("Norminette42 auto-check set to " .. vim.g.norminette42)
        else
          print("Usage: :Norminette42 <0|1>")
        end
      end, { nargs = 1 })

      -- Automatically run NorminetteRun on file save if toggle is enabled.
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          if vim.g.norminette42 == 1 then
            vim.cmd("NorminetteRun")
          end
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lsp_servers = require("custom.lsp_servers")
      require("mason").setup({
        ui = {
           icons = {
            package_installed   = "",
            package_pending     = "",
            package_uninstalled = "",
          },
        },
      })
      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
        automatic_installation = true,  -- Automatically install missing LSP servers
      })
    end,
  }
}
