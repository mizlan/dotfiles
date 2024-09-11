(import-macros {: map} :disciple.macros)

(fn raw-indent []
  (vim.cmd "execute \"normal i\\<CR>}\\<Esc>O\t\""))
; (map :i :<CR> raw-indent {:noremap true})

[]
