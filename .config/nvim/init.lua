local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd 'packadd packer.nvim'
require('packer').startup(function()
  use 'https://github.com/wbthomason/packer.nvim'
  use 'https://github.com/cormacrelf/vim-colors-github'
  use 'https://github.com/neovim/nvim-lspconfig'
  use 'https://github.com/arzg/vim-plan9'
  use 'https://github.com/nvim-treesitter/nvim-treesitter'
  use 'https://github.com/tpope/vim-commentary'
  use 'https://github.com/tpope/vim-repeat'
  use 'https://github.com/machakann/vim-sandwich'
  use 'https://github.com/junegunn/vim-easy-align'
  use 'https://github.com/bfredl/nvim-luadev'
  use 'https://github.com/janet-lang/janet.vim'
  use 'https://github.com/neomutt/neomutt.vim'
  use '~/util/telescope.nvim/'
  use 'https://github.com/tpope/vim-unimpaired'
  use 'https://github.com/romainl/vim-qf'
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
vim.cmd [[nmap ga <Plug>(EasyAlign)]]
vim.cmd [[syntax sync fromstart]]

--- Language Servers
local on_attach = function(_, bufnr)
  -- require('completion').on_attach()
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
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

require'lspconfig'.hls.setup{ on_attach = on_attach }
require'lspconfig'.tsserver.setup{ on_attach = on_attach }
require'lspconfig'.clangd.setup{ on_attach = on_attach }

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

--- Experiment
vim.cmd [[
  nmap <C-c><C-c> <Plug>(Luadev-RunLine)
  nmap <C-c><C-k> mbggVG<Plug>(Luadev-Run)'b
  vmap <Localleader>e <Plug>(Luadev-Run)
]]
vim.cmd[[nn gK viw"by:h <C-r>b<CR>]]
vim.cmd[[nn <Localleader>ld :Luadev<CR>:wincmd k<CR>:wincmd L<CR>:wincmd p<CR>]]

vim.cmd [[
  command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\n' | pbcopy
  command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d '\n' | pbcopy
  command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d '\n' | pbcopy
  command! -range=% PB <line1>,<line2>w !curl -F 'c=@-' https://ptpb.pw/?u=1 | tr -d '\n' | pbcopy
  command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' http://ix.io | tr -d '\n' | pbcopy
  command! -range=% EN <line1>,<line2>w !curl -F 'file=@-;' https://envs.sh | tr -d '\n' | pbcopy
  command! -range=% TB <line1>,<line2>w !nc termbin.com 9999 | tr -d '\n' | pbcopy
  ]]

--- imenu system
vim.cmd [[
  let &grepprg = 'rg --vimgrep $* -o'
  autocmd BufEnter *.clj let w:imenu_term = '''defn? ([A-Za-z0-9_-]+)'''
  autocmd BufEnter *.hs let w:imenu_term = '''(\w+)\s*::'''
  command! -nargs=0 Imenu execute 'silent lgrep! ' . w:imenu_term . ' ' . expand('%') | lopen
  ]]
