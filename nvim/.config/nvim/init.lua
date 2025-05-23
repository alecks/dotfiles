-- leader is space
vim.g.mapleader = " "

-- enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- don't show mode at bottom -- we have our own statusline
vim.opt.showmode = false

-- sync with system clipboard
vim.opt.clipboard = "unnamedplus"

-- wrapped lines retain indentation
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- ignore case in searches
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- another column for diagnostics and git symbols
vim.opt.signcolumn = "yes"

-- decrease swap update time
vim.opt.updatetime = 250

-- how splits are opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show all substitutions live in another window
vim.opt.inccommand = "split"

-- highlight current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- min number of lines above/below cursor
-- as you navigate, vim will scroll before you reach the bottom
vim.opt.scrolloff = 10

-- tabs and spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 2

-- use block cursor
vim.opt.guicursor = "n-v-i-c:block"

-- disable formatting on save
vim.g.format_on_save = false
-- don't format zig files on save (zig likes to do its own thing)
vim.g.zig_fmt_autosave = false

-- KEYMAPS

-- highlight searches, clear on esc
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostics/errors
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- exit terminal with esc-esc
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- window navigation with C-hjkl
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- AUTOCOMMANDS

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.c",
  callback = function()
    local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
    if string.match(first_line, "#define CLAY_IMPLEMENTATION") then
      vim.cmd("TSDisable indent")
    end
  end,
})

-- LAZY.NVIM - initial setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS
require("lazy").setup({
  "tpope/vim-sleuth", -- detect indent style

  -- GITSIGNS - git status in gutter
  {
    "lewis6991/gitsigns.nvim",
    event = "UIEnter",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  -- LSPCONFIG
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      "saghen/blink.cmp",

      -- configures luals for neovim config
      { "folke/lazydev.nvim", opts = {} },
    },
    config = function()
      -- on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-on-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
          map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          map("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")

          map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        end,
      })

      local servers = {
        zls = {
          settings = {
            zls = {
              enable_build_on_save = true,
            },
          },
        },

        texlab = {
          settings = {
            texlab = {
              build = {
                onSave = true,
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-outdir=./build", "%f" },
              },
              chktex = {
                onOpenAndSave = true,
                onEdit = true,
              },
            },
          },
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      require("mason").setup()
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            -- extend capabilities table (overwriting), and add blink capabilities
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            server.capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities)

            require("lspconfig")[server_name].setup(server)
          end,
        },
        automatic_installation = false,
        ensure_installed = {},
      })
    end,
  },

  -- CONFORM - formatting
  {
    "stevearc/conform.nvim",
    event = "InsertEnter",
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        if not vim.g.format_on_save then
          return
        end
        -- disable lsp_fallback for certain filetypes
        local disable_filetypes = {}
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },

  -- COLORSCHEMES

  { "EdenEast/nightfox.nvim", priority = 1000 },
  { "miikanissi/modus-themes.nvim", priority = 1000 },
  -- END COLORSCHEMES

  -- BLINK - completion
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    -- dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-c>"] = { "select_and_accept" },
      },
      signature = { enabled = true },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },

  -- MINI
  {
    "echasnovski/mini.nvim",
    config = function()
      -- around/inside
      require("mini.ai").setup({ n_lines = 50 })
      -- surround
      require("mini.surround").setup()
      -- bracket pairs
      require("mini.pairs").setup()
      -- statusline
      require("mini.statusline").setup()

      -- glyph icon provider
      local miniicons = require("mini.icons")
      miniicons.setup()
      miniicons.tweak_lsp_kind()

      local minipick = require("mini.pick")
      local miniextra = require("mini.extra")
      minipick.setup()
      miniextra.setup()

      -- commonly used pickers, easier keybinds
      vim.keymap.set("n", "<leader><leader>", miniextra.pickers.git_files, { desc = "Search Git files" })
      vim.keymap.set("n", "<leader>/", minipick.builtin.grep_live, { desc = "Search buffers with live grep" })

      -- other pickers
      vim.keymap.set("n", "<leader>sf", minipick.builtin.files, { desc = "[S]earch [f]iles in CWD" })
      vim.keymap.set("n", "<leader>sd", miniextra.pickers.diagnostic, { desc = "[S]earch [d]iagnostics" })
      vim.keymap.set("n", "<leader>sb", minipick.builtin.buffers, { desc = "[S]earch [b]uffers" })

      -- lsp pickers
      vim.keymap.set("n", "<leader>ss", function()
        miniextra.pickers.lsp({ scope = "document_symbol" })
      end, { desc = "[S]earch document [s]ymbols" })

      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },

          -- mini.surround
          { mode = "n", keys = "s" },
        },

        clues = {
          -- Default MiniClue hints
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),

          { mode = "n", keys = "<leader>c", desc = "[C]ode" },
          { mode = "n", keys = "<leader>s", desc = "[S]earch" },
        },
      })
    end,
  },

  -- TREESITTER - highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    priority = 2000,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {},
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
})

vim.cmd("colorscheme carbonfox")
