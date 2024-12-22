(import-macros {: req : map} :disciple.macros)

[{1 :echasnovski/mini.nvim
  :version "*"
  :config (fn []
            (req :mini.files :setup
                 {:mappings {:close :<Esc> :go_in_plus :<CR>}})
            (req :mini.ai :setup)
            (req :mini.bufremove :setup))
  :init (fn []
          (map :n "-"
               #(req :mini.files :open
                     (if (not= vim.v.count 0) nil (vim.api.nvim_buf_get_name 0)))
               {:desc "Switch buffer"})
          (map :n :<Leader>bd #(req :mini.bufremove :unshow)
               {:desc "Remove buffer"}))}]
