vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.spell = true

-- Sync clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

local ignore_filetypes_list = {
	"venv",
	"__pycache__",
	"%.xlsx",
	"%.jpg",
	"%.png",
	"%.webp",
	"%.pdf",
	"%.odt",
	"%.ico",
	"%.aux",
	"%.bbl",
	"%.blg",
	"%.out",
	"%.toc",
	"%.synctex.gz",
	"%.fls",
	"%.txss2",
	"%.fdb_latexmk",
}

-- Editor Options
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Set keyboard shortcuts for vimrc and snippets
vim.keymap.set("n", "<Leader>ev", "<Cmd>vsplit $MYVIMRC<Cr>")
vim.keymap.set("n", "<Leader>es", "<Cmd>vsplit ~/.config/nvim/snippets/all.lua<Cr>")
-- Also add Kitty and Sioyek
vim.keymap.set("n", "<Leader>ek", "<Cmd>vsplit ~/.config/kitty/personal_config.conf<Cr>")
vim.keymap.set("n", "<Leader>ep", "<Cmd>vsplit ~/.config/sioyek/prefs_user.config<Cr>")
vim.keymap.set("n", "<Leader>eP", "<Cmd>vsplit ~/.config/sioyek/keys_user.config<Cr>")

-- Navigate through soft wrapped lines
vim.keymap.set({ "n", "v" }, "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, noremap = true })
vim.keymap.set({ "n", "v" }, "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, noremap = true })
vim.keymap.set("i", "<Up>", "<C-o>gk")
vim.keymap.set("i", "<Down>", "<C-o>gj")

-- Basic Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<S-CR>", "^[O2R")

-- Basic Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Pre-Plugin Globals
-- VimTeX global variables must be defined before the plugin is loaded
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_quickfix_mode = 2
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_indent_delims = {
	open = { "{" },
	close = { "}" },
	close_indented = 0,
	include_modified_math = 0,
}

---
--- [[ Native Neovim 0.12 Plugin Management ]]
---
local github = "https://github.com/"
vim.pack.add({
	github .. "tpope/vim-sleuth",
	github .. "lervag/vimtex",
	github .. "neovim/nvim-lspconfig",
	github .. "tpope/vim-fugitive",
	github .. "ms-jpq/chadtree",
	github .. "saecki/crates.nvim",
	github .. "Vigemus/iron.nvim",
	github .. "lewis6991/gitsigns.nvim",
	github .. "folke/which-key.nvim",
	github .. "nvim-telescope/telescope.nvim",
	github .. "nvim-lua/plenary.nvim",
	github .. "nvim-telescope/telescope-fzf-native.nvim",
	github .. "nvim-telescope/telescope-ui-select.nvim",
	github .. "nvim-tree/nvim-web-devicons",
	github .. "folke/lazydev.nvim",
	github .. "Bilal2453/luvit-meta",
	github .. "williamboman/mason.nvim",
	github .. "williamboman/mason-lspconfig.nvim",
	github .. "WhoIsSethDaniel/mason-tool-installer.nvim",
	github .. "j-hui/fidget.nvim",
	github .. "hrsh7th/nvim-cmp",
	github .. "hrsh7th/cmp-nvim-lsp",
	github .. "hrsh7th/cmp-path",
	github .. "saadparwaiz1/cmp_luasnip",
	github .. "stevearc/conform.nvim",
	github .. "L3MON4D3/LuaSnip",
	github .. "catppuccin/nvim",
	github .. "folke/todo-comments.nvim",
	github .. "echasnovski/mini.nvim",
	github .. "nvim-treesitter/nvim-treesitter",
})

---
--- [[ Plugin Configurations ]]
---

-- Native Undotree (Neovim 0.12+)
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", "<cmd>Undotree<cr>")

-- VimTeX Keys
vim.keymap.set("n", "<C-s>", "<plug>(vimtex-view)", { desc = "VimTeX SyncTeX View" })

-- CHADTree
vim.g.chadtree_settings = { ["view.width"] = 27 }
vim.keymap.set("n", "<leader>v", "<cmd>CHADopen<CR>")

-- Crates (Lazy loaded via native autocommand)
vim.api.nvim_create_autocmd("BufRead", {
	pattern = "Cargo.toml",
	callback = function()
		require("crates").setup()
	end,
})

-- Iron.nvim
local iron = require("iron.core")
iron.setup({
	config = {
		scratch_repl = true,
		repl_definition = {
			sh = { command = { "zsh" } },
			python = {
				command = { "python3" },
				format = require("iron.fts.common").bracketed_paste_python,
			},
		},
		repl_open_cmd = require("iron.view").split.vertical.botright(0.3),
	},
	keymaps = {
		send_motion = "<space>sc",
		visual_send = "<space>sc",
		send_file = "<space>sF",
		send_line = "<space>sl",
		send_paragraph = "<space>sp",
		send_until_cursor = "<space>su",
		send_mark = "<space>sm",
		mark_motion = "<space>mc",
		mark_visual = "<space>mc",
		remove_mark = "<space>md",
		cr = "<space>s<cr>",
		interrupt = "<space>s<space>",
		exit = "<space>sq",
		clear = "<space>cl",
	},
	highlight = { italic = true },
	ignore_blank_lines = true,
})
vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")

-- Gitsigns
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- Which-Key
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

-- Telescope
require("telescope").setup({
	defaults = { file_ignore_patterns = ignore_filetypes_list },
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- Lazydev
require("lazydev").setup({
	library = {
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})

-- Fidget & Mason
require("fidget").setup({})
require("mason").setup()

local servers = {
	texlab = {
		settings = {
			texlab = {
				-- Delay diagnostics by 3s
				-- to prevent diagnostics from happening
				-- during compilation
				-- (this caused a memory leak)
				diagnosticsDelay = 3000,
			},
		},
	},
	julials = {},
	pylsp = {},
	rust_analyzer = {},
	taplo = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
			},
		},
	},
}

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, { "stylua", "codelldb" })
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

for server_name, config in pairs(servers) do
	local server_caps = vim.tbl_deep_extend("force", {}, capabilities)

	-- Prevent TexLab from watching files (causes memory leak)
	if server_name == "texlab" then
		if server_caps.workspace then
			server_caps.workspace.didChangeWatchedFiles = nil
		end
	end

	config.capabilities = vim.tbl_deep_extend("force", server_caps, config.capabilities or {})
	vim.lsp.config(server_name, config)
end
require("mason-lspconfig").setup()

-- LSP Attach Autocommand
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = false }),
				buffer = event.buf,
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

-- Intercept and filter out transient TexLab reference/label spam
local default_diagnostic_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
	if result.diagnostics then
		local filtered_diagnostics = {}
		for _, diag in ipairs(result.diagnostics) do
			-- Drop "Undefined reference" (codes 10/11) and "Unused label" (code 9)
			local is_tex_ref_spam = diag.source == "texlab" and (diag.code == 11 or diag.code == 10 or diag.code == 9)

			if not is_tex_ref_spam then
				table.insert(filtered_diagnostics, diag)
			end
		end
		result.diagnostics = filtered_diagnostics
	end

	-- Pass the clean diagnostics to Neovim's default renderer
	default_diagnostic_handler(err, result, ctx, config)
end

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true }
		return {
			timeout_ms = 500,
			lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
	},
})
vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[F]ormat buffer" })

-- Autocompletion
local cmp = require("cmp")
local luasnip = require("luasnip")

-- LuaSnip Setup
luasnip.config.setup({})
luasnip.config.set_config({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = { completeopt = "menu,menuone,noinsert" },
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<CR>"] = cmp.mapping.select_next_item(),
		["<A-CR>"] = cmp.mapping.select_prev_item(),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-l>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "lazydev", group_index = 0 },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
})

-- Catppuccin
local catppuccin = require("catppuccin")
catppuccin.setup({
	flavour = "mocha",
	transparent_background = true,
})
catppuccin.load()

-- Todo Comments
require("todo-comments").setup({ signs = false })

-- Mini
require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
	return "%2l:%-2v"
end

-- Treesitter
require("nvim-treesitter.config").setup({
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
		"rust",
		"toml",
	},
	auto_install = true,
	ignore_install = { "latex" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "ruby" },
		disable = { "latex" },
	},
	-- Vimtex has its own lsp
	indent = { enable = true, disable = { "ruby", "latex" } },
})
