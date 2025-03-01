return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("neotest").setup({
        -- for example:
        adapters = {
          -- put your neotest adapters here
        },
      })
    end,
  },
}
