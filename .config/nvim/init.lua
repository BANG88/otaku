if vim.loader then
  vim.loader.enable()
end

require("config.lazy")

require("lualine").setup({
  options = { theme = "auto" },
})

