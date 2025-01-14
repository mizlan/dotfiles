-- [nfnl] Compiled from fnl/disciple/visuals.fnl by https://github.com/Olical/nfnl, do not edit.
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.number = false
vim.opt.wrap = false
vim.opt.background = "light"
local function _1_()
  return vim.highlight.on_yank({higroup = "Todo", timeout = 200})
end
_G.vim.api.nvim_create_autocmd("TextYankPost", {group = vim.api.nvim_create_augroup("highlight_yank", {}), desc = "Highlight on yank", callback = _1_})
local function _2_()
  if vim.g.neovide then
    vim.g.neovide_input_macos_option_key_is_meta = "only_left"
    vim.opt.linespace = 5
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 5
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 60
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_cursor_vfx_opacity = 300
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
    vim.g.neovide_cursor_vfx_particle_speed = 20
    vim.g.neovide_cursor_vfx_particle_density = 45
    vim.g.neovide_cursor_vfx_particle_phase = 12
    vim.g.neovide_cursor_vfx_particle_curl = 0.8
    local function _3_()
      vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor + 0.1)
      return os.execute("/Users/ml/.config/yabai/microshift.sh")
    end
    vim.keymap.set("n", "<C-+>", _3_)
    local function _4_()
      vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor - 0.1)
      return os.execute("/Users/ml/.config/yabai/microshift.sh")
    end
    vim.keymap.set("n", "<C-->", _4_)
    local function _5_()
      vim.g.neovide_scale_factor = 1
      return os.execute("/Users/ml/.config/yabai/microshift.sh")
    end
    return vim.keymap.set("n", "<C-0>", _5_)
  else
    return nil
  end
end
_G.vim.api.nvim_create_autocmd({"UIEnter"}, {callback = _2_})
vim.diagnostic.config({float = {header = "", max_width = math.min(math.floor((vim.o.columns * 0.7)), 100), max_height = math.min(math.floor((vim.o.lines * 0.3)), 30)}, signs = false, underline = false, virtual_text = false})
local function _7_()
  require("rose-pine").setup({disable_italics = true, highlight_groups = {LineNr = {fg = "highlight_high"}, CursorLineNr = {fg = "muted", bg = "highlight_low", inherit = false}, CursorLineSign = {bg = "highlight_low"}, StatusLine = {fg = "muted", bg = "highlight_low"}, DiagnosticVirtualTextError = {bg = "#f5e9e3"}, DiagnosticVirtualTextWarn = {bg = "#f6ebdd"}, DiagnosticVirtualTextInfo = {bg = "#eaeae5"}, DiagnosticVirtualTextHint = {bg = "#efe8e6"}, DiagnosticSignErrorCul = {fg = "love", bg = "highlight_low"}, DiagnosticSignWarnCul = {fg = "gold", bg = "highlight_low"}, DiagnosticSignInfoCul = {fg = "foam", bg = "highlight_low"}, DiagnosticSignHintCul = {fg = "iris", bg = "highlight_low"}, EndOfBuffer = {fg = "highlight_med"}, WinSeparator = {fg = "highlight_med"}, IblScope = {fg = "highlight_med"}, IblIndent = {fg = "highlight_low"}, CursorLine = {bg = "highlight_low"}, TelescopeSelectionCaret = {fg = "love", bg = "highlight_med"}, TelescopeMultiSelection = {fg = "text", bg = "highlight_high"}, TelescopeTitle = {fg = "base", bg = "love"}, TelescopePromptTitle = {fg = "base", bg = "pine"}, TelescopePreviewTitle = {fg = "base", bg = "iris"}, TelescopePromptNormal = {fg = "text", bg = "surface"}, TelescopePromptBorder = {fg = "surface", bg = "surface"}, CoqtailChecked = {bg = "#eaeae5"}, CoqtailSent = {bg = "#f2e9e1"}, QuickFixLine = {fg = "foam", bg = "#DCE3DF", inherit = false}, LuaLineDiffAdd = {fg = "#56949f", bg = "#faf4ed"}, LuaLineDiffChange = {fg = "#d7827e", bg = "#faf4ed"}, DiffAdd = {bg = "#bacfc4", inherit = false}, DiffDelete = {bg = "#dbb6b4", inherit = false}, GitSignsAdd = {fg = "#bacfc4"}, GitSignsAddCul = {fg = "#bacfc4", bg = "highlight_low"}, GitSignsChange = {fg = "#e6d2c1"}, GitSignsChangeCul = {fg = "#e6d2c1", bg = "highlight_low"}, GitSignsDelete = {fg = "#dbb6b4"}, GitSignsDeleteCul = {fg = "#dbb6b4", bg = "highlight_low"}, GitSignsStagedAdd = {fg = "#75b0bb"}, GitSignsStagedAddCul = {fg = "#75b0bb", bg = "highlight_low"}, GitSignsStagedChange = {fg = "#e8a655"}, GitSignsStagedChangeCul = {fg = "#e8a655", bg = "highlight_low"}, GitSignsStagedChangedelete = {fg = "#e8a655"}, GitSignsStagedChangedeleteCul = {fg = "#e8a655", bg = "highlight_low"}, GitSignsStagedDelete = {fg = "#c4a7e7"}, GitSignsStagedDeleteCul = {fg = "#c4a7e7", bg = "highlight_low"}, GitSignsStagedTopdelete = {fg = "#c4a7e7"}, GitSignsStagedTopdeleteCul = {fg = "#c4a7e7", bg = "highlight_low"}, DelimitedError = {fg = "love", bg = "#EDDAD8", inherit = false}, DelimitedWarn = {fg = "gold", bg = "#F7E4CB", inherit = false}, DelimitedInfo = {fg = "foam", bg = "#DCE3DF", inherit = false}, DelimitedHint = {fg = "iris", bg = "#E7DEE1", inherit = false}, CopilotSuggestion = {fg = "highlight_high"}, TreesitterContext = {bg = "#f3ede8"}}})
  return vim.cmd("colorscheme rose-pine-dawn")
end
local function _8_()
  require("ibl").setup({indent = {char = "\226\148\130"}, scope = {show_end = false, show_start = false}})
  local ibl_visual_hide = vim.api.nvim_create_augroup("ibl_visual_hide", {clear = true})
  _G.vim.api.nvim_create_autocmd("ModeChanged", {group = ibl_visual_hide, pattern = "[vV\22]*:*", command = "IBLEnable", desc = "Enable IBL in non-Visual mode"})
  return _G.vim.api.nvim_create_autocmd("ModeChanged", {group = ibl_visual_hide, pattern = "*:[vV\22]*", command = "IBLDisable", desc = "Disable IBL in non-Visual mode"})
end
return {{"rose-pine/neovim", priority = 1000, main = "rose-pine", config = _7_, lazy = false}, {"lukas-reineke/indent-blankline.nvim", main = "ibl", dependencies = {"rose-pine/neovim"}, config = _8_}, {"norcalli/nvim-colorizer.lua", opts = {"*", css = {css = true}}}, {"nvim-lualine/lualine.nvim", opts = {options = {component_separators = {left = "\226\149\178", right = "\226\149\177"}, section_separators = {left = "\238\130\184", right = "\238\130\186"}}}}, {"nvim-tree/nvim-web-devicons", dependencies = {"rose-pine/neovim"}, opts = {override_by_extension = {v = {icon = "\239\134\157", color = "#dba25c", name = "Coq"}}}}, {"romainl/vim-cool"}, {"MunifTanjim/nui.nvim"}, {"stevearc/dressing.nvim"}, {"https://github.com/ellisonleao/gruvbox.nvim"}}
