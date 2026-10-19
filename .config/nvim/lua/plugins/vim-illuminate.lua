return {
  "RRethy/vim-illuminate",
  config = function(plugin, opts)
    require("astronvim.plugins.configs.vim-illuminate")(plugin, opts)

    local ts_provider = require("illuminate.providers.treesitter")
    local original_get_references = ts_provider.get_references

    ts_provider.get_references = function(...)
      local ok, result = pcall(original_get_references, ...)
      if ok then
        return result
      end
    end
  end,
}
