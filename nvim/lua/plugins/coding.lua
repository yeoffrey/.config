return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "biome",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ts = { "biome" },
        json = { "biome" },
      },
      formatters = {
        biome = {
          condition = function(ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ts = { "biome", "eslint" },
      },
      linters = {
        biome = {
          condition = function(ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
