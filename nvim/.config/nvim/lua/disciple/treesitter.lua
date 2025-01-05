-- [nfnl] Compiled from fnl/disciple/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(opts)
  require("nvim-treesitter.configs").setup(opts.opts)
  local cfgs = require("nvim-treesitter.parsers").get_parser_configs()
  cfgs.sql = {install_info = {url = "~/Repositories/tree-sitter-sql", files = {"src/parser.c", "src/scanner.c"}, branch = "main", requires_generate_from_grammar = "true", generate_requires_npm = false}, filetype = "sql"}
  cfgs.ocaml_type = {filetype = "ocamltype", install_info = {url = "https://github.com/tree-sitter/tree-sitter-ocaml", files = {"src/parser.c", "src/scanner.c"}, location = "grammars/type"}, maintainers = {"@undu"}}
  return nil
end
return {{"nvim-treesitter/nvim-treesitter-textobjects"}, {"nvim-treesitter/nvim-treesitter", dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"}, main = "nvim-treesitter.configs", opts = {ensure_installed = {"c", "cpp", "css", "python", "lua", "fennel", "ocaml", "haskell", "perl", "gitcommit", "go", "java", "javascript", "prolog", "svelte", "typescript", "tsx"}, highlight = {enable = true}, sync_install = true, textobjects = {select = {enable = true, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner", aa = "@parameter.outer", ia = "@parameter.inner"}}}}, config = _1_, lazy = false}}
