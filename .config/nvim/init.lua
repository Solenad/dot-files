-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
vim.env.PATH = "C:/Python314;" .. vim.env.PATH
vim.env.PATH = "C:/Python314/Scripts;" .. vim.env.PATH
vim.g.python3_host_prog = "C:/Python314/python.exe"
vim.env.CMAKE_POLICY_VERSION_MINIMUM = "3.5"
-- Fix for Windows PowerShell quoting/crashing issues
if vim.fn.has("win32") == 1 then
  -- Use pwsh if available, otherwise fallback to powershell
  local powershell_exe = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"

  vim.opt.shell = powershell_exe
  vim.opt.shellcmdflag =
  "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSDefaultParameterValues['Out-File:Encoding']='UTF8';"
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; return $?"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; return $?"

  -- CRITICAL: These MUST be empty strings for PowerShell on Windows
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")


vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })

-- Delete without yanking in normal and visual mode
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true })
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true })
vim.keymap.set({ "n", "v" }, "C", '"_C', { noremap = true })
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true })



vim.env.PYTHON = "C:/Python314/python.exe"
vim.env.PYTHON3 = vim.env.PYTHON
require "lazy_setup"

require "plugins-config.nvim-tree"
require("catppuccin").setup({
  flavour = "mocha",
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true, -- Keep this true
  show_end_of_buffer = false,
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false,
  no_bold = false,
  no_underline = false,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
  },
})


require 'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    }
  }, -- globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = true,
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
  -- globally enable "strict" selection of icons - icon will be looked up in
  -- different tables, first by filename, and if not found by extension; this
  -- prevents cases when file doesn't have any extension but still gets some icon
  -- because its name happened to match some extension (default to false)
  strict = true,
  -- set the light or dark variant manually, instead of relying on `background`
  -- (default to nil)
  variant = "light|dark",
  -- same as `override` but specifically for overrides by filename
  -- takes effect when `strict` is true
  override_by_filename = {
    [".gitignore"] = {
      icon = "",
      color = "#f1502f",
      name = "Gitignore"
    }
  },
  -- same as `override` but specifically for overrides by extension
  -- takes effect when `strict` is true
  override_by_extension = {
    ["log"] = {
      icon = "",
      color = "#81e043",
      name = "Log"
    }
  },
  -- same as `override` but specifically for operating system
  -- takes effect when `strict` is true
  override_by_operating_system = {
    ["apple"] = {
      icon = "",
      color = "#A2AAAD",
      cterm_color = "248",
      name = "Apple",
    },
  },
}


vim.api.nvim_set_hl(0, "Cursor", { bg = "NONE", fg = "NONE" }) -- Cursor highlight itself
vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })          -- Cursor line background
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "NONE" })        -- Cursor column background
vim.cmd([[set nocursorline]])
vim.cmd([[set nocursorcolumn]])

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
end)
lsp.setup()

require("notify").setup({
  background_colour = "#1e222a", -- Replace with a valid color if #000000 is not suitable
})

vim.g.molten_cell_delimiter = "# %%"
vim.keymap.set("v", "<leader>mr", "<Esc><Cmd>MoltenEvaluateVisual<CR>", { desc = "Molten eval visual selection" })
vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", { desc = "Molten eval line" })
vim.keymap.set("n", "<leader>mo", ":MoltenShowOutput<CR>", { desc = "Molten show output" })
vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", { desc = "Molten hide output" })
vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Molten delete cell" })
vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Molten init kernel" })
vim.keymap.set("n", "<leader>mI", ":MoltenDeinit<CR>", { desc = "Molten de-init kernel" })
vim.keymap.set("n", "<leader>mr", ":MoltenReevaluateCell<CR>", { desc = "Molten re-run cell" })
vim.keymap.set("n", "<leader>mD", ":MoltenInterrupt", { desc = "Molten interrupt runtime" })
vim.keymap.set("n", "<leader>mx", ":MoltenOpenInBrowser<CR>", { desc = "Molten open output in browser", silent = true })

-- Default options:









vim.cmd("colorscheme catppuccin")
