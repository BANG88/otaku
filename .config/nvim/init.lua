if vim.loader then
  vim.loader.enable()
end

require("config.lazy")

require("avante_lib").load()

require("lualine").setup({
  options = { theme = "auto" },
})
