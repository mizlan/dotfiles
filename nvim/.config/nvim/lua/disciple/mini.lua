-- [nfnl] Compiled from fnl/disciple/mini.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  require("mini.files").setup({mappings = {close = "<Esc>", go_in_plus = "<CR>"}})
  require("mini.ai").setup()
  require("mini.bufremove").setup()
  return require("mini.align").setup()
end
local function _2_()
  local function _3_()
    local function _4_()
      if (vim.v.count ~= 0) then
        return nil
      else
        return vim.api.nvim_buf_get_name(0)
      end
    end
    return require("mini.files").open(_4_())
  end
  _G.vim.keymap.set("n", "-", _3_, {desc = "Switch buffer"})
  local function _5_()
    return require("mini.bufremove").delete()
  end
  return _G.vim.keymap.set("n", "<Leader>bd", _5_, {desc = "Remove buffer"})
end
return {{"echasnovski/mini.nvim", version = "*", config = _1_, init = _2_}}
