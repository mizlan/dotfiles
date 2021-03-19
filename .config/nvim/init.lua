local paqpath = vim.fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'

if vim.fn.empty(vim.fn.glob(paqpath)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/savq/paq-nvim.git ' .. paqpath)
end

vim.cmd 'packadd paq-nvim'

local paq = require('paq-nvim').paq

paq {'savq/paq-nvim', opt=true}
paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/lsp_extensions.nvim'
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'
paq 'cormacrelf/vim-colors-github'
paq 'nvim-treesitter/nvim-treesitter'
paq 'liquidz/vim-iced'
paq 'guns/vim-sexp'
paq 'tpope/vim-commentary'
paq 'machakann/vim-sandwich'

--- Telescope
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    prompt_prefix = "", selection_caret = "", entry_prefix = "",
    layout_strategy = "horizontal",
    layout_defaults = { horizontal = { mirror = true } },
    mappings = { i = { ["<Esc>"] = actions.close },
                 n = { ["<Esc>"] = actions.close } },
  }
}
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':Telescope find_files<CR>', {silent = true, noremap = true})

--- Treesitter
require('nvim-treesitter.configs').setup {
  highlight = { enable = true, },
  textobjects = { select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
vim.cmd 'command! TSRehighlight :write | edit | TSBufEnable highlight'

--- Options
vim.api.nvim_set_keymap('n', '-', ':bd<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<Esc>', ':nohl<CR>', {silent = true, noremap = true})
vim.o.ignorecase = true
vim.o.background = 'light'
vim.cmd 'colo github'
vim.cmd 'set et ts=2 sts=2 sw=2'
vim.o.termguicolors = true
vim.o.laststatus = 0
vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'

vim.cmd 'runtime macros/sandwich/keymap/surround.vim'

--- Clojure
vim.g.sexp_mappings = {
  sexp_emit_head_element = 'gH',
  sexp_emit_tail_element = 'gL',
  sexp_capture_prev_element = 'gh',
  sexp_capture_next_element = 'gl',
}
vim.g.iced_default_key_mapping_leader = "<Localleader>"
vim.g.iced_enable_default_key_mappings = true
vim.api.nvim_set_keymap('n', 'gp', '<Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)', {silent = true})
