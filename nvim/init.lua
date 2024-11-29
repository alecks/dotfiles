-- leader is space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.use_nerd_font = true

-- enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false

-- sync with system clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- ignore case in searches
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

-- decrease swap update time
vim.opt.updatetime = 250

-- decrease delay after inputs for which-key, etc
vim.opt.timeoutlen = 300

-- how splits are opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- live substitutions
vim.opt.inccommand = "split"

-- highlight current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- min number of lines above/below cursor
vim.opt.scrolloff = 10

-- tabs and spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 2

-- use block cursor
vim.opt.guicursor = "n-v-i-c:block"

-- for obsidian.nvim, hidden characters not displayed
vim.opt.conceallevel = 2

-- KEYMAPS

-- highlight searches, clear on esc
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostics/errors
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- exit terminal easier
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

-- LAZY.NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
  "numToStr/Comment.nvim", -- gc in visual mode to toggle comments

  -- git status in gutter
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

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
      require("which-key").add({
        { "<leader>c", group = "[C]ode" },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    event = "UIEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- for build only
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.use_nerd_font },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- enable telescope extensions
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require("telescope.builtin")
      local function find_git_or_cwd()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        if vim.v.shell_error == 0 then
          builtin.git_files({ show_untracked = true })
        else
          builtin.find_files()
        end
      end
      vim.keymap.set("n", "<leader><leader>", find_git_or_cwd, { desc = "[S]earch Git Files" })

      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles in CWD" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })

      -- override theme for fuzzy find
      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })
    end,
  },

  -- lsp config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- lsp status updates
      { "j-hui/fidget.nvim", opts = {} },
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

          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          -- fuzzy find for symbols
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
          -- same for workspace
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

          map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

          map("K", vim.lsp.buf.hover, "Hover Documentation")

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map("<leader>th", function()
              ---@diagnostic disable-next-line: missing-parameter
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- define capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- See `:help lspconfig-all` for a list of all the pre-configured LSPs

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      }

      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      -- other things for mason to install
      vim.list_extend(ensure_installed, {
        "stylua",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- only overrides capabilities above
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  -- auto formatting
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
        -- disable lsp_fallback for certain filetypes
        local disable_filetypes = {}
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
        css = { "prettierd" },
      },
    },
  },

  -- autocomplete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- snippets
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",

      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- scroll doc window
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- confirm a completion
          ["<C-CR>"] = cmp.mapping.confirm({ select = true }),

          -- navigate to the next placeholder field
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          -- and back
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        },
      })
    end,
  },

  -- start colorschemes
  {
    "projekt0n/caret.nvim",
    lazy = true,
    init = function()
      -- vim.cmd("colorscheme caret")
    end,
  },

  {
    "tjdevries/colorbuddy.nvim",
    lazy = true,
    priority = 1000,
    init = function()
      -- vim.cmd("colorscheme gruvbuddy")
    end,
  },

  {
    "thallada/farout.nvim",
    lazy = true,
    init = function()
      vim.cmd("colorscheme farout")
    end,
  },
  -- end colorschemes

  -- fancy todo comments, without gutter signs
  {
    "folke/todo-comments.nvim",
    event = "UIEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  -- lots of wee things
  {
    "echasnovski/mini.nvim",
    config = function()
      -- around/inside
      require("mini.ai").setup({ n_lines = 500 })

      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- statusline
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.use_nerd_font })
    end,
  },

  -- banging highlighting etc
  {
    "nvim-treesitter/nvim-treesitter",
    priority = 2000,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      ignore_install = { "norg" },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- bracket pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({})
      -- add ) after selecting func
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- import lua/plugins dir
  { import = "plugins" },
}, {
  ui = {
    icons = vim.g.use_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
