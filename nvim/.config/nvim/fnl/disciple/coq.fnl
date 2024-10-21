(import-macros {: map} :disciple.macros)
[{1 :whonore/Coqtail
  :init (fn []
          (set vim.g.loaded_coqtail 1)
          (tset vim.g "coqtail#supported" 0))}
 {1 :tomtomjhj/vscoq.nvim
  :init (fn []
          (map :n :<C-c><C-j> "<Cmd>VsCoq stepForward<CR>")
          (map :n :<C-c><C-k> "<Cmd>VsCoq stepBackward<CR>")
          (map :n :<C-c><C-l> "<Cmd>VsCoq interpretToPoint<CR>")
          (map :n :<C-c><C-e> "<Cmd>VsCoq jumpToEnd<CR>")
          (map :n :<C-c><C-g> "<Cmd>VsCoq interpretToEnd<CR>"))
  :opts {}}]

