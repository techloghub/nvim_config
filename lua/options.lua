-- [[ Setting options ]]
-- See `:help vim.o`

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.encoding = "utf-8"

-- Set highlight on search
vim.opt.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- The amount of space on screen a Tab character can occupy
vim.opt.tabstop = 4

-- Amount of characters Neovim will use to indent a line
vim.opt.shiftwidth = 4

-- Controls whether or not Neovim should transform a Tab character to spaces. 
vim.opt.expandtab = true

-- open new vertical split bottom
vim.opt.splitbelow = true

-- open new horizontal splits right
vim.opt.splitright = true

-- don't need the "-- INSERT --" mode hints
vim.opt.showmode = false

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- Display invisibale character
-- vim.opt.list = true
-- vim.opt.listchars = "space:·"

do local clip, opts = '/mnt/c/Windows/System32/clip.exe', {}
  function opts.callback()
    if vim.v.event.operator ~= 'y' then return end
    vim.fn.system(clip, vim.fn.getreg(0))
  end
  if vim.fn.executable(clip) then
    opts.group = vim.api.nvim_create_augroup("WSLYank", {clear = true})
    vim.api.nvim_create_autocmd("TextYankPost", opts)
  end
end

function ReplaceCrLfOnPaste()
    local cursor_save = vim.fn.getpos('.')

    vim.fn.setreg('+', vim.fn.substitute(vim.fn.getreg('+'), '\r\n$', '\n', ''))
    vim.fn.setpos('.', cursor_save)
end

vim.api.nvim_exec([[
    augroup ReplaceCrLfOnPaste
        autocmd!
        autocmd TextYankPost * lua ReplaceCrLfOnPaste()
    augroup END
]], false)
