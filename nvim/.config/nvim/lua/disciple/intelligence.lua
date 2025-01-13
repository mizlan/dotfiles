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
local function _9_(server_name)
  return require("lspconfig")[server_name].setup({})
end
local function _10_()
end
local function _11_()
  local lspconfig = require("lspconfig")
  return lspconfig.fennel_language_server.setup({filetypes = {"fennel"}, root_dir = lspconfig.util.root_pattern("fnl", "lua"), single_file_support = true, settings = {fennel = {diagnostics = {globals = {"vim", "jit", "comment"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}})
end
local function _12_()
  return require("lspconfig").ocamllsp.setup({})
end
local function _13_()
  local function _14_()
    return require("conform").format({async = true, lsp_fallback = true})
  end
  return _G.vim.keymap.set({"n", "v"}, "<Leader>f<Space>", _14_, {noremap = true, silent = true})
end
local function _15_()
  local i = require("ts_context_commentstring.integrations.comment_nvim")
  return require("Comment").setup({pre_hook = i.create_pre_hook()})
end
local function _16_()
  _G.vim.keymap.set({"n", "v"}, "p", "<Plug>(miniyank-autoput)")
  _G.vim.keymap.set({"n", "v"}, "P", "<Plug>(miniyank-autoPut)")
  _G.vim.keymap.set("n", "<Leader>n", "<Plug>(miniyank-cycle)")
  _G.vim.keymap.set("n", "<Leader>N", "<Plug>(miniyank-cycleback)")
  _G.vim.keymap.set("n", "<Leader><Space>c", "<Plug>(miniyank-tochar)")
  _G.vim.keymap.set("n", "<Leader><Space>l", "<Plug>(miniyank-toline)")
  return _G.vim.keymap.set("n", "<Leader><Space>b", "<Plug>(miniyank-toblock)")
end
local function _17_()
  return require("typst-preview").update()
end
return {{"jaawerth/fennel.vim"}, {"chrisgrieser/nvim-various-textobjs", event = "UIEnter", opts = {keymaps = {useDefaults = true}}}, {"mizlan/delimited.nvim"}, {"Bilal2453/luvit-meta", lazy = true}, {"folke/lazydev.nvim", ft = "lua", opts = {library = {path = "luvit-meta/library", words = {"vim%.uv"}}}}, {"williamboman/mason.nvim", opts = {}}, {"williamboman/mason-lspconfig.nvim", dependencies = {"williamboman/mason.nvim"}, opts = {ensure_installed = {"lua_ls", "fennel_language_server", "clangd", "pyright", "gopls", "ruff", "svelte", "ts_ls", "hls", "tinymist", "tailwindcss"}, automatic_installation = {exclude = {"ocamllsp"}}, handlers = {_9_, hls = _10_, fennel_language_server = _11_}}}, {"neovim/nvim-lspconfig", dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"}, config = _12_, lazy = false}, {"mrcjkb/haskell-tools.nvim", version = "^4", lazy = false}, {"Julian/lean.nvim", event = {"BufReadPre *.lean", "BufNewFile *.lean"}, opts = {}}, {"saghen/blink.cmp", dependencies = "rafamadriz/friendly-snippets", opts = {appearance = {nerd_font_variant = "mono", use_nvim_cmp_as_default = true}, keymap = {preset = "default"}, sources = {default = {"lsp", "path", "snippets", "buffer"}}}, opts_extend = {"sources.completion.enabled_providers"}, version = "v0.*", lazy = false}, {"stevearc/conform.nvim", opts = {formatters_by_ft = {lua = {"stylua"}, fennel = {"fnlfmt"}, cpp = {"clang-format"}, json = {"jq"}, javascript = {"prettierd"}, javascriptreact = {"prettierd"}, typescript = {"prettierd"}, typescriptreact = {"prettierd"}, python = {"ruff_format"}}}, init = _13_}, {"folke/trouble.nvim", opts = {}}, {"kylechui/nvim-surround", event = "VeryLazy", opts = {indent_lines = false}}, {"JoosepAlviste/nvim-ts-context-commentstring", opts = {enable_autocmd = true}}, {"numToStr/Comment.nvim", config = _15_}, {"stevearc/aerial.nvim", opts = {}}, {"bfredl/nvim-miniyank", init = _16_}, {"NMAC427/guess-indent.nvim", opts = {}}, {"axkirillov/hbac.nvim", opts = {threshold = 14}}, {"chomosuke/typst-preview.nvim", ft = "typst", version = "0.3.*", build = _17_}}
