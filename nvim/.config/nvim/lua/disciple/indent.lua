-- [nfnl] Compiled from fnl/disciple/indent.fnl by https://github.com/Olical/nfnl, do not edit.
local function raw_indent()
  return vim.cmd("execute \"normal i\\<CR>}\\<Esc>O\t\"")
end
return {}
