return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      local install = require("nvim-treesitter.install")
      local parser_install_dir = vim.fn.stdpath("data") .. "/parsers"
      vim.fn.mkdir(parser_install_dir, "p")

      install.parser_install_dir = parser_install_dir

      if not vim.tbl_contains(vim.opt.runtimepath:get(), parser_install_dir) then
        vim.opt.rtp:prepend(parser_install_dir)
      end

      opts = opts or {}
      opts.parser_install_dir = parser_install_dir
      opts.ensure_installed = opts.ensure_installed or {}
      return opts
    end,
  },
}
