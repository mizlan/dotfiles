-- [nfnl] Compiled from fnl/disciple/navigation.fnl by https://github.com/Olical/nfnl, do not edit.
vim.opt.undofile = true
local function _1_()
  vim.keymap.set("n", "<Leader>,", "<Cmd>Telescope buffers<CR>", {desc = "Switch buffer"})
  vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", {desc = "Find file"})
  vim.keymap.set("n", "<Leader>fo", "<Cmd>Telescope oldfiles<CR>", {desc = "Find old file"})
  vim.keymap.set("n", "<Leader>sp", "<Cmd>Telescope live_grep<CR>", {desc = "Find old file"})
  return vim.keymap.set("n", "<Leader>ss", "<Cmd>Telescope lsp_document_symbols<CR>", {desc = "Find LSP symbol"})
end
local function _2_()
  return require("telescope").load_extension("fzf")
end
local function _3_()
  return require("leap").create_default_mappings()
end
return {{"nvim-telescope/telescope.nvim", init = _1_, opts = {defaults = {history = {cycle_wrap = true}, prompt_prefix = " \239\128\130  ", selection_caret = "  ", entry_prefix = "  "}, pickers = {buffers = {theme = "ivy", previewer = false}, oldfiles = {theme = "ivy", previewer = false}, find_files = {theme = "ivy", hidden = true, find_command = {"rg", "--files", "--glob", "!.git", "--glob", "!venv", "--glob", "!_build", "--glob", "!_opam", "--glob", "!dist-newstyle", "--hidden"}, previewer = false}}, extensions = {fzf = {fuzzy = true, override_generic_sorter = true, override_file_sorter = true}}}, dependencies = {"https://github.com/nvim-lua/plenary.nvim"}, lazy = false}, {"nvim-telescope/telescope-fzf-native.nvim", build = "make", dependencies = {"nvim-telescope/telescope.nvim"}, config = _2_}, {"folke/which-key.nvim", event = "VeryLazy", opts = {}}, {"ggandor/leap.nvim", config = _3_}, {"stevearc/quicker.nvim", opts = true}, {"kevinhwang91/nvim-bqf", opts = {preview = {winblend = 0}}}}
