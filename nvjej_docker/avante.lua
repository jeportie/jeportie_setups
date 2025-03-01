return {
  {
    "yetone/avante.nvim",
    -- Lazy-load on the :Avante command
    cmd = "Avante",
    config = function()
      -- Optionally configure Avante here:
      require("avante").setup({
        -- your settings
      })
    end,
  },
}
