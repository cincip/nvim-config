vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.opt.shiftwidth = 2
vim.o.signcolumn = "yes"
vim.opt.expandtab = true
vim.o.swapfile = false
vim.opt.cursorline = true
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.opt.background = "dark"
-- vim.opt.background = "light"
vim.opt.termguicolors = true
-- vim.opt.guicursor = "i-c:block-Cursor"
-- vim.opt.iskeyword:remove("_")

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>yy', '"+yy<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>P', '"+P<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<M-l>', 'zl')
vim.keymap.set({ 'n', 'v', 'x' }, '<M-h>', 'zh')
vim.keymap.set({ 'n', 'v', 'x' }, '<M-L>', 'zL')
vim.keymap.set({ 'n', 'v', 'x' }, '<M-H>', 'zH')
vim.keymap.set({ 'n', 'v', 'x' }, '<M-j>', '<C-e>')
vim.keymap.set({ 'n', 'v', 'x' }, '<M-k>', '<C-y>')
vim.keymap.set("i", "<C-a>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Right>", { noremap = true })
vim.keymap.set("i", "<C-S-v>", "<C-r>+", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

for i = 1, 9 do
  vim.keymap.set("n", "<Leader>" .. i, i .. "gt", opts)
end
vim.keymap.set("n", "<Leader>t-", ":-tabm<CR>", opts)
vim.keymap.set("n", "<Leader>t=", ":+tabm<CR>", opts)
vim.keymap.set("n", "<Leader>tn", ":tabe ", opts)
vim.keymap.set("n", "<Leader>tc", ":tabclose<CR>", opts)
vim.keymap.set("n", "<Leader>te", ":tab terminal<CR>", opts)
vim.keymap.set('t', '<C-Space>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("n", "<leader>o", ":Open %<CR>", { noremap = true })

vim.pack.add({
  -- { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  -- { src = "https://github.com/arnamak/stay-centered.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  -- { src = "https://github.com/WTFox/jellybeans.nvim" },
  -- { src = "https://github.com/stevedylandev/ansi-nvim" },
  -- { src = "https://github.com/thembones79/mine-pine" },
  -- { src = "https://github.com/ramojus/mellifluous.nvim" },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Define the filetypes where you want wrapping + visual movement
local wrap_filetypes = { "markdown", "typst", "tex" }

-- Create an autocmd group to avoid duplicates
vim.api.nvim_create_augroup("WrapAndVisualMove", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "WrapAndVisualMove",
  pattern = wrap_filetypes,
  callback = function()
    -- Enable wrapping and linebreak
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true

    -- Remap movement keys to move by display lines, not logical lines
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set({ 'n', 'v', 'x' }, "j", "gj", opts)
    vim.keymap.set({ 'n', 'v', 'x' }, "<C-n>", "gj")
    vim.keymap.set({ 'n', 'v', 'x' }, "k", "gk", opts)
    vim.keymap.set({ 'n', 'v', 'x' }, "<Down>", "gj", opts)
    vim.keymap.set({ 'n', 'v', 'x' }, "<Up>", "gk", opts)
  end,
})

-- Disable line numbers for specific text-like formats (but not .txt)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
-- require "oil".setup()
-- require "stay-centered".setup()
require "nvim-autopairs".setup()
require "nvim-treesitter.configs".setup({
  ensure_installed = { "typescript", "javascript", "zig", "c", "python", "cpp", "kotlin", "typst" },
  highlight = { enable = true }
})

vim.lsp.enable({ "lua_ls", "zls", "clangd", "typescript-language-server", "tailwindcss-language-server",
  "prisma-language-server", "kotlin-language-server", "marksman", "tinymist", "pyright", "asm-lsp" })
-- vim.cmd("colorscheme jellybeans-mono")
-- vim.cmd("colorscheme jellybeans-default")
-- vim.cmd("colorscheme ansi")
-- vim.cmd("colorscheme mine-pine")
-- vim.cmd("colorscheme mine-pine-prime")
-- vim.cmd("colorscheme mellifluous")
-- vim.cmd("colorscheme desert")
vim.cmd("colorscheme retrobox")
-- vim.cmd("colorscheme habamax")
-- vim.cmd("colorscheme peachpuff")
-- vim.cmd("colorscheme slate")
vim.keymap.set("n", "<leader>ff", ':Pick files<CR>')
vim.keymap.set("n", "<leader>fg", ':Pick grep_live<CR>')
vim.keymap.set("n", "<leader>fb", ':Pick buffers<CR>')
vim.keymap.set('n', '<leader>e', ":Explore<CR>")
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Show diagnostics (float)" })
-- vim.keymap.set("n", "<leader>sc", function()
--   require("stay-centered").toggle()
-- end, { desc = "Toggle Stay Centered" })

vim.keymap.set("n", "<leader>ts", function()
  if vim.o.laststatus == 0 then
    vim.o.laststatus = 1
    vim.o.showtabline = 1
    vim.o.cmdheight = 1
  else
    vim.o.laststatus = 0
    vim.o.showtabline = 0
    vim.o.cmdheight = 0
  end
end, { desc = "Toggle statusline" })

-- Set up a keymap to compile & run C/C++/Python/Lua/Typst/Zig in a new WezTerm pane/window
vim.keymap.set("n", "<leader>r", function()
  local file     = vim.fn.expand("%:p")      -- absolute path to current file
  local ext      = vim.fn.expand("%:e")      -- file extension
  local dir      = vim.fn.expand("%:p:h")    -- directory of current file
  local filename = vim.fn.expand("%:t:r")    -- name without extension
  
  -- Function to properly quote/escape paths for shell commands
  local function shell_escape(str)
    return "'" .. str:gsub("'", "'\"'\"'") .. "'"
  end
  
  local function spawn_wezterm(command, title)
    title = title or ("Running " .. filename)
    return string.format(
      "wezterm cli spawn --new-window --cwd %s bash -c %s",
      shell_escape(dir),
      shell_escape("echo 'Window: " .. title .. "' && " .. command .. "; echo 'Process finished. Press Enter to close...'; read")
    )
  end
  
  -- Check if file is saved
  if vim.bo.modified then
    print("File has unsaved changes. Save first!")
    return
  end
  
  local cmd = nil
  if ext == "c" then
    local exe_path = dir .. "/" .. filename
    -- Add debug flags and better error handling
    local compile_cmd = string.format("gcc -Wall -Wextra -g %s -o %s", 
      shell_escape(file), 
      shell_escape(exe_path)
    )
    cmd = string.format("%s && %s", 
      compile_cmd,
      spawn_wezterm("./" .. filename, "C Program: " .. filename)
    )
  elseif ext == "cpp" then
    local exe_path = dir .. "/" .. filename
    -- Add C++17 standard and debug flags
    local compile_cmd = string.format("g++ -Wall -Wextra -std=c++17 -g %s -o %s", 
      shell_escape(file), 
      shell_escape(exe_path)
    )
    cmd = string.format("%s && %s", 
      compile_cmd,
      spawn_wezterm("./" .. filename, "C++ Program: " .. filename)
    )
  elseif ext == "py" then
    cmd = spawn_wezterm("python3 " .. shell_escape(file), "Python: " .. filename)
  elseif ext == "lua" then
    cmd = spawn_wezterm("lua " .. shell_escape(file), "Lua: " .. filename)
  elseif ext == "typ" then
    local pdf_path = dir .. "/" .. filename .. ".pdf"
    -- Just run typst watch - it will compile initially and then watch for changes
    local typst_cmd = string.format(
      "echo 'Starting Typst watch mode...' && typst watch %s",
      shell_escape(file)
    )
    cmd = string.format(
      "%s & sleep 1 && zathura %s > /dev/null 2>&1 &",
      spawn_wezterm(typst_cmd, "Typst Watch: " .. filename),
      shell_escape(pdf_path)
    )
  elseif ext == "rs" then
    -- Rust support
    cmd = spawn_wezterm("cargo run", "Rust: " .. filename)
  elseif ext == "go" then
    -- Go support  
    cmd = spawn_wezterm("go run " .. shell_escape(file), "Go: " .. filename)
  elseif ext == "js" then
    -- JavaScript/Node.js support
    cmd = spawn_wezterm("node " .. shell_escape(file), "Node.js: " .. filename)
  elseif ext == "java" then
    -- Java support
    local class_name = filename
    local compile_and_run = string.format(
      "javac %s && java -cp %s %s",
      shell_escape(file),
      shell_escape(dir),
      class_name
    )
    cmd = spawn_wezterm(compile_and_run, "Java: " .. filename)
  elseif ext == "sh" or ext == "bash" then
    -- Shell script support
    cmd = spawn_wezterm("chmod +x " .. shell_escape(file) .. " && " .. shell_escape(file), "Shell: " .. filename)
  elseif ext == "zig" then
    -- Zig support
    cmd = spawn_wezterm("zig run " .. shell_escape(file), "Zig: " .. filename)
  else
    print("Unsupported file type: " .. ext)
    print("Supported: c, cpp, py, lua, typ, rs, go, js, java, sh, bash, zig")
    return
  end
  
  print("Running: " .. filename .. "." .. ext)
  vim.cmd("!" .. cmd)
end, {
  desc = "Compile/Run various languages in new WezTerm window",
  noremap = true,
  silent = true,
})

-- Additional keymap for killing running processes
vim.keymap.set("n", "<leader>rk", function()
  vim.cmd("!pkill -f 'typst watch'")  -- Kill typst watch processes
  vim.cmd("!pkill zathura")           -- Kill zathura instances
  print("Killed running processes (typst watch, zathura)")
end, {
desc = "Kill running processes (typst watch, zathura)",
  noremap = true,
  silent = true,
})


if vim.g.neovide then
  -- vim.o.guifont = "Iosevka SS05"
  vim.o.guifont = "Cascadia Code"
  -- vim.o.guifont = "ComicShannsMono Nerd Font"
  vim.g.neovide_scale_factor = 3.0

  vim.g.neovide_cursor_trail_size = 2.0
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.200

  local change_scale = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
  end

  vim.keymap.set({ 'n', 'v', 'x', 't' }, "<C-=>", function() change_scale(0.1) end, { desc = "Zoom in" })
  vim.keymap.set("n", "<C-->", function() change_scale(-0.1) end, { desc = "Zoom out" })
  vim.keymap.set({ 'n', 'v', 'x', 't' }, "<C-0>", function() vim.g.neovide_scale_factor = 2.0 end,
    { desc = "Reset zoom" })
end
