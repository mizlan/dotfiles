-- [nfnl] Compiled from fnl/disciple/intelligence.fnl by https://github.com/Olical/nfnl, do not edit.
vim.filetype.add({extension = {typ = "typst", v = "coq", kk = "koka", rkt = "racket", pl = "prolog", mly = "menhir"}, filename = {yabairc = "sh", bordersrc = "sh"}})
local function _1_()
  vim.opt.clipboard = "unnamedplus"
  return nil
end
_G.vim.keymap.set("n", "<Leader>sc+", _1_)
local function _2_()
  local count = vim.v.count
  vim.opt.tabstop = count
  vim.opt.softtabstop = count
  vim.opt.shiftwidth = count
  vim.opt.expandtab = (count ~= 8)
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
  _G.vim.keymap.set("n", "<Leader>sh", gs.stage_hunk, {desc = "Stage hunk"})
  _G.vim.keymap.set("n", "<Leader>rh", gs.reset_hunk, {desc = "Reset hunk"})
  _G.vim.keymap.set("n", "]h", gs.next_hunk, {desc = "Next hunk"})
  return _G.vim.keymap.set("n", "[h", gs.prev_hunk, {desc = "Prev hunk"})
end
local function _11_(server_name)
  return require("lspconfig")[server_name].setup({})
end
local function _12_()
  local lspconfig = require("lspconfig")
  return lspconfig.fennel_language_server.setup({filetypes = {"fennel"}, root_dir = lspconfig.util.root_pattern("fnl", "lua"), single_file_support = true, settings = {fennel = {diagnostics = {globals = {"vim", "jit", "comment"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}})
end
local function _13_()
  local cmp = require("cmp")
  return cmp.setup({mapping = cmp.mapping.preset.insert({["<C-b>"] = cmp.mapping.scroll_docs(-1), ["<C-f>"] = cmp.mapping.scroll_docs(1), ["<C-Space>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.abort(), ["<C-y>"] = cmp.mapping.confirm({select = true})}), sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "nvim_lsp_signature_help"}, {name = "buffer", option = {get_bufnrs = vim.api.nvim_list_bufs}}}), sorting = {comparators = {cmp.config.compare.offset, cmp.config.compare.exact, cmp.config.compare.score, cmp.config.compare.score, require("cmp-under-comparator").under, cmp.config.compare.kind, cmp.config.compare.sort_text, cmp.config.compare.length, cmp.config.compare.order}}})
end
local function _14_()
  local function _15_()
    return require("conform").format({async = true, lsp_fallback = true})
  end
  return _G.vim.keymap.set({"n", "v"}, "<Leader>f<Space>", _15_, {noremap = true, silent = true})
end
local function _16_()
  local i = require("ts_context_commentstring.integrations.comment_nvim")
  return {pre_hook = i.create_pre_hook()}
end
local function _17_()
  _G.vim.keymap.set("n", "p", "<Plug>(miniyank-autoput)")
  _G.vim.keymap.set("n", "P", "<Plug>(miniyank-autoPut)")
  _G.vim.keymap.set("n", "<Leader>n", "<Plug>(miniyank-cycle)")
  _G.vim.keymap.set("n", "<Leader>N", "<Plug>(miniyank-cycleback)")
  _G.vim.keymap.set("n", "<Leader><Space>c", "<Plug>(miniyank-tochar)")
  _G.vim.keymap.set("n", "<Leader><Space>l", "<Plug>(miniyank-toline)")
  return _G.vim.keymap.set("n", "<Leader><Space>b", "<Plug>(miniyank-toblock)")
end
return {{"jaawerth/fennel.vim"}, {"tpope/vim-fugitive", init = _9_}, {"NMAC427/guess-indent.nvim", opts = {}}, {"lewis6991/gitsigns.nvim", opts = {culhl = true, on_attach = _10_}}, {"chrisgrieser/nvim-various-textobjs", event = "UIEnter", opts = {useDefaultKeymaps = true}}, {"nvim-treesitter/nvim-treesitter-textobjects"}, {"nvim-treesitter/nvim-treesitter", dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"}, main = "nvim-treesitter.configs", opts = {ensure_installed = {"c", "cpp", "python", "lua", "fennel", "ocaml", "haskell", "perl", "gitcommit", "java", "javascript", "prolog", "typescript"}, highlight = {enable = true}, sync_install = true, textobjects = {select = {enable = true, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner", aa = "@parameter.outer", ia = "@parameter.inner"}}}}, lazy = false}, {dir = "~/Code/delimited.nvim"}, {"Bilal2453/luvit-meta", lazy = true}, {"folke/lazydev.nvim", ft = "lua", opts = {library = {path = "luvit-meta/library", words = {"vim%.uv"}}}}, {"williamboman/mason.nvim", opts = true}, {"williamboman/mason-lspconfig.nvim", dependencies = {"williamboman/mason.nvim"}, opts = {ensure_installed = {"lua_ls", "fennel_language_server", "clangd", "pyright", "ruff"}, handlers = {_11_, fennel_language_server = _12_}}}, {"neovim/nvim-lspconfig", dependencies = {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"}}, {"hrsh7th/nvim-cmp", config = _13_}, {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-nvim-lsp-signature-help"}, {"hrsh7th/cmp-buffer"}, {"lukas-reineke/cmp-under-comparator"}, {"stevearc/conform.nvim", opts = {formatters_by_ft = {lua = {"stylua"}, fennel = {"fnlfmt"}, cpp = {"clang-format"}, json = {"jq"}, javascript = {"prettierd"}, javascriptreact = {"prettierd"}, typescript = {"prettierd"}, typescriptreact = {"prettierd"}, python = {"ruff_format"}}}, init = _14_}, {"kylechui/nvim-surround", event = "VeryLazy", opts = {indent_lines = false}}, {"JoosepAlviste/nvim-ts-context-commentstring"}, {"numToStr/Comment.nvim", config = _16_}, {"stevearc/aerial.nvim", opts = {}}, {"bfredl/nvim-miniyank", init = _17_}}
