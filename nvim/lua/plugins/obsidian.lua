return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Vault",
        path = "~/Documents/vault",
      },
    },
    templates = {
      subdir = "templates",
    },
    disable_frontmatter = true,
  },
}
