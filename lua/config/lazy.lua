-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    { 'nvim-treesitter/nvim-treesitter' },
    { 'theprimeagen/harpoon' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-sleuth' },
    { "ellisonleao/glow.nvim", config = function() require("glow").setup() end },

    { 'lewis6991/gitsigns.nvim' },

    --{ 'rose-pine/neovim', as = 'rose-pine', config = function() vim.cmd("colorscheme rose-pine") end },
    --{ 'danilo-augusto/vim-afterglow', as = 'afterglow' },
    { 'catppuccin/nvim', as = 'catppuccin', config = function() vim.cmd("colorscheme catppuccin") end },
    { 'preservim/nerdtree' },

    {
      'kevinhwang91/nvim-ufo',
      dependencies = {
        { 'kevinhwang91/promise-async' }
      }
    },

    { 'nvim-java/nvim-java' },
    {
      "carlos-algms/agentic.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
      opts = {
        -- Tell the plugin to use the gemini-cli you installed
        provider = "gemini-acp", 
      },
      keys = {
        { "<leader>at", "<cmd>lua require('agentic').toggle()<cr>", desc = "Togge Agentic" },
        { "<leader>aa", "<cmd>AgenticChat<cr>", desc = "Open Agentic Gemini Chat" },
        { "<leader>ap", "<cmd>AgenticPrompt<cr>", desc = "Send selection to Agent" },
      }
    },
    { import = "plugins" }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})


