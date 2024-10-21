-- [nfnl] Compiled from fnl/disciple/testing.fnl by https://github.com/Olical/nfnl, do not edit.
_G.vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
local function switch_test_app_file()
  local fname = vim.fn.expand("%:t")
  local dir = vim.fn.expand("%:h")
  if vim.startswith(fname, "test_") then
    return vim.cmd(("e " .. dir .. "/" .. fname:sub(6)))
  else
    return vim.cmd(("e " .. dir .. "/test_" .. fname))
  end
end
_G.vim.keymap.set("n", "<Leader>tn", switch_test_app_file)
vim.g.firenvim_config = {localSettings = {[".*"] = {takeover = "never"}}}
local function _2_()
  _G.vim.keymap.set("n", "<Leader>t<Space>", "<Cmd>TestFile<CR>")
  _G.vim.keymap.set("n", "<Leader>gt", "<Cmd>TestVisit<CR>")
  return _G.vim.keymap.set("n", "<Leader>tt", "<Cmd>TestLast<CR>")
end
local function _3_()
  vim.g["test#strategy"] = "toggleterm"
  return nil
end
local function _4_()
  vim.opt.signcolumn = "no"
  vim.opt.cursorline = false
  vim.wo.foldcolumn = "2"
  vim.wo.statusline = " "
  return nil
end
return {{"vim-test/vim-test", init = _2_, config = _3_}, {"akinsho/toggleterm.nvim", version = "*", opts = {open_mapping = {"<C-\\>"}, on_create = _4_, highlights = {StatusLine = {guibg = "#f4ede8"}}, insert_mappings = false, shade_terminals = false, terminal_mappings = false}}, {"glacambre/firenvim", build = ":call firenvim#install(0)"}}
