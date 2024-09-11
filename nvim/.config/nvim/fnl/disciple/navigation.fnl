(import-macros {: req} :disciple.macros)

(set vim.opt.undofile true)

[{1 :nvim-telescope/telescope.nvim
  :lazy false
  :init (fn []
          (vim.keymap.set :n "<Leader>," "<Cmd>Telescope buffers<CR>"
                          {:desc "Switch buffer"})
          (vim.keymap.set :n :<Leader>ff "<Cmd>Telescope find_files<CR>"
                          {:desc "Find file"})
          (vim.keymap.set :n :<Leader>fo "<Cmd>Telescope oldfiles<CR>"
                          {:desc "Find old file"}))
  :opts {:defaults {:history {:cycle_wrap true}
                    :prompt_prefix "   "
                    :selection_caret "  "
                    :entry_prefix "  "}
         :pickers {:buffers {:previewer false :theme :ivy}
                   :oldfiles {:previewer false :theme :ivy}
                   :find_files {:previewer false
                                :theme :ivy
                                :hidden true
                                :find_command [:rg
                                               :--files
                                               :--glob
                                               :!.git
                                               :--glob
                                               :!venv
                                               :--hidden]}}
         :extensions {:fzf {:fuzzy true
                            :override_generic_sorter true
                            :override_file_sorter true}}}
  :dependencies ["https://github.com/nvim-lua/plenary.nvim"]}
 {1 :nvim-telescope/telescope-fzf-native.nvim
  :build :make
  :dependencies [:nvim-telescope/telescope.nvim]
  :config (fn []
            (req :telescope :load_extension :fzf))}
 {1 "https://github.com/stevearc/oil.nvim"
  :init (fn []
          (vim.keymap.set :n "-" (. (require :oil) :open)
                          {:desc "Open directory"}))
  :opts true}
 {1 :folke/which-key.nvim :event :VeryLazy :opts {}}
 {1 :ggandor/leap.nvim :config #(req :leap :create_default_mappings)}]

