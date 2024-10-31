return {
  "nvim-neotest/neotest",
  dependencies = { "nvim-neotest/neotest-jest" },
  opts = {
    -- Can be a list of adapters like what neotest expects,
    -- or a list of adapter names,
    -- or a table of adapter names, mapped to adapter configs.
    -- The adapter will then be automatically loaded with the config.
    adapters = { ["neotest-jest"] = {} },
  },
}
