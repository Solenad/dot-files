
local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("Unable to find nvim-tree")
    return
end

nvim_tree.setup({
    sort_by = "case_sensitive",
    -- Show git status
    git = {
        enable = true,
    },
    -- File filtering
    filters = {
        dotfiles = true, -- Filter dotfiles
        custom = { "node_modules" }, -- Other filtered directories
    },
    view = {
        -- File explorer display position, left: left, right: right
        side = "left",
        -- Display line numbers
        number = false,
        relativenumber = false,
        signcolumn = "yes", -- Display icons
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
})

