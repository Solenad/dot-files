local function comment_last_output()
  -- Find last output section (you may need to improve this logic to match molten's output region)
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  -- Find region of output (e.g., lines after "Out[...]:")
  local out_start = nil
  for i = #lines, 1, -1 do
    if lines[i]:match("^Out%[") then
      out_start = i
      break
    end
  end
  if out_start then
    -- Comment all output lines below this up to next code (or blank)
    for i = out_start + 1, #lines do
      if lines[i]:match("^%s*$") then break end -- stop at blank
      lines[i] = "# " .. lines[i]
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  end
end

-- You can map this function to a key:
vim.keymap.set('n', '<leader>mo', comment_last_output, { desc = "Molten: Comment output" })
