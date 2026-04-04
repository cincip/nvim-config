vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.breakindent = true
vim.opt.smoothscroll = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.softtabstop = 0
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.opt.cursorline = true
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

local function escape(str)
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
vim.opt.langmap = vim.fn.join({
  escape(ru_shift) .. ';' .. escape(en_shift),
  escape(ru) .. ';' .. escape(en),
}, ',')

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>yy', '"+yy', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>P', '"+P', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<M-l>', 'zl', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<M-h>', 'zh', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<M-L>', 'zL', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<M-H>', 'zH', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<M-j>', '<C-e>', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<M-k>', '<C-y>', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<M-q>', '<C-S-6>', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>x', ':e ~/buffer.md<CR>', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>c', ':e ~/Notes/scratchpad.md<CR>', opts)
vim.keymap.set({ 'n', 'v', 'x' }, '<C-c>at', ':e ~/org/todo.org<CR>', opts)

vim.keymap.set({ "i", "c" }, "<C-a>", "<Left>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-k>", "<Right>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-d>", "<delete>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<D-Space>", "", { noremap = true })
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("i", "<C-S-v>", "<C-r>+", { noremap = true, silent = true })

vim.keymap.set('n', '<leader><CR>', ":noh<CR>", opts)
vim.keymap.set('n', '<leader>q', "@q", opts)
vim.keymap.set('n', '<leader>lf', function()
	local clients = vim.lsp.get_active_clients({ bufnr = 0 })
	if not clients or vim.tbl_isempty(clients) then
		print("No LSP attached to buffer")
		return
	end
	vim.lsp.buf.format({ async = true })
end, opts)

for i = 1, 9 do
	vim.keymap.set("n", "<Leader>" .. i, i .. "gt", opts)
end
vim.keymap.set("n", "<Leader>t-", ":-tabm<CR>", opts)
vim.keymap.set("n", "<Leader>t=", ":+tabm<CR>", opts)
vim.keymap.set("n", "<Leader>tn", ':tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/', opts)
vim.keymap.set("n", "<Leader>t0", ":tabo<CR>", opts)
vim.keymap.set("n", "<Leader>tc", ":tabclose<CR>", opts)
vim.keymap.set("n", "<Leader>te", ":tab terminal<CR>", opts)
vim.keymap.set("n", "<C-l>", "gt", opts)
vim.keymap.set("n", "<C-h>", "gT", opts)
vim.keymap.set("n", "<C-S-l>", ":bp<CR>", opts)
vim.keymap.set("n", "<C-S-h>", ":bn<CR>", opts)
vim.keymap.set('t', '<C-Space>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("n", "<leader>o", ":Open %<CR>", { noremap = true })

vim.keymap.set("n", "<M-c>", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local s, e = line:find("[%w_]+", col + 1)
	if not s then return end
	local word = line:sub(s, e)
	local cap = word:sub(1, 1):upper() .. word:sub(2):lower()
	vim.api.nvim_set_current_line(line:sub(1, s - 1) .. cap .. line:sub(e + 1))
	vim.api.nvim_win_set_cursor(0, { row, e })
end, { noremap = true, desc = "Capitalize word (pure Lua)" })

vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { noremap = true })
vim.keymap.set("n", "<leader>h", ":split<CR>", { noremap = true })
vim.keymap.set("n", "<M-w>", "<C-w><C-w>", { noremap = true })

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
	{ src = "https://github.com/blazkowolf/gruber-darker.nvim" },
	{ src = "https://github.com/thesimonho/kanagawa-paper.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/Shatur/neovim-ayu" },
	{ src = "https://github.com/tanvirtin/monokai.nvim" },
	{ src = "https://github.com/xero/miasma.nvim" },
	{ src = "https://github.com/nvim-orgmode/orgmode" },
	{ src = "https://github.com/chipsenkbeil/org-roam.nvim" },
})

pcall(function()
	require "nvim-treesitter.configs".setup({
		ensure_installed = { "typescript", "javascript", "zig", "c", "python", "cpp", "kotlin", "typst", "dart", "go", "rust", "svelte" },
		highlight = { enable = true },
	})
end)

require "mini.pick".setup()
require "mini.ai".setup()
require "multiple-cursors".setup()

require "orgmode".setup({
	org_agenda_files = { "~/org-nvim/**/*" },
	org_default_notes_file = "~/org-nvim/refile.org",
})
vim.lsp.enable("org")

require "org-roam".setup({
	directory = "~/org-nvim",
	bindings = {
		prefix = "<leader>n",
		add_alias = "<leader>naa",
		remove_alias = "<leader>nar",
		add_origin = "<leader>noa",
		remove_origin = "<leader>nor",
		capture = "<leader>nc",
		complete_at_point = "<leader>n.",
		find_node = "<leader>nf",
		goto_next_node = "<leader>nn",
		goto_prev_node = "<leader>np",
		insert_node = "<leader>ni",
		insert_node_immediate = "<leader>nm",
		quickfix_backlinks = "<leader>nq",
		toggle_roam_buffer = "<leader>nl",
		toggle_roam_buffer_fixed = "<leader>nb",
	},
	extensions = {
		dailies = {
			directory = "daily",
		},
	},
})


pcall(function()
	require("supermaven-nvim").setup({
		keymaps = { accept_suggestion = "<Tab>", clear_suggestion = "<C-]>" },
		color = { suggestion_color = "#ffffff", cterm = 244 },
		log_level = "info",
		disable_inline_completion = false,
		disable_keymaps = false,
		condition = function() return false end,
	})
end)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local bufnr  = ev.buf

		local bufmap = function(mode, lhs, rhs, opts_)
			vim.keymap.set(mode, lhs, rhs,
				vim.tbl_extend("force", { buffer = bufnr, silent = true, noremap = true }, opts_ or {}))
		end
		bufmap("n", "gd", vim.lsp.buf.definition, { desc = "LSP: go to definition" })
		bufmap("n", "K", vim.lsp.buf.hover, { desc = "LSP: hover" })
		bufmap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: rename" })
		bufmap("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics (float)" })

		local caps = client.server_capabilities or {}
		if caps.documentFormattingProvider or caps.documentRangeFormattingProvider then
			bufmap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true, bufnr = bufnr }) end,
				{ desc = "LSP: format buffer" })
		end

		if caps.completionProvider then
			pcall(vim.api.nvim_buf_set_option, bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		end
	end,
})

local ok_mason, mason = pcall(require, "mason")
local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")

if ok_mason then
	mason.setup()
end

local mason_ensure = {
	"gopls",
	"pyright",
	"clangd",
	"rust_analyzer",
	"ts_ls",
	"lua_ls",
	"svelte",
}

if ok_mason_lsp then
	mason_lspconfig.setup({ ensure_installed = mason_ensure })
end


vim.lsp.config.gopls = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod" },
	settings = { gopls = { gofumpt = true, staticcheck = true } },
}

vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
	filetypes = { "lua" },
}

vim.lsp.config.dartls = {
	cmd = { "dart", "language-server", "--protocol=lsp" },
	filetypes = { "dart" },
	root_markers = { "pubspec.yaml" },
}


local servers_to_enable = {
	"gopls",
	"pyright",
	"clangd",
	"rust_analyzer",
	"ts_ls",
	"lua_ls",
	"dartls",
	"svelte",
}

if vim.lsp and vim.lsp.enable then
	vim.lsp.enable(servers_to_enable)
else
	vim.schedule(function()
		print(
			"Note: vim.lsp.enable is not available in this build. LSP servers will be attached by other means (Mason / external).")
	end)
end

local wrap_filetypes = { "markdown", "typst", "tex", "org", "mediawiki" }
vim.api.nvim_create_augroup("WrapAndVisualMove", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "WrapAndVisualMove",
	pattern = wrap_filetypes,
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		local wopts = { noremap = true, silent = true, buffer = true }
		vim.keymap.set({ 'n', 'v', 'x' }, "j", "gj", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "0", "g0", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "$", "g$", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "о", "gj", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "<C-n>", "gj", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "k", "gk", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "л", "gk", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "<Down>", "gj", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "<Up>", "gk", wopts)
	end,
})

local math_mode_filetypes = { "typst" }
vim.api.nvim_create_augroup("MathMode", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "MathMode",
	pattern = math_mode_filetypes,
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		local wopts = { noremap = true, silent = true, buffer = true }
		vim.keymap.set({ 'n', 'v', 'x' }, "j", "gj", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "0", "g0", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "$", "g$", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "о", "gj", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "<C-n>", "gj", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "k", "gk", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "л", "gk", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "<Down>", "gj", wopts)
		vim.keymap.set({ 'n', 'v', 'x' }, "<Up>", "gk", wopts)
		vim.keymap.set('i', "$", "$$<Left>", wopts)
		vim.keymap.set('i', "MM", "$<CR><CR>$<Esc>kA", wopts)
		vim.keymap.set('v', "$", "c$$<Esc>P", { buffer = true })
		vim.keymap.set('v', "<C-b>", "c**<Esc>P", { buffer = true })
		vim.keymap.set('v', "<C-i>", "c__<Esc>P", { buffer = true })

		vim.keymap.set("n", "]]", function()
			vim.fn.search("^=+", "W")
		end, { buffer = true })

		vim.keymap.set("n", "[[", function()
			vim.fn.search("^=+", "bW")
		end, { buffer = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

vim.cmd("set completeopt+=noselect")

pcall(function() vim.cmd("colorscheme quiet") end)

vim.keymap.set("n", "<leader>ff", ':Pick files<CR>', opts)
vim.keymap.set("n", "<leader>fg", ':Pick grep_live<CR>', opts)
vim.keymap.set("n", "<leader>fb", ':Pick buffers<CR>', opts)
vim.keymap.set('n', '<leader>e', ":Explore<CR>", opts)

vim.keymap.set({ "n", "x" }, "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add a cursor then move down" })
vim.keymap.set({ "n", "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add a cursor then move down" })
vim.keymap.set({ "n", "x" }, "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add a cursor then move up" })
vim.keymap.set({ "n", "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add a cursor then move up" })
vim.keymap.set({ "n", "i" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>",
	{ desc = "Add or remove a cursor" })
vim.keymap.set({ "n", "x" }, "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>",
	{ desc = "Add cursors to the word under the cursor" })
vim.keymap.set({ "n", "x" }, "<M-n>", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>")
vim.keymap.set({ "n", "x" }, "<M-N>", "<Cmd>MultipleCursorsAddJumpPrevMatch<CR>")
vim.keymap.set({ "n", "x" }, "<leader>l", function() require("multiple-cursors").align() end)

vim.keymap.set("n", "<leader>ts", function()
	if vim.o.laststatus == 0 then
		vim.o.laststatus = 1; vim.o.showtabline = 1; vim.o.cmdheight = 1
	else
		vim.o.laststatus = 0; vim.o.showtabline = 0; vim.o.cmdheight = 0
	end
end, { desc = "Toggle statusline" })

vim.keymap.set("n", "<leader>r", function()
	local file     = vim.fn.expand("%:p")
	local ext      = vim.fn.expand("%:e")
	local dir      = vim.fn.expand("%:p:h")
	local filename = vim.fn.expand("%:t:r")
	local function shell_escape(str) return "'" .. str:gsub("'", "'\"'\"'") .. "'" end
	local function spawn_wezterm(command, title)
		title = title or ("Running " .. filename)
		return string.format(
			"wezterm cli spawn --new-window --cwd %s bash -c %s",
			shell_escape(dir),
			shell_escape("echo 'Window: " ..
				title .. "' && " .. command .. "; echo 'Process finished. Press Enter to close...'; read")
		)
	end
	if vim.bo.modified then
		print("File has unsaved changes. Save first!"); return
	end
	local cmd = nil
	if ext == "c" then
		local exe_path = dir .. "/" .. filename
		local compile_cmd = string.format("gcc -Wall -Wextra -g %s -o %s", shell_escape(file), shell_escape(exe_path))
		cmd = string.format("%s && %s", compile_cmd, spawn_wezterm("./" .. filename, "C Program: " .. filename))
	elseif ext == "cpp" then
		local exe_path = dir .. "/" .. filename
		local compile_cmd = string.format("g++ -Wall -Wextra -std=c++17 -g %s -o %s", shell_escape(file),
			shell_escape(exe_path))
		cmd = string.format("%s && %s", compile_cmd, spawn_wezterm("./" .. filename, "C++ Program: " .. filename))
	elseif ext == "py" then
		cmd = spawn_wezterm("python3 " .. shell_escape(file), "Python: " .. filename)
	elseif ext == "go" then
		cmd = spawn_wezterm("go run " .. shell_escape(file), "Go: " .. filename)
	elseif ext == "rs" then
		cmd = spawn_wezterm("cargo run", "Rust: " .. filename)
	elseif ext == "typ" then
		local pdf_path = dir .. "/" .. filename .. ".pdf"
		local typst_cmd = string.format("echo 'Starting Typst watch mode...' && typst watch %s", shell_escape(file))
		cmd = string.format("%s & sleep 1 && zathura %s > /dev/null 2>&1 &",
			spawn_wezterm(typst_cmd, "Typst Watch: " .. filename), shell_escape(pdf_path))
	else
		print("Unsupported file type: " .. ext)
		return
	end
	print("Running: " .. filename .. "." .. ext)
	vim.cmd("!" .. cmd)
end, { desc = "Compile/Run various languages in new WezTerm window", noremap = true, silent = true })

vim.keymap.set("n", "<leader>rk", function()
	vim.cmd("!pkill -f 'typst watch'")
	vim.cmd("!pkill zathura")
	print("Killed running processes (typst watch, zathura)")
end, { desc = "Kill running processes (typst watch, zathura)", noremap = true, silent = true })

if vim.g.neovide then
	-- vim.o.guifont = "Iosevka Fixed"
	-- vim.o.guifont = "Input Mono"
	-- vim.o.guifont = "Cascadia Mono"
	vim.o.guifont = "Consolas"
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_cursor_trail_size = 2.0
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_unfocused_outline_width = 0.2
	local change_scale = function(delta) vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta end
	vim.keymap.set({ 'n', 'v', 'x', 't' }, "<C-=>", function() change_scale(0.2) end, { desc = "Zoom in" })
	vim.keymap.set({ 'n', 'v', 'x', 't' }, "<C-->", function() change_scale(-0.2) end, { desc = "Zoom out" })
	vim.keymap.set({ 'n', 'v', 'x', 't' }, "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end,
		{ desc = "Reset zoom" })
end
