-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Configure the terminal to open with a custom border
-- Disable the keymap
vim.keymap.del("n", "<leader>ft")

-- Then set the keymap
vim.keymap.set("n", "<leader>ft", function()
  local Util = require("lazyvim.util")
  Util.terminal(nil, { border = "rounded" })
end, { desc = "Term with border" })
