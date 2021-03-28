local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd 'packadd packer.nvim'
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'cormacrelf/vim-colors-github'
  use 'nvim-treesitter/nvim-treesitter'
  use 'liquidz/vim-iced'
  use 'guns/vim-sexp'
  use 'tpope/vim-commentary'
  use 'machakann/vim-sandwich'
  use 'junegunn/vim-easy-align'
  use 'bfredl/nvim-luadev'
  use 'danilamihailov/beacon.nvim'
  use 'ekaj2/limelight.vim'
  use 'janet-lang/janet.vim'
  use 'luochen1990/rainbow'
end)

--- Options
vim.o.guicursor=''
vim.api.nvim_set_keymap('n', '-', ':bd<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<Esc>', ':nohl<CR>', {silent = true, noremap = true})
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.background = 'dark'
vim.wo.signcolumn = 'yes'
vim.o.inccommand = 'nosplit'
vim.cmd 'colo github'
vim.cmd 'set et ts=2 sts=2 sw=2'
vim.o.termguicolors = true
vim.o.laststatus = 0
vim.o.guifont = 'Roboto Mono:h20'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'
vim.cmd 'runtime macros/sandwich/keymap/surround.vim'
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_matching_smart_case = 1
vim.g.completion_trigger_on_delete = 1
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.wo.wrap = false
vim.g.beacon_minimal_jump = 5
vim.cmd [[nn Q gqip]]
vim.cmd [[iabbrev frg Federal Republic of Germany]]
vim.cmd [[iabbrev gdr German Democratic Republic]]
vim.cmd [[nn Y "+y]]
vim.cmd [[vn Y "+y]]
vim.cmd [[nn ! :Beacon<CR>]]
vim.cmd [[nmap ga <Plug>(EasyAlign)]]
vim.g.rainbow_active = 1

--- Telescope
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    prompt_prefix = "  ", selection_caret = "◉ ", entry_prefix = "  ",
    prompt_position = "top",
    sorting_strategy = "ascending",
    borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    results_height = 10,
    mappings = {
      i = { ["<Esc>"] = actions.close },
      n = { ["<Esc>"] = actions.close }
    },
  }
}
vim.api.nvim_set_keymap('n', '<Leader>.', ':Telescope find_files previewer=false<CR>', {silent = true, noremap = true})
vim.cmd[[highlight link TelescopeSelection CursorLine]]

--- Language Servers
local on_attach = function(_, bufnr)
  require('completion').on_attach()
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gla', '<cmd>lua vim.lsp.buf.code_action()                               <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'glD', '<cmd>lua vim.lsp.buf.declaration()                               <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gld', '<cmd>lua vim.lsp.buf.definition()                                <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',   '<cmd>lua vim.lsp.buf.hover()                                     <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gli', '<cmd>lua vim.lsp.buf.implementation()                            <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gls', '<cmd>lua vim.lsp.buf.signature_help()                            <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'glt', '<cmd>lua vim.lsp.buf.type_definition()                           <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'glr', '<cmd>lua vim.lsp.buf.rename()                                    <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'glR', '<cmd>lua vim.lsp.buf.references()                                <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl?', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()              <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'glw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'glq', '<cmd>lua vim.lsp.diagnostic.set_loclist()                        <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[e',  '<cmd>lua vim.lsp.diagnostic.goto_prev()                          <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']e',  '<cmd>lua vim.lsp.diagnostic.goto_next()                          <CR>', opts)
end
require'lspconfig'.hls.setup{
  on_attach = on_attach
}

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

--- Clojure
vim.g.sexp_mappings = {
  sexp_emit_head_element = 'gH',
  sexp_emit_tail_element = 'gL',
  sexp_capture_prev_element = 'gh',
  sexp_capture_next_element = 'gl',
}
vim.g.iced_default_key_mapping_leader = "<Localleader>"
vim.g.iced_enable_default_key_mappings = true
vim.g.iced_enable_clj_kondo_analysis = true

--- Experiment
vim.cmd [[
  nmap <C-c><C-c> <Plug>(Luadev-RunLine)
  nmap <C-c><C-k> mbggVG<Plug>(Luadev-Run)'b
  vmap <Localleader>e <Plug>(Luadev-Run)
]]
vim.cmd[[nn gK viw"by:h <C-r>b<CR>]]
vim.cmd[[nn <Localleader>ld :Luadev<CR>:wincmd k<CR>:wincmd L<CR>:wincmd p<CR>]]
