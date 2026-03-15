vim.keymap.set("n", "<Esc>", function()
  if vim.v.hlsearch == 1 then
    return "<cmd>noh<cr>"
  end
  return "<Esc>"
end, { expr = true, noremap = true })
