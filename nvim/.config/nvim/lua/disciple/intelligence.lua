-- [nfnl] Compiled from fnl/disciple/intelligence.fnl by https://github.com/Olical/nfnl, do not edit.
vim.filetype.add({extension = {typ = "typst", v = "verilog", kk = "koka", rkt = "racket", pl = "prolog", mly = "menhir"}, filename = {yabairc = "sh", bordersrc = "sh"}})
local function _1_()
  vim.opt.clipboard = "unnamedplus"
  return nil
end
_G.vim.keymap.set("n", "<Leader>sc+", _1_)
local function _2_()
  local count = vim.v.count
  print(count)
  vim.opt.tabstop = count
  vim.opt.softtabstop = count
  vim.opt.shiftwidth = count
  return nil
end
_G.vim.keymap.set("n", "<Leader>st", _2_)
local function _3_(ev)
  local opts = {noremap = true, silent = true, buffer = ev.buf}
  local err = vim.diagnostic.severity.ERROR
  local jump = require("delimited").jump
  local function _4_()
    return jump({count = -1, float = true})
  end
  _G.vim.keymap.set("n", "[d", _4_, opts)
  local function _5_()
    return jump({count = 1, float = true})
  end
  _G.vim.keymap.set("n", "]d", _5_, opts)
  local function _6_()
    return jump({count = -1, float = true, severity = err})
  end
  _G.vim.keymap.set("n", "[D", _6_, opts)
  local function _7_()
    return jump({count = 1, float = true, severity = err})
  end
  _G.vim.keymap.set("n", "]D", _7_, opts)
  _G.vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  _G.vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  _G.vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
  _G.vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, opts)
  _G.vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
  local function _8_()
    return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end
  _G.vim.keymap.set("n", "<Leader>wsl", _8_, opts)
  _G.vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
  _G.vim.keymap.set("n", "<Leader>gs", vim.lsp.buf.signature_help, opts)
  _G.vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  return _G.vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
end
_G.vim.api.nvim_create_autocmd("LspAttach", {group = vim.api.nvim_create_augroup("UserLspConfig", {}), callback = _3_})
local function _9_()
  return _G.vim.keymap.set("n", "<Leader>gg", "<Cmd>0Git<CR>")
end
local function _10_()
  local gs = require("gitsigns")
  _G.vim.keymap.set({"n", "v"}, "<Leader>sh", gs.stage_hunk, {desc = "Stage hunk"})
  _G.vim.keymap.set({"n", "v"}, "<Leader>rh", gs.reset_hunk, {desc = "Reset hunk"})
  _G.vim.keymap.set({"n", "v"}, "<Leader>uh", gs.undo_stage_hunk, {desc = "Undo stage hunk"})
  _G.vim.keymap.set({"n", "v"}, "<Leader>sb", gs.stage_buffer, {desc = "Stage buffer"})
  _G.vim.keymap.set("n", "]h", gs.next_hunk, {desc = "Next hunk"})
  _G.vim.keymap.set("n", "[h", gs.prev_hunk, {desc = "Prev hunk"})
  return _G.vim.keymap.set("n", "<Leader>phi", gs.preview_hunk_inline, {desc = "Preview hunk inline"})
end
local function _11_(opts)
  require("nvim-treesitter.configs").setup(opts.opts)
  do
    local cfgs = require("nvim-treesitter.parsers").get_parser_configs()
    cfgs.sql = {install_info = {url = "~/Repositories/tree-sitter-sql", files = {"src/parser.c", "src/scanner.c"}, branch = "main", requires_generate_from_grammar = "true", generate_requires_npm = false}, filetype = "sql"}
  end
  return vim.treesitter.language.register("sql", "sql")
end
local function _12_(server_name)
  return require("lspconfig")[server_name].setup({})
end
local function _13_()
end
local function _14_()
  local lspconfig = require("lspconfig")
  return lspconfig.fennel_language_server.setup({filetypes = {"fennel"}, root_dir = lspconfig.util.root_pattern("fnl", "lua"), single_file_support = true, settings = {fennel = {diagnostics = {globals = {"vim", "jit", "comment"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}})
end
local function _15_()
  return require("lspconfig").ocamllsp.setup({})
end
local function _16_()
  local function _17_()
    return require("conform").format({async = true, lsp_fallback = true})
  end
  return _G.vim.keymap.set({"n", "v"}, "<Leader>f<Space>", _17_, {noremap = true, silent = true})
end
local function _18_()
  local i = require("ts_context_commentstring.integrations.comment_nvim")
  return require("Comment").setup({pre_hook = i.create_pre_hook()})
end
local function _19_()
  _G.vim.keymap.set({"n", "v"}, "p", "<Plug>(miniyank-autoput)")
  _G.vim.keymap.set({"n", "v"}, "P", "<Plug>(miniyank-autoPut)")
  _G.vim.keymap.set("n", "<Leader>n", "<Plug>(miniyank-cycle)")
  _G.vim.keymap.set("n", "<Leader>N", "<Plug>(miniyank-cycleback)")
  _G.vim.keymap.set("n", "<Leader><Space>c", "<Plug>(miniyank-tochar)")
  _G.vim.keymap.set("n", "<Leader><Space>l", "<Plug>(miniyank-toline)")
  return _G.vim.keymap.set("n", "<Leader><Space>b", "<Plug>(miniyank-toblock)")
end
local function _20_()
  return require("typst-preview").update()
end
return {{"jaawerth/fennel.vim"}, {"tpope/vim-fugitive", init = _9_}, {"NMAC427/guess-indent.nvim", opts = {}}, {"lewis6991/gitsigns.nvim", opts = {culhl = true, signs = {changedelete = {text = "\226\148\135"}}, signs_staged = {changedelete = {text = "\226\148\135"}}, on_attach = _10_}}, {"chrisgrieser/nvim-various-textobjs", event = "UIEnter", opts = {useDefaultKeymaps = true}}, {"nvim-treesitter/nvim-treesitter-textobjects"}, {"nvim-treesitter/nvim-treesitter", dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"}, main = "nvim-treesitter.configs", opts = {ensure_installed = {"c", "cpp", "css", "python", "lua", "fennel", "ocaml", "haskell", "perl", "gitcommit", "go", "java", "javascript", "prolog", "svelte", "typescript", "tsx"}, highlight = {enable = true}, sync_install = true, textobjects = {select = {enable = true, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner", aa = "@parameter.outer", ia = "@parameter.inner"}}}}, config = _11_, lazy = false}, {dir = "~/Code/delimited.nvim"}, {"Bilal2453/luvit-meta", lazy = true}, {"folke/lazydev.nvim", ft = "lua", opts = {library = {path = "luvit-meta/library", words = {"vim%.uv"}}}}, {"https://github.com/github/copilot.vim"}, {"williamboman/mason.nvim", opts = {}}, {"williamboman/mason-lspconfig.nvim", dependencies = {"williamboman/mason.nvim"}, opts = {ensure_installed = {"lua_ls", "fennel_language_server", "clangd", "pyright", "gopls", "ruff", "svelte", "ts_ls", "hls", "tinymist", "tailwindcss"}, automatic_installation = {exclude = {"ocamllsp"}}, handlers = {_12_, hls = _13_, fennel_language_server = _14_}}}, {"neovim/nvim-lspconfig", dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"}, config = _15_, lazy = false}, {"mrcjkb/haskell-tools.nvim", version = "^4", lazy = false}, {"Julian/lean.nvim", event = {"BufReadPre *.lean", "BufNewFile *.lean"}, opts = {}}, {"saghen/blink.cmp", dependencies = "rafamadriz/friendly-snippets", opts = {appearance = {nerd_font_variant = "mono", use_nvim_cmp_as_default = true}, keymap = {preset = "default"}, sources = {completion = {enabled_providers = {"lsp", "path", "snippets", "buffer"}}}}, opts_extend = {"sources.completion.enabled_providers"}, version = "v0.*", lazy = false}, {"stevearc/conform.nvim", opts = {formatters_by_ft = {lua = {"stylua"}, fennel = {"fnlfmt"}, cpp = {"clang-format"}, json = {"jq"}, javascript = {"prettierd"}, javascriptreact = {"prettierd"}, typescript = {"prettierd"}, typescriptreact = {"prettierd"}, python = {"ruff_format"}}}, init = _16_}, {"folke/trouble.nvim", opts = {}}, {"kylechui/nvim-surround", event = "VeryLazy", opts = {indent_lines = false}}, {"JoosepAlviste/nvim-ts-context-commentstring", opts = {enable_autocmd = true}}, {"numToStr/Comment.nvim", config = _18_}, {"stevearc/aerial.nvim", opts = {}}, {"bfredl/nvim-miniyank", init = _19_}, {"NMAC427/guess-indent.nvim", opts = {}}, {"axkirillov/hbac.nvim", opts = {threshold = 4}}, {"chomosuke/typst-preview.nvim", ft = "typst", version = "0.3.*", build = _20_}}
