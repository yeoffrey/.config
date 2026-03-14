vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config") -- Load config first to set options before plugins
require("plugins") -- Then load plugins

-- Language servers
vim.lsp.enable({ "lua_ls" })
