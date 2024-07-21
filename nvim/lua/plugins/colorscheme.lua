return {
  "tjdevries/colorbuddy.nvim",
  {
    "0xstepit/flow.nvim",
    opts = function()
      require("flow").setup({
        transparent = false,
        fluo_color = "pink",
        mode = "normal",
      })
    end,
  },
  { "LazyVim/LazyVim", opts = {
    colorscheme = "flow",
  } },
}
