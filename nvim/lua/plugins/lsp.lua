local nvim_lsp = require("lspconfig")

return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
      exclude = {}, -- filetypes for which you don't want to enable inlay hints
    },
    servers = {
      denols = {
        filetypes = { "typescript", "typescriptreact" },
        root_dir = function(...)
          return nvim_lsp.util.root_pattern("deno.jsonc", "deno.json")(...)
        end,
      },
      vtsls = {
        root_dir = nvim_lsp.util.root_pattern("package.json"),
      },
    },
  },
}
