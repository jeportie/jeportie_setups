return {
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = function()
      require('goto-preview').setup {
        width = 120,               -- Width of the floating window
        height = 15,               -- Height of the floating window
        border = {"↖", "─", "┐", "│", "┘", "─", "└", "│"},  -- Border characters
        default_mappings = false,  -- We set our own mappings below
        debug = false,             -- Debug information disabled
        opacity = nil,             -- Opacity level (nil means disabled)
        resizing_mappings = false, -- No arrow key resizing mappings
        post_open_hook = nil,      -- Function to run after the window opens
        post_close_hook = nil,     -- Function to run after the window closes
        references = {             -- Configure the references UI with telescope
          provider = "telescope",  
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
        },
        focus_on_open = true,      -- Focus the floating window on open
        dismiss_on_move = false,   -- Do not dismiss when moving the cursor
        force_close = true,        -- Force close the floating window on command
        bufhidden = "wipe",        -- Buffer option for the floating window
        stack_floating_preview_windows = true, -- Allow stacking floating windows
        same_file_float_preview = true,          -- Open a new floating window for a reference in the same file
        preview_window_title = { enable = true, position = "left" }, -- Show filename in preview window title
        zindex = 1,                -- Z-index for window stacking
      }
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<leader>pd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>pt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>pi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>pD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>pr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>pc", "<cmd>lua require('goto-preview').close_all_win()<CR>", opts)
    end,
  },
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
}

