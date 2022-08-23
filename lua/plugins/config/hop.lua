local present, hop = pcall(require, "hop")

if not present then
  return
end

hop.setup({
  case_insensitive = true,
  char2_fallback_key = '<CR>',
  quit_key='<Esc>',
})

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  return require('hop').hint_char2()
end,
{ silent = true, noremap = true, desc = "nvim-hop char2" })
