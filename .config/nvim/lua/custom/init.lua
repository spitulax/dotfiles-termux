require("custom.plugins")

local opt = vim.opt
local cmd = vim.cmd

-- Vim options
cmd.colorscheme("catppuccin")
opt.laststatus = 3
opt.showmode = false
opt.cursorline = true
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false
opt.shortmess:append "sI"
opt.signcolumn = "no"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.whichwrap:append "<>[]hl"
opt.listchars = {
  space = "·",
  tab = "←-→",
  trail = "∼",
  nbsp = "-",
}
opt.list = true

-- Mappings
local setkey = vim.keymap.set

setkey("n", "!", ":!", {nowait = true})
setkey("n", "<C-p>", "\"+p")
setkey("n", "<M-p>", "\"+P")
setkey("n", "<C-c>", "\"+y")
setkey("n", "<C-q>", "<cmd>qa<cr>")
setkey("n", "<C-s>", "<cmd>w<cr>")
setkey("n", "<M-t>", "<cmd>tabnew<cr>")
setkey("n", "<M-q>", "<cmd>tabclose<cr>")
setkey("n", "<M-a>", "<cmd>tabonly<cr>")
setkey("n", "<Esc>", "<cmd>noh<cr>")
setkey("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', {expr = true})
setkey("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', {expr = true})
setkey("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', {expr = true})
setkey("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', {expr = true})

setkey("i", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "<Down>" : "<Esc>gja"', {expr = true})
setkey("i", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "<Up>" : "<Esc>gka"', {expr = true})

setkey("v", "<C-y>", "\"+y")
setkey("v", "<C-n>", ":norm ", {nowait = true})
setkey("v", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', {expr = true})
setkey("v", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', {expr = true})
setkey("v", "<", "<gv")
setkey("v", ">", ">gv")

setkey("x", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', {expr = true})
setkey("x", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', {expr = true})

setkey("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true))

-- Miscellaneous
vim.api.nvim_create_user_command("Datetime", function()
  vim.cmd("r !date '+\\%F \\%R'")
end, {nargs=0})
