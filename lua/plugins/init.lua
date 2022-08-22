local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "akinsho/toggleterm.nvim" } -- Multiple terminals easier
  use { "lewis6991/impatient.nvim" } -- Speed up loading lua files
  use { "kyazdani42/nvim-web-devicons" } -- Required for next plugin
  use { "kyazdani42/nvim-tree.lua" } -- File explorer
  use { "nvim-telescope/telescope.nvim" } -- Fuzzy finder
  use { "machakann/vim-sandwich" }
  use { "phaazon/hop.nvim" } -- Like EasyMotion but better
  use { "tomasr/molokai" } -- color scheme
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)


