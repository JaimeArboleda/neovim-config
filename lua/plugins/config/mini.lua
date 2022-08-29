local present, mini = pcall(require, "mini.starter")

if not present then
  return
end

require('mini.comment').setup({})
require("mini.sessions").setup(
  {
    -- Whether to read latest session if Neovim opened without file arguments
    autoread = false,

    -- Whether to write current session before quitting Neovim
    autowrite = true,

    -- Directory where global sessions are stored (use `''` to disable)
    directory = '~/projects/.sessions',

    -- File for local session (use `''` to disable)
    file = '',

    -- Whether to force possibly harmful actions (meaning depends on function)
    force = { read = false, write = true, delete = false },

    -- Hook functions for actions. Default `nil` means 'do nothing'.
    hooks = {
      -- Before successful action
      pre = { read = nil, write = nil, delete = nil },
      -- After successful action
      post = { read = nil, write = nil, delete = nil },
    },

    -- Whether to print session path after action
    verbose = { read = false, write = true, delete = true },
  }

)

local function header()
	return [[
     ███╗   ██╗██╗   ██╗███╗   ███╗███╗   ███╗
     ████╗  ██║██║   ██║████╗ ████║████╗ ████║
     ██╔██╗ ██║██║   ██║██╔████╔██║██╔████╔██║
     ██║╚██╗██║╚██╗ ██╔╝██║╚██╔╝██║██║╚██╔╝██║
     ██║ ╚████║ ╚████╔╝ ██║ ╚═╝ ██║██║ ╚═╝ ██║
     ╚═╝  ╚═══╝  ╚═══╝  ╚═╝     ╚═╝╚═╝     ╚═╝ 
  ]]
end
local starter = require("mini.starter")
starter.setup(
    {
	    evaluate_single = true,
	    header = header,
	    items = {
		    starter.sections.builtin_actions(),
		    starter.sections.recent_files(10, false),
		    starter.sections.recent_files(10, true),
		    starter.sections.sessions(5, true),
	    },
	    content_hooks = {
		    starter.gen_hook.adding_bullet(),
		    starter.gen_hook.indexing("all", { "Builtin actions" }),
		    starter.gen_hook.padding(3, 2),
	    },
    }
)


-- remove gui window separator for using global statusline
vim.cmd [[hi WinSeparator guibg=none]]
require("mini.statusline").setup({set_vim_settings = false})
require("mini.tabline").setup(
    {
        -- Whether to show file icons (requires 'kyazdani42/nvim-web-devicons')
        show_icons = true,
        -- Whether to set Vim's settings for tabline (make it always shown and
        -- allow hidden buffers)
        set_vim_settings = true,
        -- Where to show tabpage section in case of multiple vim tabpages.
        -- One of 'left', 'right', 'none'.
        tabpage_section = "left"
    }
)

require("mini.surround").setup( { } )

require("mini.ai").setup({
  custom_textobjects = {
    L = function(ai_type)
      local line_num = vim.fn.line('.')
      local line = vim.fn.getline(line_num)
      -- Select `\n` past the line for `a` to delete it whole
      local from_col, to_col = 1, line:len() + 1
      if ai_type == 'i' then
        if line:len() == 0 then
          -- Don't remove empty line
          from_col, to_col = 0, 0
        else
          -- Ignore indentation for `i` textobject and don't remove `\n` past the line
          from_col = line:match('^%s*()')
          to_col = line:len()
        end
      end
      return { from = { line = line_num, col = from_col }, to = { line = line_num, col = to_col } }
    end,
    B = function(ai_type)
      local n_lines = vim.fn.line('$')
      local start_line, end_line = 1, n_lines
      if ai_type == 'i' then
        -- Skip first and last blank lines for `i` textobject
        local first_nonblank, last_nonblank = vim.fn.nextnonblank(1), vim.fn.prevnonblank(n_lines)
        start_line = first_nonblank == 0 and 1 or first_nonblank
        end_line = last_nonblank == 0 and n_lines or last_nonblank
      end

      local to_col = math.max(vim.fn.getline(end_line):len(), 1)
      return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
    end,
    C = function(ai_type)
      local line_num = vim.fn.line('.')
      local first_line = 1
      local last_line = vim.fn.line('$')
      local line = vim.fn.getline(line_num)
      local cond = function(l)
        if l:len() > 3 then
          if l:sub(1, 4) == '# %%' then
            return true
          end
        end
        return false
      end
      local found_up = true

      -- Find first line in cell
      while not cond(line) do
        line_num = line_num - 1
        line = vim.fn.getline(line_num)
        if line_num == 1 then 
          found_up = false
          break 
        end
      end

      if not found_up then
        local cur_pos = vim.api.nvim_win_get_cursor(0)
          return {
            from = { line = cur_pos[1], col = cur_pos[2] + 1 } 
          }
      end

      -- If inside, not include cell delimiter
      if ai_type == 'i' then
        first_line = line_num + 1
      else 
        first_line = line_num
      end

      -- Find last line in cell
      line_num = vim.fn.line('.')
      line = vim.fn.getline(line_num)
      local found_down = true
      while not cond(line) do
        if line_num == last_line then 
          found_down = false
          break 
        end
        line_num = line_num + 1
        line = vim.fn.getline(line_num)
      end
      local last_col = line:len()
      if found_down then
        last_line = line_num - 1
        line = vim.fn.getline(last_line)
        last_col = math.max(line:len(), 1)
      else 
        last_col = math.max(last_col, 1)
      end 
      return { from = { line = first_line, col = 1 }, to = { line = last_line, col = last_col } }
    end,
  },
})

require("mini.jump").setup({})
require("mini.completion").setup({})
vim.api.nvim_set_keymap('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

require("mini.indentscope").setup({})
vim.g.miniindentscope_disable=true
require("mini.pairs").setup({})
require("mini.fuzzy").setup({})
require("mini.jump2d").setup({
  mappings = {
    start_jumping = 'S',
  },
})
require('mini.bufremove').setup({})
-- require('mini.doc').setup({})
