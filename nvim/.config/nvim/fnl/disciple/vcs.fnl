(import-macros {: map} :disciple.macros)

[;; Git client
 {1 :tpope/vim-fugitive
  :init (fn []
          (map :n :<Leader>gg :<Cmd>0Git<CR>))}
 {1 :lewis6991/gitsigns.nvim
  :opts {:culhl true
         :signs {:changedelete {:text "┇"}}
         :signs_staged {:changedelete {:text "┇"}}
         :on_attach (fn []
                      (let [gs (require :gitsigns)]
                        (map [:n :v] :<Leader>sh gs.stage_hunk
                             {:desc "Stage hunk"})
                        (map [:n :v] :<Leader>rh gs.reset_hunk
                             {:desc "Reset hunk"})
                        (map [:n :v] :<Leader>uh gs.undo_stage_hunk
                             {:desc "Undo stage hunk"})
                        (map [:n :v] :<Leader>sb gs.stage_buffer
                             {:desc "Stage buffer"})
                        (map :n "]h" gs.next_hunk {:desc "Next hunk"})
                        (map :n "[h" gs.prev_hunk {:desc "Prev hunk"})
                        (map :n :<Leader>phi gs.preview_hunk_inline
                             {:desc "Preview hunk inline"})))}}
 {1 :julienvincent/hunk.nvim :cmd [:DiffEditor] :opts {}}]
