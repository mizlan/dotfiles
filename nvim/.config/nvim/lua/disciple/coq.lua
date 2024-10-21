-- [nfnl] Compiled from fnl/disciple/coq.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g.loaded_coqtail = 1
  vim.g["coqtail#supported"] = 0
  return nil
end
local function _2_()
  _G.vim.keymap.set("n", "<C-c><C-j>", "<Cmd>VsCoq stepForward<CR>")
  _G.vim.keymap.set("n", "<C-c><C-k>", "<Cmd>VsCoq stepBackward<CR>")
  _G.vim.keymap.set("n", "<C-c><C-l>", "<Cmd>VsCoq interpretToPoint<CR>")
  _G.vim.keymap.set("n", "<C-c><C-e>", "<Cmd>VsCoq jumpToEnd<CR>")
  return _G.vim.keymap.set("n", "<C-c><C-g>", "<Cmd>VsCoq interpretToEnd<CR>")
end
return {{"whonore/Coqtail", init = _1_}, {"tomtomjhj/vscoq.nvim", init = _2_, opts = {}}}
