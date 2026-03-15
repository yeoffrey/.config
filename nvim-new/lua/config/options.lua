local g = vim.g
g.mapleader = " "
g.maplocalleader = " "

local o = vim.opt
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.cursorline = true -- Enable highlighting of the current line
o.expandtab = true -- Use spaces instead of tabso.ignorecase = true -- When searching, don't care about casing
o.linebreak = true -- Break the lines
o.number = true -- Add line numbers
o.relativenumber = true -- Add relative line numbers
o.ruler = false -- Disable the default ruler
o.scrolloff = 10
o.shiftwidth = 2
o.sidescrolloff = 10
o.smartcase = true -- Don't ignore case with capitals
o.smartindent = true -- Insert indents automatically
o.smoothscroll = true
o.spelllang = { "en" }
o.termguicolors = true -- Enable 24-bit colors

local d = vim.diagnostic
d.config({ virtual_text = true })
