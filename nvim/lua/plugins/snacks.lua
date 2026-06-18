local ascii = require("snippets.ascii")

local function random_header()
  local keys = {}
  for k in pairs(ascii) do
    table.insert(keys, k)
  end
  math.randomseed(os.time())
  return table.concat(ascii[keys[math.random(#keys)]], "\n")
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = random_header(),
      },
      sections = {
        {
          section = "header",
          padding = 4,
        },
        { section = "keys", padding = 2 },
        { section = "startup" },
      },
    },
    picker = {
      sources = {
        files = { hidden = true },
        grep = { hidden = true },
        explorer = { hidden = true },
      },
    },
  },
  init = function()
    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#ffffff" })
  end,
}
