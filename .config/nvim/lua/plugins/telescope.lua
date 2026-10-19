---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>lg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  },
  opts = {
    defaults = {
      hidden = false,
      file_ignore_patterns = {
        "^%.git[/\\]",
        "[/\\]%.git[/\\]",
        "^node_modules[/\\]",
        "[/\\]node_modules[/\\]",
        "^%.next[/\\]",
        "[/\\]%.next[/\\]",
        "^dist[/\\]",
        "[/\\]dist[/\\]",
        "^build[/\\]",
        "[/\\]build[/\\]",
        "^target[/\\]",
        "[/\\]target[/\\]",
        "^%.venv[/\\]",
        "[/\\]%.venv[/\\]",
        "^__pycache__[/\\]",
        "[/\\]__pycache__[/\\]",
        "%.pyc$",
        "^vendor[/\\]",
        "[/\\]vendor[/\\]",
        "^%.vscode[/\\]",
        "[/\\]%.vscode[/\\]",
        "^%.idea[/\\]",
        "[/\\]%.idea[/\\]",
        "%.DS_Store$",
      },
    },
  },
}
