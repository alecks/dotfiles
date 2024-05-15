return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          floats = "dark",
          sidebars = "dark",
        },
      })
    end,
  },
  { "LazyVim/LazyVim", opts = {
    colorscheme = "tokyonight",
  } },
}
