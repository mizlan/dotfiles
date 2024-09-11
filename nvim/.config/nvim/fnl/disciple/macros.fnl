;; The following comment indicates to the Fennel compiler
;; that this file is special and contains macros used in
;; other files
;;
;; [nfnl-macro]

(fn req [module method ...]
  "Call a module's method"
  `((. (require ,module) ,method) ,...))

(fn au [...]
  "A shorthand for vim.api.nvim_create_autocmd"
  `(_G.vim.api.nvim_create_autocmd ,...))

(fn map [...]
  "A shorthand for vim.keymap.set"
  `(_G.vim.keymap.set ,...))

{: req : au : map}
