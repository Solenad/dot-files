return {
  {
    "brianhuster/live-preview.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- or your preferred picker
    },
    config = function()
      require("livepreview.config").set({
        port = 5500,           -- default port
        browser = "default",   -- or "firefox", "chrome", etc.
        dynamic_root = false,
        sync_scroll = true,
        picker = "telescope",  -- or "fzf-lua", "mini.pick", "snacks.picker"
      })
    end,
  },
}
