-- GENERAL CONFIG
do
	vim.loader.enable()

	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	vim.g.have_nerd_font = false

	vim.opt.number = true
	vim.opt.showmode = false
	vim.opt.signcolumn = "yes"
	vim.opt.relativenumber = true
	vim.opt.termguicolors = true

	vim.opt.cursorline = false
	vim.opt.scrolloff = 20

	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4

	vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
	vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after cursor from system clipboard" })
	vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor from system clipboard" })

	vim.opt.breakindent = true
	vim.opt.ignorecase = true
	vim.opt.smartcase = true
	vim.opt.inccommand = "split"

	vim.opt.hlsearch = true
	vim.opt.incsearch = true

	vim.opt.undofile = true
	vim.opt.updatetime = 250
	vim.opt.timeoutlen = 300

	vim.opt.splitright = true
	vim.opt.splitbelow = true

	vim.opt.confirm = true
end

-- VIM.PACK
do
	local function run_build(name, cmd, cwd)
		local result = vim.system(cmd, { cwd = cwd }):wait()
		if result.code ~= 0 then
			local stderr = result.stderr or ""
			local stdout = result.stdout or ""
			local output = stderr ~= "" and stderr or stdout
			if output == "" then
				output = "No output from build command."
			end
			vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
		end
	end

	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			local name = ev.data.spec.name
			local kind = ev.data.kind
			if kind ~= "install" and kind ~= "update" then
				return
			end

			if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
				run_build(name, { "make" }, ev.data.path)
				return
			end

			if name == "nvim-treesitter" then
				if not ev.data.active then
					vim.cmd.packadd("nvim-treesitter")
				end
				vim.cmd("TSUpdate")
				return
			end
		end,
	})
end

local function gh(repo)
	return "https://github.com/" .. repo
end

-- PLUGINS
do
	vim.pack.add({ gh("nvim-mini/mini.nvim") })

	require("mini.ai").setup({})
	require("mini.pairs").setup({})
	require("mini.surround").setup({})
	require("mini.splitjoin").setup({})
	require("mini.operators").setup({ replace = { prefix = "gR" } })

	require("mini.pick").setup({})
	require("mini.extra").setup({})
	require("mini.files").setup({})
	require("mini.bracketed").setup({})
	require("mini.bufremove").setup({})

	require("mini.completion").setup({})

	require("mini.diff").setup({})
	require("mini.icons").setup({})
	-- require("mini.statuscolumn").setup({})
	require("mini.notify").setup({})
	vim.notify = MiniNotify.make_notify()
	-- require("mini.indentscope").setup({
	-- 	draw = {
	-- 		animation = require("mini.indentscope").gen_animation.none(),
	-- 	},
	-- })

	require("mini.sessions").setup({
		autoread = true,
		autowrite = true,
	})
	require("mini.starter").setup()

	require("mini.tabline").setup({})
	vim.opt.showtabline = 2

	local statusline = require("mini.statusline")
	statusline.setup({
		content = {
			active = function()
				local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
				local git = statusline.section_git({ trunc_width = 40 })
				local diff = statusline.section_diff({ trunc_width = 75 })
				local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
				local lsp = statusline.section_lsp({ trunc_width = 75 })
				local filename = statusline.section_filename({ trunc_width = 140 })
				local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
				local location = statusline.section_location({ trunc_width = 75 })
				local search = statusline.section_searchcount({ trunc_width = 75 })

				return statusline.combine_groups({
					{ hl = "StatusLine", strings = { mode } },
					{ hl = "StatusLine", strings = { git, diff, diagnostics, lsp } },
					"%<",
					{ hl = "StatusLine", strings = { filename } },
					"%=",
					{ hl = "StatusLine", strings = { fileinfo } },
					{ hl = "StatusLine", strings = { search, location } },
				})
			end,
		},
	})

	local function update_tabline()
		local buffers = vim.fn.getbufinfo({ buflisted = 1 })
		vim.opt.showtabline = #buffers > 1 and 2 or 0
	end

	vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "BufEnter" }, {
		callback = function()
			vim.schedule(update_tabline)
		end,
	})

	update_tabline()

	-- COLOURSCHEME
	vim.pack.add({ gh("nuvic/flexoki-nvim") })
	vim.cmd.colorscheme("flexoki-moon")

	vim.pack.add({ gh("zbirenbaum/copilot.lua") })
	require("copilot").setup({
		suggestion = {
			enabled = true,
			auto_trigger = true,
			hide_during_completion = false,
		},
	})
end

-- KEYBINDS
do
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

	vim.diagnostic.config({
		update_in_insert = false,
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = { min = vim.diagnostic.severity.WARN } },
		virtual_text = true, -- text shows at end of line
		virtual_lines = false, -- text shows underneath the line, using virtual lines
		jump = {
			on_jump = function(_, bufnr)
				vim.diagnostic.open_float({
					bufnr = bufnr,
					scope = "cursor",
					focus = false,
				})
			end,
		},
	})

	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

	vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
	vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
	vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
	vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

	vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
	vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking text",
		group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
		callback = function()
			vim.hl.on_yank()
		end,
	})

	vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Find files" })
	vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Live grep" })
	vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "Find buffers" })

	vim.keymap.set("n", "<leader>q", MiniBufremove.delete, { desc = "Close buffer (without closing splits)" })

	vim.keymap.set("n", "<leader>fs", function()
		MiniExtra.pickers.lsp({ scope = "workspace_symbol" })
	end, { desc = "Find workspace symbols" })

	vim.keymap.set("n", "<leader>fd", MiniExtra.pickers.diagnostic, { desc = "Find diagnostics" })

	vim.keymap.set("n", "<leader>e", MiniFiles.open, { desc = "File explorer" })
	vim.keymap.set("n", "<leader>gd", MiniDiff.toggle_overlay, { desc = "Toggle Git diff" })
end

-- LSP
do
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("<leader>r", vim.lsp.buf.rename, "LSP rename")
			map("<leader>a", vim.lsp.buf.code_action, "LSP code action")
			map("gD", vim.lsp.buf.declaration, "Goto declaration")
			map("gd", vim.lsp.buf.definition, "Goto definition")
			map("gr", vim.lsp.buf.references, "Find references")
		end,
	})

	---@type table<string, vim.lsp.Config>
	local servers = {
		lua_ls = {
			on_init = function(client)
				client.server_capabilities.documentFormattingProvider = false

				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
				client.config.settings.Lua = vim.tbl_deep_extend("force", current_settings.Lua, {
					runtime = {
						version = "LuaJIT",
						path = { "lua/?.lua", "lua/?/init.lua" },
					},
					workspace = {
						checkThirdParty = false,
						library = vim.tbl_filter(function(d)
							return not d:match(vim.fn.stdpath("config") .. "/?a?f?t?e?r?")
						end, vim.api.nvim_get_runtime_file("", true)),
					},
				})
			end,
			---@type lspconfig.settings.lua_ls
			settings = {
				Lua = {
					format = { enable = false },
				},
			},
		},
	}

	vim.pack.add({
		gh("neovim/nvim-lspconfig"),
		gh("mason-org/mason.nvim"),
		gh("mason-org/mason-lspconfig.nvim"),
	})

	for name, server in pairs(servers) do
		vim.lsp.config(name, server)
		vim.lsp.enable(name)
	end

	require("mason").setup({})
	require("mason-lspconfig").setup({
		automatic_enable = true,
	})
end

-- FORMATTING
do
	vim.pack.add({ gh("stevearc/conform.nvim") })
	require("conform").setup({
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang_format" },
		},
	})

	vim.keymap.set({ "n", "v" }, "<leader>f", function()
		require("conform").format({ async = true })
	end, { desc = "Format buffer" })
end

-- TREESITTER
do
	vim.pack.add({ { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" } })
	local parsers =
		{ "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" }
	require("nvim-treesitter").install(parsers)

	---@param buf integer
	---@param language string
	local function treesitter_try_attach(buf, language)
		if not vim.api.nvim_buf_is_valid(buf) then
			return
		end
		if not vim.treesitter.language.add(language) then
			return
		end

		vim.treesitter.start(buf, language)

		local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil
		if has_indent_query then
			vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end

	local available_parsers = require("nvim-treesitter").get_available()
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local buf, filetype = args.buf, args.match

			local language = vim.treesitter.language.get_lang(filetype)
			if not language then
				return
			end

			local installed_parsers = require("nvim-treesitter").get_installed("parsers")

			if vim.tbl_contains(installed_parsers, language) then
				treesitter_try_attach(buf, language)
			elseif vim.tbl_contains(available_parsers, language) then
				require("nvim-treesitter").install(language):await(function()
					treesitter_try_attach(buf, language)
				end)
			else
				treesitter_try_attach(buf, language)
			end
		end,
	})
end
