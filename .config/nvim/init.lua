if vim.loader then
  vim.loader.enable()
end

require("config.lazy")

require("lualine").setup({
  options = { theme = "auto" },
})

require("mini.indentscope").setup()

--  require("ibl").setup({})
