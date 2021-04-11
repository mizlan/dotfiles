local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd 'packadd packer.nvim'
require('packer').startup(function()
  use 'https://github.com/wbthomason/packer.nvim'
  use 'https://github.com/neovim/nvim-lspconfig'
  use 'https://github.com/nvim-lua/completion-nvim'
  use 'https://github.com/nvim-lua/popup.nvim'
  use 'https://github.com/nvim-lua/plenary.nvim'
  use 'https://github.com/cormacrelf/vim-colors-github'
  use 'https://github.com/nvim-treesitter/nvim-treesitter'
  use 'https://github.com/liquidz/vim-iced'
  use 'https://github.com/guns/vim-sexp'
  use 'https://github.com/tpope/vim-sexp-mappings-for-regular-people'
  use 'https://github.com/tpope/vim-commentary'
  use 'https://github.com/tpope/vim-repeat'
  use 'https://github.com/machakann/vim-sandwich'
  use 'https://github.com/junegunn/vim-easy-align'
  use 'https://github.com/bfredl/nvim-luadev'
  use 'https://github.com/danilamihailov/beacon.nvim'
  use 'https://github.com/ekaj2/limelight.vim'
  use 'https://github.com/janet-lang/janet.vim'
  use 'https://github.com/neomutt/neomutt.vim'
  use 'https://github.com/mizlan/yui'
  use 'https://github.com/lifepillar/vim-gruvbox8/'
  use 'https://github.com/pechorin/any-jump.vim'
  use '~/util/telescope.nvim/'
  -- use 'https://github.com/hrsh7th/nvim-compe'
  -- use 'https://github.com/tami5/vim-iced-compe'
end)

--- Options
vim.o.guicursor=''
vim.api.nvim_set_keymap('n', '-', ':bd<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<Esc>', ':nohl<CR>', {silent = true, noremap = true})
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.background = 'light'
vim.wo.signcolumn = 'yes'
vim.o.inccommand = 'nosplit'
vim.g.yui_comments = 'fade'
vim.cmd [[colo github]]
vim.cmd 'set et ts=2 sts=2 sw=2'
vim.o.termguicolors = true
vim.o.laststatus = 2
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
vim.g.beacon_enable = 0
vim.cmd [[nn Q gqip]]
vim.cmd [[iabbrev frg Federal Republic of Germany]]
vim.cmd [[iabbrev gdr German Democratic Republic]]
vim.cmd [[nn Y "+y]]
vim.cmd [[vn Y "+y]]
vim.cmd [[nn ! :Beacon<CR>]]
vim.cmd [[nmap ga <Plug>(EasyAlign)]]
-- vim.g.sexp_enable_insert_mode_mappings = 0


--- Telescope
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
require'lspconfig'.clangd.setup{
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

--- Compe
-- require'compe'.setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 1;
--   preselect = 'enable';
--   throttle_time = 80;
--   source_timeout = 200;
--   incomplete_delay = 400;
--   max_abbr_width = 100;
--   max_kind_width = 100;
--   max_menu_width = 100;
--   documentation = true;

--   source = {
--     path = true;
--     buffer = true;
--     calc = true;
--     nvim_lsp = true;
--     nvim_lua = true;
--     vsnip = true;
--   };
-- }

--- Clojure

-- ARCHIVED: using regular-people plugin
-- vim.g.sexp_mappings = {
--   sexp_emit_head_element = 'gH',
--   sexp_emit_tail_element = 'gL',
--   sexp_capture_prev_element = 'gh',
--   sexp_capture_next_element = 'gl',
-- }
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
