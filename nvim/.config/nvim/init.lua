local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  {
    'https://github.com/rose-pine/neovim',
    lazy = false,
    priority = 1000,
    config = function()
      require('adaptive')
      require('rose-pine').setup({
        dark_variant = 'moon',
      })
      vim.cmd [[colorscheme rose-pine]]
    end
  },
  'nvim-lua/plenary.nvim',
  {
    'https://github.com/nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'rose-pine',
        section_separators = { left = '', right = '' },
        component_separators = ''
      }
    }
  },
  -- 'https://github.com/vale1410/vim-minizinc',
  { 'https://github.com/numToStr/Comment.nvim', config = true },
  {
    'https://github.com/kylechui/nvim-surround',
    opts = {
      indent_lines = false
    }
  },
  'norcalli/nvim-colorizer.lua',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/romainl/vim-cool',
  { dir = '~/Repositories/iswap.nvim' },
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/pechorin/any-jump.vim',
  { dir = '~/Code/longbow.nvim' },
  'https://github.com/nvim-treesitter/playground',
  -- 'https://github.com/folke/neodev.nvim',
  'https://github.com/stevearc/dressing.nvim',
  'https://github.com/hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
  'nvim-telescope/telescope-frecency.nvim',
  'tami5/sqlite.lua',
  'https://github.com/JuliaEditorSupport/julia-vim',
  'https://github.com/Nymphium/vim-koka',
  'lervag/vimtex',
  'https://github.com/MrcJkb/haskell-tools.nvim',
  'https://github.com/itchyny/vim-haskell-indent',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/vim-scripts/alex.vim',
  'nvim-tree/nvim-web-devicons',
  { 'kevinhwang91/nvim-ufo',    config = true },
  'kevinhwang91/promise-async',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-telescope/telescope-file-browser.nvim',
  'https://github.com/junegunn/vim-easy-align',
  { 'ruifm/gitlinker.nvim',               config = true },
  'kaarmu/typst.vim',
  'https://github.com/ziglang/zig.vim',
  'https://github.com/dhruvasagar/vim-table-mode',
  'https://github.com/smjonas/inc-rename.nvim',
  'https://github.com/natecraddock/telescope-zf-native.nvim',
  'https://github.com/ii14/neorepl.nvim',
  'goolord/alpha-nvim',
  -- 'MunifTanjim/nui.nvim',
  -- 'rcarriga/nvim-notify',
  'https://github.com/jaawerth/fennel.vim',
  'https://github.com/bfredl/nvim-miniyank',
  { "lukas-reineke/indent-blankline.nvim" },
  'https://github.com/linty-org/readline.nvim',
  'Olical/conjure',
  {
    'glacambre/firenvim',
    cond = not not vim.g.started_by_firenvim,
    build = function()
      require("lazy").load({ plugins = "firenvim", wait = true })
      vim.fn["firenvim#install"](0)
    end
  },
  'pwntester/octo.nvim',

}, {
  install = {
    colorscheme = { "rose-pine" },
  }
})

vim.cmd [[
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
]]


vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.opt.cmdheight = 1
vim.opt.laststatus = 3

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true

local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-1),
    ['<C-f>'] = cmp.mapping.scroll_docs(1),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    {
      name = 'buffer',
      option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end }
    }
  })
})

vim.opt.termguicolors = true

vim.g.vimtex_view_method = 'sioyek'
vim.g.vimtex_view_sioyek_exe = '/Applications/sioyek.app/Contents/MacOS/sioyek'

vim.cmd [[set ts=2 sw=2 sts=2 et]]

require('colorizer').setup {
  css = { rgb_fn = true, }
}

vim.opt.guicursor = ''

require('iswap').setup {
  debug = true,
  move_cursor = true
}

vim.opt.ignorecase = true
vim.opt.wrap = false

vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'

vim.diagnostic.config({ signs = false })

local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>sig', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>aws', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>rws', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>lws', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f<space>', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require('lspconfig')['ocamllsp'].setup {
  on_attach = on_attach
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}
require('lspconfig')['clangd'].setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require('lspconfig')['julials'].setup {
  on_attach = on_attach
}

require('lspconfig')['tsserver'].setup {
  on_attach = on_attach
}

require 'lspconfig'.tailwindcss.setup {}

require('lspconfig')['pyright'].setup {
  on_attach = on_attach,
  -- cmd = { "pyright-langserver", "--stdio", "-v", "/Users/ml/GlobalVenv" }
}

require('lspconfig')['lua_ls'].setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'require'
        },
        unusedLocalExclude = { "_*" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },

}

require('lspconfig')['gopls'].setup {
  on_attach = on_attach
}

require('lspconfig')['cssls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require('lspconfig')['typst_lsp'].setup {
  on_attach = on_attach,
  settings = {
    exportPdf = "onSave",
  }
}

require('lspconfig')['zls'].setup {
  on_attach = on_attach,
}

-- ENDLSP

-- require("neodev").setup()

vim.opt.signcolumn = 'yes'

vim.g.python3_host_prog = '~/GlobalVenv/bin/python3.9'

require('nvim-treesitter.configs').setup {
  highlight = { enable = true }
}

local function nc(keys, cmd)
  vim.keymap.set("n", "<leader>" .. keys, "<cmd>" .. cmd .. "<cr>")
end

require('gitsigns').setup {
  on_attach = function()
    vim.keymap.set({ "n", "v" }, "<leader>sh", "<cmd>Gitsigns stage_hunk<cr>")
    nc("sb", "Gitsigns stage_buffer")
    nc("rh", "Gitsigns reset_hunk")
    vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>")
    vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>")
    nc("pvh", "Gitsigns preview_hunk_inline")
  end
}

vim.g.filetype_pl = 'perl'

vim.opt.showmode = false

vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.opt.guifont = 'JetBrainsMono Nerd Font Mono:h18'

vim.cmd [[
command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\n' | pbcopy
command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d '\n' | pbcopy
command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d '\n' | pbcopy
command! -range=% PB <line1>,<line2>w !curl -F 'c=@-' https://ptpb.pw/?u=1 | tr -d '\n' | pbcopy
command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' http://ix.io | tr -d '\n' | pbcopy
command! -range=% EN <line1>,<line2>w !curl -F 'file=@-;' https://envs.sh | tr -d '\n' | pbcopy
command! -range=% TB <line1>,<line2>w !nc termbin.com 9999 | tr -d '\n' | pbcopy
]]

vim.cmd [[set formatoptions-=cro]]

local ht = require('haskell-tools')
local def_opts = { noremap = true, silent = true, }
ht.setup {
  tools = {
    hover = {
      disable = true
    }
  },
  hls = {
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
      vim.keymap.set('n', '<leader>cll', vim.lsp.codelens.run, opts)
      vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
    end,
  },
}

-- -- Suggested keymaps that do not depend on haskell-language-server
-- -- Toggle a GHCi repl for the current package
-- vim.keymap.set('n', '<leader>rr', ht.repl.toggle, def_opts)
-- -- Toggle a GHCi repl for the current buffer
-- vim.keymap.set('n', '<leader>rf', function()
--   ht.repl.toggle(vim.api.nvim_buf_get_name(0))
-- end, def_opts)
-- vim.keymap.set('n', '<leader>rq', ht.repl.quit, def_opts)

require("telescope").setup {
  defaults = {
    path_display = { absolute = true }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
    },
    frecency = {
      show_scores = true,
      auto_validate = false
    }
  },
}

nc("of", "Telescope frecency theme=dropdown")
nc("oo", "Telescope oldfiles theme=dropdown")
nc(",", "Telescope buffers theme=dropdown")
nc(".", "Telescope file_browser")
nc("rg", "Telescope live_grep")
nc("gg", "tab Git")

vim.opt.list = true
vim.opt.listchars = "tab:··"

vim.cmd [[
nn <Leader>s<Right> <cmd>ISwapNodeWithRight<CR>
nn <Leader>s<Left> <cmd>ISwapNodeWithLeft<CR>
nn <Leader>ss <cmd>ISwap<CR>
]]

-- require('ufo').setup()

vim.cmd [[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]

require("luasnip.loaders.from_snipmate").lazy_load()

vim.o.foldlevel = 10
vim.o.cursorline = true

require("oil").setup()

vim.cmd [[
au ColorScheme * hi! link NonText WinSeparator
]]

require "telescope".load_extension("frecency")
require("telescope").load_extension("zf-native")
local themes = require('telescope.themes')
vim.api.nvim_create_user_command('Recent', function()
  local Path = require "plenary.path"
  local os_home = vim.loop.os_homedir()
  require 'telescope'.extensions.frecency.frecency(themes.get_dropdown({
    path_display = function(_, filename)
      if vim.startswith(filename, os_home --[[@as string]]) then
        filename = "~/" .. Path:new(filename):make_relative(os_home)
      end
      return filename
    end,
    sorter = require 'telescope.config'.values.file_sorter(),
  }))
end, {})
require("telescope").load_extension "file_browser"

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
  "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
  "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
  "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
  "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
  "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
  "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
  " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
  " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
  "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
  "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
}

dashboard.section.header.opts.hl = 'Tag'

local leader = "SPC"
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

  local opts = {
    position = "center",
    shortcut = sc,
    cursor = 3,
    width = 30,
    align_shortcut = "right",
    hl_shortcut = "WinSeparator",
    hl = {
      { 'LineNr', 0, 5 },  -- highlight the icon glyph
      { 'LineNr', 6, 17 }, -- highlight the part after the icon glyph
    },
  }
  if keybind then
    keybind_opts = keybind_opts or { noremap = true, silent = true, nowait = true }
    opts.keymap = { "n", sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

-- Set menu
dashboard.section.buttons.val = {
  button("SPC o f", "    recents", ":Recent<CR>"),
  button("SPC .  ", "    browse", ":Telescope file_browser<CR>"),
  button("SPC g g", "    git", ":tab Git<CR>"),
  button("e      ", "    new-file", ":ene <BAR> startinsert <CR>"),
  button("SPC o o", "    oldfiles", ":Telescope oldfiles theme=dropdown<CR>"),
}

dashboard.section.buttons.opts = {
  spacing = 0,
}

local function headerPadding()
  return vim.fn.max({ 2, vim.fn.round((vim.fn.winheight(0) - 18) / 2) })
end

dashboard.config.layout = {
  { type = 'padding', val = headerPadding },
  dashboard.section.header,
  { type = 'padding', val = 2 },
  dashboard.section.buttons,
  dashboard.section.footer,
}

alpha.setup(dashboard.opts)

vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

vim.cmd [[
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END
]]

vim.cmd [[
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>n <Plug>(miniyank-cycle)
map <leader>N <Plug>(miniyank-cycleback)
map <Leader><Space>c <Plug>(miniyank-tochar)
map <Leader><Space>l <Plug>(miniyank-toline)
map <Leader><Space>b <Plug>(miniyank-toblock)
]]

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = { "*" },
  callback = function(ev)
    vim.cmd [[
    hi! link IndentBlanklineChar NonText
    " hi! GitSignsAdd        guifg=#d9e1dd blend=60
    " hi! GitSignsChange     guifg=#f2e9e1 blend=60
    " hi! GitSignsDelete     guifg=#ecd7d6 blend=60
    " hi! LuaLineDiffAdd    guifg=#56949f guibg=#faf4ed
    " hi! LuaLineDiffChange guifg=#d7827e guibg=#faf4ed
    " hi! LuaLineDiffDelete guifg=#b4637a guibg=#faf4ed
    ]]
  end
})

local readline = require 'readline'
vim.keymap.set('!', '<M-f>', readline.forward_word)
vim.keymap.set('!', '<M-b>', readline.backward_word)
vim.keymap.set('!', '<C-a>', readline.beginning_of_line)
vim.keymap.set('!', '<C-e>', readline.end_of_line)
vim.keymap.set('!', '<M-d>', readline.kill_word)
vim.keymap.set('!', '<M-BS>', readline.backward_kill_word)
vim.keymap.set('!', '<C-w>', readline.unix_word_rubout)
vim.keymap.set('!', '<C-k>', readline.kill_line)
vim.keymap.set('!', '<C-u>', readline.backward_kill_line)

vim.keymap.set('n', '<leader>cd', ':lcd %:h<CR>')

vim.opt.signcolumn = 'yes'

vim.keymap.set('n', 's', '<cmd>Longbow<CR>')
