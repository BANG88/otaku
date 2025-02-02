if vim.loader then
  vim.loader.enable()
end

require("config.lazy")

require("lualine").setup({
  options = { theme = "auto" },
})

require("mini.indentscope").setup()

require("mini.comment").setup()

require("mini.completion").setup()

require("toggleterm").setup({})

require("mini.move").setup()

require("nvim-highlight-colors").setup({})

require("lspconfig").buf_ls.setup({})

require("lspconfig").biome.setup({})
