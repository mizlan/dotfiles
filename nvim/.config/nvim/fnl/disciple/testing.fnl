(import-macros {: map} :disciple.macros)

(map :t :<Esc> "<C-\\><C-n>")

;; For my interview
(fn switch-test-app-file []
  "Switch between an application file and its corresponding test in Python"
  (let [fname (vim.fn.expand "%:t")
        dir (vim.fn.expand "%:h")]
    (if (vim.startswith fname :test_)
        (vim.cmd (.. "e " dir "/" (fname:sub 6)))
        (vim.cmd (.. "e " dir :/test_ fname)))))

(map :n :<Leader>tn switch-test-app-file)

[{1 :vim-test/vim-test
  :init (fn []
          (map :n :<Leader>t<Space> :<Cmd>TestFile<CR>)
          (map :n :<Leader>gt :<Cmd>TestVisit<CR>)
          (map :n :<Leader>tt :<Cmd>TestLast<CR>))
  :config (fn []
            (tset vim.g "test#strategy" :toggleterm))}
 {1 :akinsho/toggleterm.nvim
  :version "*"
  :opts {:open_mapping ["<C-\\>"]
         :on_create (fn []
                      (set vim.opt.signcolumn :no)
                      (set vim.opt.cursorline false)
                      (set vim.wo.foldcolumn :2)
                      (set vim.wo.statusline " "))
         :highlights {:StatusLine {:guibg :#f4ede8}}
         :insert_mappings false
         :terminal_mappings false
         :shade_terminals false}}]

