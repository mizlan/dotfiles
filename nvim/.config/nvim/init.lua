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

vim.g.python3_host_prog = '~/GlobalVenv/bin/python3.9'
vim.opt.termguicolors = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[D', function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, })
      end,
      bufopts)
    vim.keymap.set('n', ']D', function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, })
      end,
      bufopts)
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
  end,
})

require("lazy").setup({
  {
    'https://github.com/rose-pine/neovim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        pattern = { "rose-pine*" },
        callback = function(_ev)
          vim.cmd [[
          hi! link IndentBlanklineChar NonText
          hi def CoqtailChecked guibg=#d9e1dd
          hi def CoqtailSent guibg=#f2e9e1
          hi! GitSignsAdd        guifg=#bacfc4 blend=20
          hi! GitSignsChange     guifg=#e6d2c1 blend=20
          hi! GitSignsDelete     guifg=#dbb6b4 blend=20
          hi! LuaLineDiffAdd    guifg=#56949f guibg=#faf4ed
          hi! LuaLineDiffChange guifg=#d7827e guibg=#faf4ed
          ]]
        end
      })
      require('adaptive')
      require('rose-pine').setup({
        dark_variant = 'moon',
        disable_italics = true,
        highlight_groups = {
          TelescopeBorder = { fg = "overlay", bg = "overlay" },
          TelescopeNormal = { fg = "subtle", bg = "overlay" },
          TelescopeSelection = { fg = "text", bg = "highlight_med" },
          TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
          TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
          TelescopeTitle = { fg = "base", bg = "love" },
          TelescopePromptTitle = { fg = "base", bg = "pine" },
          TelescopePreviewTitle = { fg = "base", bg = "iris" },
          TelescopePromptNormal = { fg = "text", bg = "surface" },
          TelescopePromptBorder = { fg = "surface", bg = "surface" },
        }
      })
      vim.cmd [[colorscheme rose-pine]]
    end
  },
  {
    'https://github.com/sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        pattern = { "everforest" },
        callback = function(_ev)
          vim.cmd [[
          hi! link IndentBlanklineChar NonText
          hi def CoqtailChecked guibg=#425047
          hi def CoqtailSent guibg=#343f44
          ]]
        end
      })
      vim.g.everforest_background = 'medium'
      vim.g.everforest_better_performance = 1
    end
  },
  'nvim-lua/plenary.nvim',
  {
    'https://github.com/nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = ''
      }
    }
  },
  {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    opts = {
      highlight = { enable = true },
    }
  },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  {
    'https://github.com/numToStr/Comment.nvim',
    opts = function()
      return { pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() }
    end,
  },
  {
    'https://github.com/kylechui/nvim-surround',
    opts = {
      indent_lines = false
    }
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup(nil, { css = true, })
    end
  },
  {
    'https://github.com/neovim/nvim-lspconfig',
    config = function()
      vim.diagnostic.config({ signs = false })
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      require('lspconfig')['ocamllsp'].setup {
      }
      require('lspconfig')['clangd'].setup {
        capabilities = capabilities
      }
      require('lspconfig')['tsserver'].setup {
      }
      require 'lspconfig'.tailwindcss.setup {}
      require('lspconfig')['pyright'].setup {
        -- cmd = { "pyright-langserver", "--stdio", "-v", "/Users/ml/GlobalVenv" }
      }
      require('lspconfig')['gopls'].setup {
      }
      require('lspconfig')['cssls'].setup {
        capabilities = capabilities,
      }
      require('lspconfig')['typst_lsp'].setup {
        settings = {
          exportPdf = "onSave",
        }
      }
    end
  },
  'https://github.com/romainl/vim-cool',
  {
    dir = '~/Repositories/indianboy42/iswap.nvim',
    opts =
    {
      debug = true,
      move_cursor = true
    }
  },
  -- { 'https://github.com/IndianBoy42/iswap.nvim', branch = 'expand_key' },
  'https://github.com/tpope/vim-fugitive',
  {
    'https://github.com/lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        on_attach = function()
          vim.keymap.set({ "n", "v" }, "<leader>sh", "<cmd>Gitsigns stage_hunk<cr>", { desc = "stage hunk" })
          vim.keymap.set("n", "<leader>sb", "<Cmd>Gitsigns stage_buffer<CR>", { desc = "stage buffer" })
          vim.keymap.set("n", "<leader>rh", "<Cmd>Gitsigns reset_hunk<CR>", { desc = "reset hunk" })
          vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "next hunk" })
          vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "previous hunk" })
          vim.keymap.set("n", "<leader>phi", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "preview hunk inline" })
          vim.keymap.set("n", "<leader>pho", "<cmd>Gitsigns preview_hunk<cr>", { desc = "preview hunk overlay" })
        end
      }
    end
  },

  { dir = '~/Code/longbow.nvim' },
  'https://github.com/nvim-treesitter/playground',
  'https://github.com/stevearc/dressing.nvim',
  {
    'https://github.com/hrsh7th/nvim-cmp',
    config = function()
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
          },
          { name = 'conjure' },
        })
      })
    end
  },
  'hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
  'https://github.com/PaterJason/cmp-conjure',
  {
    'https://github.com/nvim-telescope/telescope.nvim',
    lazy = false,
    init = function()
      print('bruh')
      vim.keymap.set('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', { desc = "find file" })
      vim.keymap.set('n', '<Leader>fr', '<Cmd>Recent<CR>', { desc = "find frecent file" })
      vim.keymap.set('n', '<Leader>fo', '<Cmd>Telescope oldfiles theme=ivy<CR>', { desc = "find recent file" })
      vim.keymap.set('n', '<Leader>,', '<Cmd>Telescope buffers ignore_current_buffer=true theme=ivy<CR>',
        { desc = "switch to buffer" })
      vim.keymap.set('n', [[<Leader>']], '<Cmd>Telescope resume<CR>', { desc = "resume previous search" })
      vim.keymap.set('n', [[<Leader>sp]], '<Cmd>Telescope live_grep_args<CR>', { desc = "ripgrep" })
      vim.keymap.set('n', '<Leader>gg', '<Cmd>0Git<CR>', { desc = "fugitive" })
    end,
    config = function()
      local actions = require('telescope.actions')
      local lga_actions = require("telescope-live-grep-args.actions")
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,
            },
          },
          history = {
            cycle_wrap = true,
          },
          path_display = { absolute = true },
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
        },
        pickers = {
          buffers = {
            theme = 'ivy',
            layout_config = {
              height = 0.5
            }
          },
          find_files = {
            theme = 'ivy',
            layout_config = {
              height = 0.5
            }
          },
          frecency = {
            theme = "ivy"
          }
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          },
          frecency = {
            show_scores = true,
            auto_validate = false,
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            },
            theme = "dropdown", -- use dropdown theme
          }
        },
      }
      require("telescope").load_extension("frecency")
      require("telescope").load_extension "file_browser"
      require("telescope").load_extension("zf-native")
      local themes = require('telescope.themes')
      vim.api.nvim_create_user_command('Recent', function()
        local Path = require "plenary.path"
        local os_home = vim.loop.os_homedir()
        require 'telescope'.extensions.frecency.frecency(themes.get_ivy({
          path_display = function(_, filename)
            if vim.startswith(filename, os_home --[[@as string]]) then
              filename = "~/" .. Path:new(filename):make_relative(os_home)
            end
            return filename
          end,
          sorter = require 'telescope.config'.values.file_sorter(),
          layout_config = {
            height = 0.5
          }
        }))
      end, {})
    end
  },
  'nvim-telescope/telescope-frecency.nvim',
  { 'https://github.com/nvim-telescope/telescope-live-grep-args.nvim' },
  'https://github.com/nvim-telescope/telescope-file-browser.nvim',
  'https://github.com/natecraddock/telescope-zf-native.nvim',
  {
    'lervag/vimtex',
    config = function()
      vim.g.vimtex_view_method = 'sioyek'
      vim.g.vimtex_view_sioyek_exe = '/Applications/sioyek.app/Contents/MacOS/sioyek'
    end
  },
  {
    'https://github.com/MrcJkb/haskell-tools.nvim',
    version = '^3', -- Recommended
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    config = function()
      local ht = require('haskell-tools')
      vim.g.haskell_tools = {
        tools = {
          hover = {
            disable = true
          }
        },
        hls = {
          filetypes = { 'haskell', 'lhaskell', 'cabal' },
          on_attach = function(_client, bufnr)
            local opts = vim.tbl_extend('keep', { noremap = true, silent = true, }, { buffer = bufnr, })
            vim.keymap.set('n', '<leader>cll', vim.lsp.codelens.run, opts)
            vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
          end,
        },
      }
    end
  },
  'https://github.com/itchyny/vim-haskell-indent',
  {
    'https://github.com/L3MON4D3/LuaSnip',
    config = function()
      vim.cmd [[
      " press <Tab> to expand or jump in a snippet. These can also be mapped separately
      " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
      imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
      inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
      snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
      snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
      " For changing choices in choiceNodes (not strictly necessary for a basic setup).
      imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      ]]
      require("luasnip.loaders.from_snipmate").lazy_load()
    end
  },
  'https://github.com/vim-scripts/alex.vim',
  'nvim-tree/nvim-web-devicons',
  { 'kevinhwang91/nvim-ufo',                                          config = true },
  'kevinhwang91/promise-async',
  'https://github.com/hrsh7th/cmp-buffer',
  {
    'https://github.com/stevearc/oil.nvim',
    config = function()
      require("oil").setup {}
      vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    end
  },
  {
    'https://github.com/junegunn/vim-easy-align',
    config = function()
      vim.cmd [[nmap ga <Plug>(EasyAlign)]]
    end
  },
  { 'ruifm/gitlinker.nvim',                       config = true },
  'kaarmu/typst.vim',
  'https://github.com/dhruvasagar/vim-table-mode',
  { 'https://github.com/smjonas/inc-rename.nvim', config = true },
  'https://github.com/ii14/neorepl.nvim',
  {
    'goolord/alpha-nvim',
    config = function()
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

      dashboard.section.header.opts.hl = 'Function'

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
            { 'LineNr', 0, 17 }, -- highlight the part after the icon glyph
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
        button("SPC f r", "  recents", ":Recent<CR>"),
        button("-      ", "  browse", ":Oil<CR>"),
        button("SPC g g", "  git", ":0 Git<CR>"),
        button("i      ", "  new-file", ":ene <BAR> startinsert <CR>"),
        button("SPC f o", "  oldfiles", ":Telescope oldfiles theme=dropdown<CR>"),
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
    end
  },
  'https://github.com/jaawerth/fennel.vim',
  {
    'https://github.com/bfredl/nvim-miniyank',
    config = function()
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
    end
  },

  -- { "lukas-reineke/indent-blankline.nvim" },
  {
    'https://github.com/linty-org/readline.nvim',
    config = function()
      local readline = require 'readline'
      vim.keymap.set('x', '<M-f>', readline.forward_word)
      vim.keymap.set('x', '<M-b>', readline.backward_word)
      vim.keymap.set('x', '<C-a>', readline.beginning_of_line)
      vim.keymap.set('x', '<C-e>', readline.end_of_line)
      vim.keymap.set('x', '<M-d>', readline.kill_word)
      vim.keymap.set('x', '<M-BS>', readline.backward_kill_word)
      vim.keymap.set('x', '<C-w>', readline.unix_word_rubout)
      vim.keymap.set('x', '<C-k>', readline.kill_line)
      vim.keymap.set('x', '<C-f>', "<Right>")
      vim.keymap.set('x', '<C-b>', "<Left>")
    end
  },
  {
    'Olical/conjure',
    config = function()
      vim.g['conjure#mapping#prefix'] = '<Leader>'
    end
  },
  {
    'glacambre/firenvim',
    cond = not not vim.g.started_by_firenvim,
    build = function()
      require("lazy").load({ plugins = "firenvim", wait = true })
      vim.fn["firenvim#install"](0)
    end
  },
  { 'pwntester/octo.nvim', config = true },
  { 'moll/vim-bbye' },
  'rhysd/conflict-marker.vim',
  {
    'https://github.com/chrisgrieser/nvim-spider',
    config = function()
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
    end
  },
  'wakatime/vim-wakatime',
  {
    'anuvyklack/hydra.nvim',
    config = function()
      local Hydra = require('hydra')
      Hydra({
        name = 'Side scroll',
        mode = 'n',
        body = 'z',
        heads = {
          { 'h', '5zh' },
          { 'l', '5zl', { desc = '←/→' } },
          { 'H', 'zH' },
          { 'L', 'zL', { desc = 'half screen ←/→' } },
        }
      })
    end
  },
  'sheerun/vim-polyglot',
  'https://github.com/tpope/vim-eunuch',
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
  'rktjmp/lush.nvim',
  'rstacruz/vim-closer',
  {
    "williamboman/mason.nvim",
    config = true
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- config = function()
    --   require("mason-lspconfig").setup()
    --   require("mason-lspconfig").setup_handlers {
    --     ["typst_lsp"] = function()
    --       require("lspconfig")["typst_lsp"].setup {
    --         settings = {
    --           exportPdf = "onType" -- Choose onType, onSave or never.
    --           -- serverPath = "" -- Normally, there is no need to uncomment it.
    --         }
    --       }
    --     end,
    --   }
    -- end
  },
  {
    'https://github.com/whonore/Coqtail',
    lazy = false,
    config = function()
      vim.g.coqtail_nomap = 1
      vim.keymap.set({ 'n', 'i' }, '<C-c><C-l>', '<Plug>CoqToLine')
      vim.keymap.set({ 'n', 'i' }, '<C-c><C-j>', '<Plug>CoqNext')
      vim.keymap.set({ 'n', 'i' }, '<C-c><C-k>', '<Plug>CoqUndo')
      vim.keymap.set({ 'n', 'i' }, '<C-c><C-g>', '<Plug>CoqJumpToEnd')
    end
  },
  {
    'nathom/filetype.nvim',
    opts = {
      overrides = {
        extensions = {
          typ = "typst",
          v = "coq",
        },
        complex = {
          [".*rc$"] = "sh"
        }
      }
    }
  },
  { "https://github.com/pbrisbin/vim-colors-off" },
  {
    "https://github.com/nanotech/jellybeans.vim",
    config = function()
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        pattern = { "everforest" },
        callback = function(_ev)
          vim.cmd [[
          hi! link IndentBlanklineChar NonText
          hi def CoqtailChecked guibg=#425047
          hi def CoqtailSent guibg=#343f44
          ]]
        end
      })
    end
  },
  --
  -- {
  --   "https://github.com/ludovicchabant/vim-gutentags",
  --   filetypes = { 'coq' },
  --   config = function()
  --     vim.g.gutentags_ctags_executable = '/opt/homebrew/bin/ctags'
  --     vim.g.gutentags_gtags_options_file = 'coq.ctags'
  --     vim.g.gutentags_add_default_project_roots = 0
  --     vim.g.gutentags_generate_on_missing = 0
  --     vim.g.gutentags_generate_on_new = 0
  --     vim.g.gutentags_generate_on_write = 0
  --   end,
  --   cmd = "GutentagsUpdate"
  -- },
  { "folke/neodev.nvim",                         opts = {} },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      triggers_nowait = {
        "<leader>"
      }
    }
  },
  'https://github.com/wlangstroth/vim-racket',

}, {
  install = {
    colorscheme = { "rose-pine" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "netrwPlugin",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.opt.signcolumn = 'yes'
vim.opt.cmdheight = 0
vim.opt.laststatus = 3

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true

vim.cmd [[set ts=2 sw=2 sts=2 et]]

vim.opt.ignorecase = true
vim.opt.wrap = false

vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.opt.showmode = false

vim.cmd [[
command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\n' | pbcopy
command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d '\n' | pbcopy
command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d '\n' | pbcopy
command! -range=% EN <line1>,<line2>w !curl -F 'file=@-;' https://envs.sh | tr -d '\n' | pbcopy
command! -range=% TB <line1>,<line2>w !nc termbin.com 9999 | tr -d '\n' | pbcopy
]]

vim.cmd [[set formatoptions-=cro]]

vim.cmd [[
nn <Leader>s<Right> <cmd>ISwapNodeWithRight<CR>
nn <Leader>s<Left> <cmd>ISwapNodeWithLeft<CR>
nn <Leader>ss <cmd>ISwap<CR>
]]

vim.o.foldlevel = 10

vim.cmd [[
au ColorScheme * hi! link NonText WinSeparator
]]

vim.keymap.set('n', '<leader>cd', ':lcd %:h<CR>')

vim.cmd [[
function! Slick()
  let fname = resolve(expand('%:p'))
  bwipeout
  exec "edit " . fname
endfunction
command FollowSymlink call Slick()
]]

vim.cmd [[
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
]]

vim.opt.linespace = 10
vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
vim.g.neovide_cursor_vfx_particle_density = 17.0
vim.g.neovide_cursor_vfx_particle_phase = 4.5
vim.g.neovide_cursor_vfx_particle_curl = 4.0
vim.opt.guifont = 'JetBrains Mono:h24'

local function neovideScale(amount)
  local temp = vim.g.neovide_scale_factor + amount

  if temp < 0.5 then
    return
  end

  vim.g.neovide_scale_factor = temp
end

vim.keymap.set("n", "<C-=>", function()
  neovideScale(0.1)
end)

vim.keymap.set("n", "<C-->", function()
  neovideScale(-0.1)
end)
