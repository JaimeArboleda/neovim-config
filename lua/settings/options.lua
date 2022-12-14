local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local exec = vim.api.nvim_exec

-- General settings
opt.backup = false                          -- creates a backup file
opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.swapfile = false                        -- creates a swapfile

-- Better clipboard
-- opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard

opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
opt.conceallevel = 0                        -- so that `` is visible in markdown files
opt.fileencoding = "utf-8"                  -- the encoding written to a file
opt.hlsearch = true                         -- highlight all matches on previous search pattern
opt.ignorecase = true                       -- ignore case in search patterns
opt.mouse = "a"                             -- allow the mouse to be used in neovim
opt.pumheight = 10                          -- pop up menu height
opt.showtabline = 0                         -- always show tabs
opt.smartcase = true                        -- smart case
opt.smartindent = true                      -- make indenting smarter again
opt.splitbelow = true                       -- force all horizontal splits to go below current window
opt.splitright = true                       -- force all vertical splits to go to the right of current window
opt.termguicolors = true                    -- set term gui colors (most terminals support this)
opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true                         -- enable persistent undo
opt.updatetime = 300                        -- faster completion (4000ms default)
opt.expandtab = true                        -- convert tabs to spaces
opt.cursorline = true                       -- highlight the current line
opt.number = true                           -- set numbered lines
opt.relativenumber = true                   -- show relative number
opt.copyindent = true                       -- copy previous indentation
opt.lazyredraw = true                       -- lazily redraw screen. It's faster
opt.preserveindent = true                   -- preserve indentation as much as possible
opt.laststatus = 3
opt.showcmd = false
opt.ruler = false
opt.numberwidth = 4                         -- set number column width to 2 {default 4}
opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
opt.wrap = true                            -- display lines as one long line
opt.breakindent = true
opt.linebreak = true
opt.scrolloff = 8                           -- is one of my fav
opt.sidescrolloff = 8
opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
opt.fillchars.eob=" "
opt.shortmess:append "c"
opt.whichwrap:append("<,>,[,],h,l")
opt.iskeyword:append("-")


-- highlight on yank

exec(
    [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
  augroup end
]],
    false
)

opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
  

-- don't auto comment new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]
