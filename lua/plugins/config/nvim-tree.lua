local present, hop = pcall(require, "nvim-tree")

if not present then
  return
end

require("nvim-tree").setup() 
