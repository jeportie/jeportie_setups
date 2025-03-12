return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 4096,
        -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jonarrien/telescope-cmdline.nvim",
    },
    keys = {
      { "Q", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
      { "<leader><leader>", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
    },
    opts = {
      extensions = {
        cmdline = {
          -- your plugin settings here
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("cmdline")
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
  },
  {
    "42Paris/42header",
    keys = {
      { "<F1>", "<cmd>Stdheader<CR>", desc = "Insert 42 Header" },
    },
    config = function()
      -- Optionally, set your user variables here if you haven't set them elsewhere.
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
  },
  {
    "weilbith/nvim-floating-tag-preview",
    config = function()
      require("nvim-floating-tag-preview").setup({
        -- Optional configuration:
        -- preview_delay = 300,  -- delay (in ms) before showing the preview
      })
    end,
  },
  {
    "weilbith/nvim-lsp-smag",
    config = function()
      require("nvim-lsp-smag").setup({
        -- Optional configuration options can be added here.
        -- See the plugin's README for available options.
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline", -- load when the command is used
    keys = {
      { "<leader>so", "<cmd>SymbolsOutline<CR>", desc = "Toggle Symbols Outline" },
    },
    config = function()
      require("symbols-outline").setup({
        auto_preview = false,
        symbols = {
          File = { icon = "", hl = "TSURI" },
          Module = { icon = "󰕳", hl = "TSNamespace" },
          Namespace = { icon = "", hl = "TSNamespace" },
          Package = { icon = "", hl = "TSNamespace" },
          Class = { icon = "", hl = "TSType" },
          Method = { icon = "", hl = "TSMethod" },
          Property = { icon = "", hl = "TSMethod" },
          Field = { icon = "", hl = "TSField" },
          Constructor = { icon = "", hl = "TSConstructor" },
          Enum = { icon = "", hl = "TSType" },
          Interface = { icon = "", hl = "TSType" },
          Function = { icon = "", hl = "TSFunction" },
          Variable = { icon = "", hl = "TSConstant" },
          Constant = { icon = "", hl = "TSConstant" },
          String = { icon = "", hl = "TSString" },
          Number = { icon = "", hl = "TSNumber" },
          Boolean = { icon = "", hl = "TSBoolean" },
          Array = { icon = "", hl = "TSConstant" },
          Object = { icon = "", hl = "TSType" },
          Key = { icon = "", hl = "TSType" },
          Null = { icon = "", hl = "TSType" },
          EnumMember = { icon = "", hl = "TSField" },
          Struct = { icon = "", hl = "TSType" },
          Event = { icon = "", hl = "TSType" },
          Operator = { icon = "", hl = "TSOperator" },
          TypeParameter = { icon = "", hl = "TSParameter" },
        },
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons",     -- optional
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      require("actions-preview").setup {
        diff = {
          ctxlen = 3,
          algorithm = "patience",
          ignore_whitespace = true,
        },
        highlight_command = {
          -- external highlight commands can be added here if desired
        },
        backend = { "telescope", "minipick", "snacks", "nui" },
        telescope = vim.tbl_extend("force",
          require("telescope.themes").get_dropdown({ winblend = 10 }),
          {
            make_value = nil,
            make_make_display = nil,
          }
        ),
        nui = {
          dir = "col",
          keymap = nil,
          layout = {
            position = "50%",
            size = {
              width = "60%",
              height = "90%",
            },
            min_width = 40,
            min_height = 10,
            relative = "editor",
          },
          preview = {
            size = "60%",
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
          },
          select = {
            size = "40%",
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
          },
        },
        snacks = {
          layout = { preset = "default" },
        },
      }
      -- Bind F5 to show the action preview window in normal and visual modes
      vim.keymap.set({ "n", "v" }, "<F5>", require("actions-preview").code_actions)
    end,
  },
}
