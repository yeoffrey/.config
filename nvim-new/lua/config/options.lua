vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true -- Enable 24-bit colors
vim.o.number = true -- Add line numbers
vim.o.relativenumber = true -- Add relative line numbers
vim.o.linebreak = true -- Break the lines
vim.o.cursorline = true -- Highlight the line with the cursor
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.ignorecase = true -- When searching, don't care about casing
vim.o.smartcase = true -- Above, but smarter :brain:

vim.diagnostic.config({ virtual_text = true})
