local enabled = false -- Start with it disabled

return {
  "sphamba/smear-cursor.nvim",
  config = function()
    if enabled then
      require("smear-cursor").setup({
        smear_between_buffers = true,
        smear_between_neighbor_lines = true,
        scroll_buffer_space = true,
        legacy_computing_symbols_support = false,
        smear_insert_mode = false,
        cursor = { enable = false },
        stiffness = 1,
        trailing_stiffness = 0.3,
        distance_stop_animating = 0.6,
        hide_target_hack = false,
      })
    end
  end,
}
