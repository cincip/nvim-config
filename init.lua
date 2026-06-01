require('vim._core.ui2').enable({
	enable = true,
})
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.breakindent = true
vim.o.smoothscroll = true
vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.cursorline = true
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.cmd("set completeopt+=noselect")
vim.o.autocomplete = true
vim.o.inccommand = "split"
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.undofile = true
vim.g.netrw_liststyle = 1
-- vim.opt.iskeyword:remove("_")

local function escape(str)
	local escape_chars = [[;,."|\]]
	return vim.fn.escape(str, escape_chars)
end

local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
local en       = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru       = [[ёйцукенгшщзхъфывапролджэячсмить]]
vim.opt.langmap = vim.fn.join({
	escape(ru_shift) .. ";" .. escape(en_shift),
	escape(ru) .. ";" .. escape(en),
}, ",")


local sev = vim.diagnostic.severity
vim.diagnostic.config({
	severity_sort = true,
	signs = {
		text = {
			[sev.ERROR] = "E",
			[sev.WARN]  = "W",
			[sev.INFO]  = "I",
			[sev.HINT]  = "H",
		},
	},
	virtual_text = true,
	underline    = true,
	update_in_insert = false,
	float = { border = "rounded" },
})


local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v", "x" }, "<leader>y",  '"+y',  opts)
vim.keymap.set({ "n", "v", "x" }, "<leader>yy", '"+yy', opts)
vim.keymap.set({ "n", "v", "x" }, "<leader>P",  '"+P',  opts)
vim.keymap.set({ "n", "v", "x" }, "<leader>p",  '"+p',  opts)
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    vim.cmd("Undotree")
end, opts)

vim.keymap.set({ "n", "v", "x" }, "<M-l>", "zl",      opts)
vim.keymap.set({ "n", "v", "x" }, "<M-h>", "zh",      opts)
vim.keymap.set({ "n", "v", "x" }, "<M-L>", "zL",      opts)
vim.keymap.set({ "n", "v", "x" }, "<M-H>", "zH",      opts)
vim.keymap.set({ "n", "v", "x" }, "<M-j>", "<C-e>",   opts)
vim.keymap.set({ "n", "v", "x" }, "<M-k>", "<C-y>",   opts)
vim.keymap.set({ "n", "v", "x" }, "<M-q>", "<C-S-6>", opts)

local win = "<M-w>"
vim.keymap.set("n", win .. "h", "<C-w>h")
vim.keymap.set("n", win .. "j", "<C-w>j")
vim.keymap.set("n", win .. "k", "<C-w>k")
vim.keymap.set("n", win .. "l", "<C-w>l")
vim.keymap.set("n", win .. "s", "<C-w>s")
vim.keymap.set("n", win .. "v", "<C-w>v")
vim.keymap.set("n", win .. "c", "<C-w>c")
vim.keymap.set("n", win .. "o", "<C-w>o")
vim.keymap.set("n", win .. "H", "<C-w>H")
vim.keymap.set("n", win .. "J", "<C-w>J")
vim.keymap.set("n", win .. "K", "<C-w>K")
vim.keymap.set("n", win .. "L", "<C-w>L")
vim.keymap.set("n", "<M-Up>",    "<cmd>resize +3<cr>")
vim.keymap.set("n", "<M-Down>",  "<cmd>resize -3<cr>")
vim.keymap.set("n", "<M-Left>",  "<cmd>vertical resize -5<cr>")
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +5<cr>")

vim.keymap.set({ "n", "v", "x" }, "<leader>x",   ":e ~/buffer.md<CR>",           opts)
vim.keymap.set({ "n", "v", "x" }, "<leader>c",   ":e ~/Notes/scratchpad.md<CR>", opts)
vim.keymap.set({ "n", "v", "x" }, "<C-c>at",     ":e ~/org/todo.org<CR>",        opts)

vim.keymap.set({ "i", "c" }, "<C-d>", "<Delete>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-h>", "<Left>",   { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-l>", "<Right>",  { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-j>", "<Down>",      { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-k>", "<Up>",        { noremap = true })
vim.keymap.set({ "i", "c" }, "<D-Space>", "",        { noremap = true })
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("i", "<C-S-v>", "<C-r>+", { noremap = true, silent = true })

vim.keymap.set("n", "<leader><CR>", ":noh<CR>",     opts)
vim.keymap.set("n", "<leader>q",    "@q",            opts)
vim.keymap.set("n", "<leader>o",    ":Open %<CR>",   { noremap = true })
vim.keymap.set("n", "<leader>e",    ":Explore<CR>",  opts)
vim.keymap.set("n", "<leader>v",    ":vsplit<CR>",   { noremap = true })
vim.keymap.set("n", "<leader>h",    ":split<CR>",    { noremap = true })
vim.keymap.set("n", "<M-w>",        "<C-w><C-w>",    { noremap = true })

vim.keymap.set("n", "<leader>lf", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if not clients or vim.tbl_isempty(clients) then
		print("No LSP attached to buffer")
		return
	end
	vim.lsp.buf.format({ async = true })
end, opts)

vim.keymap.set("n", "<M-c>", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local s, e = line:find("[%w_]+", col + 1)
	if not s then return end
	local word = line:sub(s, e)
	local cap  = word:sub(1, 1):upper() .. word:sub(2):lower()
	vim.api.nvim_set_current_line(line:sub(1, s - 1) .. cap .. line:sub(e + 1))
	vim.api.nvim_win_set_cursor(0, { row, e })
end, { noremap = true, desc = "Capitalize word under cursor" })

for i = 1, 9 do
	vim.keymap.set("n", "<Leader>" .. i, i .. "gt", opts)
end
vim.keymap.set("n", "<Leader>t-", ":-tabm<CR>",   opts)
vim.keymap.set("n", "<Leader>t=", ":+tabm<CR>",   opts)
vim.keymap.set("n", "<Leader>tn", ':tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/', opts)
vim.keymap.set("n", "<Leader>t0", ":tabo<CR>",    opts)
vim.keymap.set("n", "<Leader>tc", ":tabclose<CR>", opts)
vim.keymap.set("n", "<Leader>te", ":tab terminal<CR>", opts)
vim.keymap.set("n", "<leader>ts", "<cmd>setlocal spell!<CR>", { desc = "Toggle Spellcheck" })
vim.keymap.set("n", "<C-l>",   "gt",       opts)
vim.keymap.set("n", "<C-h>",   "gT",       opts)
vim.keymap.set("n", "<C-S-l>", ":bp<CR>",  opts)
vim.keymap.set("n", "<C-S-h>", ":bn<CR>",  opts)
vim.keymap.set("t", "<C-Space>", [[<C-\><C-n>]], { noremap = true })

vim.keymap.set("n", "<leader>ts", function()
	if vim.o.laststatus == 0 then
		vim.o.laststatus = 1; vim.o.showtabline = 1; vim.o.cmdheight = 1
	else
		vim.o.laststatus = 0; vim.o.showtabline = 0; vim.o.cmdheight = 0
	end
end, { desc = "Toggle statusline" })

vim.keymap.set("n", "<leader>rk", function()
	vim.cmd("!pkill -f 'typst watch'")
	vim.cmd("!pkill zathura")
	print("Killed running processes (typst watch, zathura)")
end, { desc = "Kill running processes", noremap = true, silent = true })

vim.keymap.set("n", "<leader>m", ":make<CR>", { desc = "Run make", noremap = true, silent = true })


vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/nvim-mini/mini.ai" },
	{ src = "https://github.com/brenton-leighton/multiple-cursors.nvim" },
	{ src = "https://github.com/supermaven-inc/supermaven-nvim" },
	{ src = "https://github.com/WTFox/jellybeans.nvim" },
	{ src = "https://github.com/thembones79/mine-pine" },
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/ramojus/mellifluous.nvim" },
	{ src = "https://github.com/ThunderBoltCODMYT/gruber-darker.vim" },
	{ src = "https://github.com/thesimonho/kanagawa-paper.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/Shatur/neovim-ayu" },
	{ src = "https://github.com/tanvirtin/monokai.nvim" },
	{ src = "https://github.com/xero/miasma.nvim" },
	{ src = "https://github.com/nvim-orgmode/orgmode" },
	{ src = "https://github.com/chipsenkbeil/org-roam.nvim" },
	{ src = "https://github.com/oonamo/ef-themes.nvim" },
})


local ts_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if ts_ok then
	ts_configs.setup({
		ensure_installed = {
			"typescript", "javascript", "zig", "c", "python",
			"cpp", "kotlin", "typst", "dart", "go", "rust", "svelte",
		},
		highlight = { enable = true },
	})
end


local function safe_setup(mod, cfg)
	local ok, plugin = pcall(require, mod)
	if ok then plugin.setup(cfg or {}) end
end

safe_setup("mini.pick")
safe_setup("mini.ai")
safe_setup("multiple-cursors")
-- safe_setup("nvim-autopairs")

local orgmode_ok, orgmode = pcall(require, "orgmode")
if orgmode_ok then
	orgmode.setup({
		org_agenda_files       = { "~/org-nvim/**/*" },
		org_default_notes_file = "~/org-nvim/refile.org",
	})
	vim.lsp.enable("org")
end

local roam_ok, org_roam = pcall(require, "org-roam")
if roam_ok then
	org_roam.setup({
		directory = "~/org-nvim",
		bindings = {
			prefix                   = "<leader>n",
			add_alias                = "<leader>naa",
			remove_alias             = "<leader>nar",
			add_origin               = "<leader>noa",
			remove_origin            = "<leader>nor",
			capture                  = "<leader>nc",
			complete_at_point        = "<leader>n.",
			find_node                = "<leader>nf",
			goto_next_node           = "<leader>nn",
			goto_prev_node           = "<leader>np",
			insert_node              = "<leader>ni",
			insert_node_immediate    = "<leader>nm",
			quickfix_backlinks       = "<leader>nq",
			toggle_roam_buffer       = "<leader>nl",
			toggle_roam_buffer_fixed = "<leader>nb",
		},
		extensions = {
			dailies = { directory = "daily" },
		},
	})
end

-- safe_setup("supermaven-nvim", {
-- 	keymaps = {
-- 		accept_suggestion = "<Tab>",
-- 		clear_suggestion  = "<C-]>",
-- 	},
-- 	color = { suggestion_color = "#ffffff", cterm = 244 },
-- 	log_level = "info",
-- 	disable_inline_completion = false,
-- 	disable_keymaps = false,
-- 	condition = function() return false end,
-- })



vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  pattern = "*.typ",
  command = "silent! write",
})


vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local bufnr  = ev.buf
		local bufmap = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs,
				{ buffer = bufnr, silent = true, noremap = true, desc = desc })
		end

		bufmap("n", "gd",  vim.lsp.buf.definition,   "LSP: go to definition")
		bufmap("n", "K",   vim.lsp.buf.hover,         "LSP: hover")
		bufmap("n", "gl",  vim.diagnostic.open_float, "Show diagnostics")

		local caps = client and (client.server_capabilities or {}) or {}
		if caps.documentFormattingProvider or caps.documentRangeFormattingProvider then
			bufmap("n", "<leader>lf",
				function() vim.lsp.buf.format({ async = true, bufnr = bufnr }) end,
				"LSP: format buffer")
		end

		if caps.completionProvider then
			vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc",
				{ buf = bufnr })
		end
	end,
})

local mason_ok, mason = pcall(require, "mason")
if mason_ok then mason.setup() end

local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mlsp_ok then
	mason_lspconfig.setup({
		ensure_installed = {
			"gopls", "pyright", "clangd", "rust_analyzer",
			"ts_ls", "lua_ls", "svelte",
		},
	})
end

vim.lsp.config.gopls = {
	cmd       = { "gopls" },
	filetypes = { "go", "gomod" },
	settings  = { gopls = { gofumpt = true, staticcheck = true } },
}

vim.lsp.config.lua_ls = {
	filetypes = { "lua" },
	settings  = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace   = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
}

vim.lsp.config.dartls = {
	cmd          = { "dart", "language-server", "--protocol=lsp" },
	filetypes    = { "dart" },
	root_markers = { "pubspec.yaml" },
}

vim.lsp.enable({
	"gopls", "pyright", "clangd", "rust_analyzer",
	"ts_ls", "lua_ls", "dartls", "svelte",
})


vim.api.nvim_create_augroup("Makeprg", { clear = true })

local makeprg_map = {
	c = function()
		local file = vim.fn.expand("%:p")
		local out  = vim.fn.expand("%:p:r")
		return string.format("gcc -Wall -Wextra -g %s -o %s && %s", file, out, out)
	end,
	cpp = function()
		local file = vim.fn.expand("%:p")
		local out  = vim.fn.expand("%:p:r")
		return string.format("g++ -Wall -Wextra -std=c++17 -g %s -o %s && %s", file, out, out)
	end,
	python = function() return "python3 " .. vim.fn.expand("%:p") end,
	go     = function() return "go run " .. vim.fn.expand("%:p") end,
	rust   = function() return "cargo run" end,
	typst  = function() return "typst compile " .. vim.fn.expand("%:p") end,
}

for ft, fn in pairs(makeprg_map) do
	vim.api.nvim_create_autocmd("FileType", {
		group    = "Makeprg",
		pattern  = { ft },
		callback = function() vim.opt_local.makeprg = fn() end,
	})
end


local function set_wrap(extra_maps)
	vim.opt_local.wrap      = true
	vim.opt_local.linebreak = true
	local wopts = { noremap = true, silent = true, buffer = true }
	local maps = {
		{ { "n", "v", "x" }, "j",      "gj" },
		{ { "n", "v", "x" }, "0",      "g0" },
		{ { "n", "v", "x" }, "$",      "g$" },
		{ { "n", "v", "x" }, "о",      "gj" },
		{ { "n", "v", "x" }, "<C-n>",  "gj" },
		{ { "n", "v", "x" }, "k",      "gk" },
		{ { "n", "v", "x" }, "л",      "gk" },
		{ { "n", "v", "x" }, "<Down>", "gj" },
		{ { "n", "v", "x" }, "<Up>",   "gk" },
	}
	for _, m in ipairs(maps) do
		vim.keymap.set(m[1], m[2], m[3], wopts)
	end
	if extra_maps then extra_maps(wopts) end
end

vim.api.nvim_create_autocmd({ "BufNew", "BufEnter" }, {
	callback = function(args)
		local buf = args.buf

		-- only unnamed normal buffers
		if vim.bo[buf].buftype == ""
		   and vim.api.nvim_buf_get_name(buf) == ""
		   and vim.bo[buf].filetype == ""
		then
			vim.bo[buf].filetype = "markdown"
		end
	end,
})

vim.api.nvim_create_augroup("WrapAndVisualMove", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group   = "WrapAndVisualMove",
	pattern = { "markdown", "typst", "tex", "org", "mediawiki" },
	callback = function()
		set_wrap()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us,ru,kz"

		-- Dynamically get the path to your spell directory
		local spell_dir = vim.fn.stdpath("data") .. "/site/spell/"

		-- Explicitly list the three files for 1zg, 2zg, and 3zg
		vim.opt_local.spellfile = {
			spell_dir .. "en.utf-8.add",
			spell_dir .. "ru.utf-8.add",
			spell_dir .. "kz.utf-8.add",
		}
	end,
})

vim.api.nvim_create_augroup("MathMode", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group   = "MathMode",
	pattern = { "typst" },
	callback = function()
		set_wrap(function(wopts)
			-- vim.keymap.set("i", "$",     "$$<Left>",          wopts)
			vim.keymap.set("i", "MM",    "$<CR><CR>$<Esc>kA", wopts)
			vim.keymap.set("v", "<C-m>",     "c$$<Esc>P", { buffer = true })
			vim.keymap.set("v", "<C-s>",     "c\"\"<Esc>P", { buffer = true })
			vim.keymap.set("v", "<C-b>", "c**<Esc>P",     { buffer = true })
			vim.keymap.set("v", "<C-i>", "c__<Esc>P",     { buffer = true })
			vim.keymap.set("n", "]]", "/^=\\+<CR>", { buffer = true })
			vim.keymap.set("n", "[[", "/^=\\+<CR>", { buffer = true })
		end)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern  = { "markdown" },
	callback = function()
		vim.opt_local.number         = false
		vim.opt_local.relativenumber = false
	end,
})


-- vim.cmd("colorscheme gruber-darker")
-- vim.cmd("colorscheme retrobox")
-- vim.cmd("colorscheme ef-autumn")
vim.cmd("colorscheme ef-rosa")
-- vim.cmd("colorscheme ef-cherie")
-- vim.cmd("colorscheme ef-summer")
-- vim.cmd("colorscheme ef-dream")


vim.keymap.set("n", "<leader>ff", ":Pick files<CR>",     opts)
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>",   opts)


vim.keymap.set({ "n", "x" },      "<C-j>",         "<Cmd>MultipleCursorsAddDown<CR>",        { desc = "Cursor down" })
vim.keymap.set({ "n", "i", "x" }, "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>",        { desc = "Cursor down" })
vim.keymap.set({ "n", "x" },      "<C-k>",         "<Cmd>MultipleCursorsAddUp<CR>",          { desc = "Cursor up" })
vim.keymap.set({ "n", "i", "x" }, "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>",          { desc = "Cursor up" })
vim.keymap.set({ "n", "i" },      "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", { desc = "Add/remove cursor" })
vim.keymap.set({ "n", "x" },      "<Leader>a",     "<Cmd>MultipleCursorsAddMatches<CR>",     { desc = "Cursor on all matches" })
vim.keymap.set({ "n", "x" },      "<M-n>",         "<Cmd>MultipleCursorsAddJumpNextMatch<CR>")
vim.keymap.set({ "n", "x" },      "<M-N>",         "<Cmd>MultipleCursorsAddJumpPrevMatch<CR>")
vim.keymap.set({ "n", "x" },      "<leader>l",     function() require("multiple-cursors").align() end)


if vim.g.neovide then
	vim.o.guifont									= "Cascadia Mono"
	vim.o.guifont									= "IBM Plex Mono"
	vim.g.neovide_scale_factor						= 1.0
	vim.g.neovide_cursor_trail_size					= 2.0
	vim.g.neovide_cursor_antialiasing				= true
	vim.g.neovide_cursor_unfocused_outline_width	= 0.2
	local change_scale = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
	end
	vim.keymap.set({ "n", "v", "x", "t" }, "<C-=>", function() change_scale(0.2)  end, { desc = "Zoom in" })
	vim.keymap.set({ "n", "v", "x", "t" }, "<C-->", function() change_scale(-0.2) end, { desc = "Zoom out" })
	vim.keymap.set({ "n", "v", "x", "t" }, "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, { desc = "Reset zoom" })
end
