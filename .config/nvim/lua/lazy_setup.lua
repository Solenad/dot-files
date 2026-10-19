require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^4",                -- Remove version tracking to elect for nightly AstroNvim
    import = "astronvim.plugins",
    opts = {                       -- AstroNvim options must be set here with the `import` key
      mapleader = " ",             -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",",        -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true,        -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = nil,           -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
      update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
    },
  },
  { import = "community" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "lua", -- It's good to have lua for your config
        "vim",
        "vimdoc",
        "r",
        "markdown"
        -- Add any other languages you use here
      },
    },
  },
  -- {
  --   "GCBallesteros/NotebookNavigator.nvim",
  --   keys = {
  --     { "]h",         function() require("notebook-navigator").move_cell "d" end },
  --     { "[h",         function() require("notebook-navigator").move_cell "u" end },
  --     { "<leader>mA", "<cmd>lua require('notebook-navigator').run_cell()<cr>",      desc = "Run current cell" },
  --     { "<leader>ma", "<cmd>lua require('notebook-navigator').run_and_move()<cr>",  desc = "Run current cell and move" },
  --     { "<leader>mb", "<cmd>lua require('notebook-navigator').run_all_cells()<cr>", desc = "Run all cells" },
  --   },
  --   dependencies = {
  --     "echasnovski/mini.comment",
  --     -- "hkupty/iron.nvim", -- repl provider
  --     -- "akinsho/toggleterm.nvim", -- alternative repl provider
  --     "benlubas/molten-nvim", -- use molten as provider
  --     "smoka7/hydra.nvim",
  --   },
  --   event = "VeryLazy",
  --   config = function()
  --     local nn = require "notebook-navigator"
  --     nn.setup({
  --       activate_hydra_keys = "<leader>h",
  --       repl_provider = "molten", -- set molten as the backend
  --     })
  --   end,
  --
  -- },
  -- {
  --   "GCBallesteros/jupytext.nvim",
  --   config = true,
  --   -- Depending on your nvim distro or config you may need to make the loading not lazy
  --   -- lazy=false,
  --   style = "hydrogen",
  --   output_extension = "auto", -- Default extension. Don't change unless you know what you are doing
  --   force_ft = nil,          -- Default filetype. Don't change unless you know what you are doing
  --   custom_language_formatting = {},
  -- },

  { "kyazdani42/nvim-tree.lua", event = "VimEnter",  dependencies = "nvim-tree/nvim-web-devicons" },
  { "catppuccin/nvim",          name = "catppuccin", lazy = false,                                priority = 1001 },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  },
  {
    "NStefan002/2048.nvim",
    cmd = "Play2048",
    config = true,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000, -- Set a high priority to load this colorscheme first
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     -- The following are optional:
  --     { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  --   },
  --   config = true
  -- },
  {
    "lervag/vimtex",
    ft = { "tex", "bib", "cls", "tikz" },
    init = function()
      vim.g.vimtex_view_method = 'none'
      vim.g.vimtex_view_general_viewer = 'start'
      vim.g.vimtex_view_general_options = ''
      vim.g.maplocalleader = ','
    end,
  },
  {
    'jmbuhr/otter.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },

  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- keep under 2.0.0 for now
    dependencies = {},
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "general"
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
    end,
  },
  -- {
  --   "3rd/image.nvim",
  --   dependencies = { "vhyrro/luarocks.nvim" },
  --   opts = {
  --     backend = "kitty", -- change if needed
  --     max_width = 100,
  --     max_height = 12,
  --     max_height_window_percentage = math.huge,
  --     max_width_window_percentage = math.huge,
  --     window_overlap_clear_enabled = true,
  --     window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  --   },
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
  { 'AmberLehmann/candyland.nvim', priority = 1000, },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup({
        show = true,                 -- Enable the scrollbar
        show_in_active_only = false, -- Show scrollbar in all windows
        max_lines = false,           -- Disable max lines limit
        handlers = {
          diagnostic = true,         -- Show diagnostics in scrollbar
          search = false,            -- Show search results in scrollbar
          gitsigns = true,           -- Show Git changes in scrollbar
        }
      })
    end
  },
  -- 2. Move markdown-preview OUTSIDE the opencode table
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },


  { import = "plugins" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  rocks = { enabled = false },
  install = { colorscheme = { "astrotheme", "habamax" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
