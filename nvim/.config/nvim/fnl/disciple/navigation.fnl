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
                          {:desc "Find old file"})
          (vim.keymap.set :n :<Leader>sp "<Cmd>Telescope live_grep<CR>"
                          {:desc "Search for string"})
          (vim.keymap.set :n :<Leader>fp
                          "<Cmd>Telescope find_files cwd=~/.config/nvim/fnl<CR>"
                          {:desc "Find Neovim configuration file"})
          (vim.keymap.set :n :<Leader>fP
                          "<Cmd>Telescope find_files cwd=~/.config<CR>"
                          {:desc "Find configuration file"})
          (vim.keymap.set :n :<Leader>ss
                          "<Cmd>Telescope lsp_document_symbols<CR>"
                          {:desc "Find LSP symbol"})
          (vim.keymap.set :n "<Leader>'" "<Cmd>Telescope resume<CR>"
                          {:desc "Resume Telescope"}))
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
                                               :--follow
                                               :--glob
                                               :!.git
                                               :--glob
                                               :!venv
                                               :--glob
                                               :!_build
                                               :--glob
                                               :!_opam
                                               :--glob
                                               :!dist-newstyle
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
 {1 :folke/which-key.nvim :event :VeryLazy :opts {}}
 {1 :ggandor/leap.nvim :config #(req :leap :create_default_mappings)}
 {1 :stevearc/quicker.nvim :opts true}
 {1 :kevinhwang91/nvim-bqf :opts {:preview {:winblend 0}}}]
