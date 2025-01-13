-- [nfnl] Compiled from fnl/disciple/vcs.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return _G.vim.keymap.set("n", "<Leader>gg", "<Cmd>0Git<CR>")
end
local function _2_()
  local gs = require("gitsigns")
  _G.vim.keymap.set({"n", "v"}, "<Leader>sh", gs.stage_hunk, {desc = "Stage hunk"})
  _G.vim.keymap.set({"n", "v"}, "<Leader>rh", gs.reset_hunk, {desc = "Reset hunk"})
  _G.vim.keymap.set({"n", "v"}, "<Leader>uh", gs.undo_stage_hunk, {desc = "Undo stage hunk"})
  _G.vim.keymap.set({"n", "v"}, "<Leader>sb", gs.stage_buffer, {desc = "Stage buffer"})
  _G.vim.keymap.set("n", "]h", gs.next_hunk, {desc = "Next hunk"})
  _G.vim.keymap.set("n", "[h", gs.prev_hunk, {desc = "Prev hunk"})
  return _G.vim.keymap.set("n", "<Leader>phi", gs.preview_hunk_inline, {desc = "Preview hunk inline"})
end
return {{"tpope/vim-fugitive", init = _1_}, {"lewis6991/gitsigns.nvim", opts = {culhl = true, signs = {changedelete = {text = "\226\148\135"}}, signs_staged = {changedelete = {text = "\226\148\135"}}, on_attach = _2_}}, {"julienvincent/hunk.nvim", cmd = {"DiffEditor"}, opts = {}}}
