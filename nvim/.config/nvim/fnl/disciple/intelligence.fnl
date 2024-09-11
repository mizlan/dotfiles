(import-macros {: au : req : map} :disciple.macros)

(vim.filetype.add {:extension {:typ :typst
                               :v :coq
                               :kk :koka
                               :rkt :racket
                               :pl :prolog
                               :mly :menhir}
                   :filename {:yabairc :sh :bordersrc :sh}})

;; Shortcut to set clipboard
(map :n :<Leader>sc+ #(set vim.opt.clipboard :unnamedplus))

(au :LspAttach
    {:group (vim.api.nvim_create_augroup :UserLspConfig {})
     :callback (fn [ev]
                 (let [opts {:noremap true :silent true :buffer ev.buf}
                       err vim.diagnostic.severity.ERROR
                       d (require :delimited)]
                   (map :n "[d" (. d :goto_prev) opts)
                   (map :n "]d" (. d :goto_next) opts)
                   (map :n "[D" #((. d :goto_prev) {:severity err}) opts)
                   (map :n "]D" #((. d :goto_next) {:severity err}) opts)
                   (map :n :gd vim.lsp.buf.definition opts)
                   (map :n :K vim.lsp.buf.hover opts)
                   (map :n :<Leader>rn vim.lsp.buf.rename opts)
                   (map :n :<Leader>gr vim.lsp.buf.references opts)
                   (map :n :<Leader>ca vim.lsp.buf.code_action opts)
                   (map :n :<Leader>wsl
                        #(print (vim.inspect (vim.lsp.buf.list_workspace_folders)))
                        opts)
                   ;; TODO merge with bufopts table
                   (map :n :<Leader>D vim.lsp.buf.type_definition opts)
                   (map :n :<Leader>gs vim.lsp.buf.signature_help opts)
                   (map :n :gi vim.lsp.buf.implementation opts)
                   (map :n :gD vim.lsp.buf.declaration opts)))})

[;; Syntax support and highlighting for Fennel
 {1 :jaawerth/fennel.vim}
 ;; Git client
 {1 :tpope/vim-fugitive}
 {1 :NMAC427/guess-indent.nvim :opts {}}
 {1 :lewis6991/gitsigns.nvim
  :opts {:culhl true
         :on_attach (fn []
                      (let [gs (require :gitsigns)]
                        (map :n :<Leader>sh gs.stage_hunk {:desc "Stage hunk"})
                        (map :n :<Leader>rh gs.reset_hunk {:desc "Reset hunk"})
                        (map :n "]h" gs.next_hunk {:desc "Next hunk"})
                        (map :n "[h" gs.prev_hunk {:desc "Prev hunk"})))}}
 {1 :chrisgrieser/nvim-various-textobjs
  :event :UIEnter
  :opts {:useDefaultKeymaps true}}
 {1 :nvim-treesitter/nvim-treesitter-textobjects}
 {1 :nvim-treesitter/nvim-treesitter
  :lazy false
  :dependencies [:nvim-treesitter/nvim-treesitter-textobjects]
  :main :nvim-treesitter.configs
  :opts {:ensure_installed [:c
                            :cpp
                            :python
                            :lua
                            :fennel
                            :ocaml
                            :haskell
                            :perl
                            :gitcommit
                            :java
                            :javascript
                            :prolog
                            :typescript]
         :highlight {:enable true}
         :sync_install true
         :textobjects {:select {:enable true
                                :lookahead true
                                :keymaps {:af "@function.outer"
                                          :if "@function.inner"
                                          :ac "@class.outer"
                                          :ic "@class.inner"
                                          :aa "@parameter.outer"
                                          :ia "@parameter.inner"}}}}}
 ;; Tidy goto_{prev,next}
 {:dir "~/Code/delimited.nvim"}
 ;; Add-on to lspconfig's lua_ls configuration
 {1 :Bilal2453/luvit-meta :lazy true}
 {1 :folke/lazydev.nvim
  :ft :lua
  :opts {:library {:path :luvit-meta/library :words ["vim%.uv"]}}}
 {1 :williamboman/mason.nvim :opts true}
 {1 :williamboman/mason-lspconfig.nvim
  ;; The use of :dependencies ensures that the plugin setup order is
  ;; 1. mason.nvim 2. mason-lspconfig.nvim 3. nvim-lspconfig
  :dependencies [:williamboman/mason.nvim]
  :opts {:ensure_installed [:lua_ls
                            :fennel_language_server
                            :clangd
                            :pyright
                            :ruff]
         :handlers {1 (fn [server-name]
                        ((. (require :lspconfig) server-name :setup) {}))
                    :fennel_language_server (fn []
                                              (let [lspconfig (require :lspconfig)]
                                                (lspconfig.fennel_language_server.setup {:filetypes [:fennel]
                                                                                         :root_dir (lspconfig.util.root_pattern :fnl
                                                                                                                                :lua)
                                                                                         :single_file_support true
                                                                                         :settings {:fennel {:diagnostics {:globals [:vim
                                                                                                                                     :jit
                                                                                                                                     :comment]}
                                                                                                             :workspace {:library (vim.api.nvim_list_runtime_paths)}}}})))}}}
 {1 :neovim/nvim-lspconfig
  :dependencies [:williamboman/mason.nvim :williamboman/mason-lspconfig.nvim]}
 {1 :hrsh7th/nvim-cmp
  :config (fn []
            (let [cmp (require :cmp)]
              (cmp.setup {:mapping (cmp.mapping.preset.insert {:<C-b> (cmp.mapping.scroll_docs -1)
                                                               :<C-f> (cmp.mapping.scroll_docs 1)
                                                               :<C-Space> (cmp.mapping.complete)
                                                               :<C-e> (cmp.mapping.abort)
                                                               :<C-y> (cmp.mapping.confirm {:select true})})
                          :sources (cmp.config.sources [{:name :nvim_lsp}
                                                        {:name :nvim_lsp_signature_help}
                                                        {:name :buffer
                                                         :option {:get_bufnrs vim.api.nvim_list_bufs}}])
                          :sorting {:comparators [cmp.config.compare.offset
                                                  cmp.config.compare.exact
                                                  cmp.config.compare.score
                                                  cmp.config.compare.score
                                                  (. (require :cmp-under-comparator)
                                                     :under)
                                                  cmp.config.compare.kind
                                                  cmp.config.compare.sort_text
                                                  cmp.config.compare.length
                                                  cmp.config.compare.order]}})))}
 {1 :hrsh7th/cmp-nvim-lsp}
 {1 :hrsh7th/cmp-nvim-lsp-signature-help}
 {1 :hrsh7th/cmp-buffer}
 {1 :lukas-reineke/cmp-under-comparator}
 {1 :stevearc/conform.nvim
  :opts {:formatters_by_ft {:lua [:stylua]
                            :fennel [:fnlfmt]
                            :cpp [:clang-format]
                            :json [:jq]
                            :javascript [:prettierd]
                            :javascriptreact [:prettierd]
                            :typescript [:prettierd]
                            :typescriptreact [:prettierd]
                            :python [:ruff_format]}}
  :init (fn []
          (map [:n :v] :<Leader>f<Space>
               #(req :conform :format {:async true :lsp_fallback true})
               {:noremap true :silent true}))}
 {1 :kylechui/nvim-surround :event :VeryLazy :opts {:indent_lines false}}
 {1 :JoosepAlviste/nvim-ts-context-commentstring}
 {1 :numToStr/Comment.nvim
  :config #(let [i (require :ts_context_commentstring.integrations.comment_nvim)]
             {:pre_hook (i.create_pre_hook)})}
 {1 :stevearc/aerial.nvim :opts {}}
 {1 :bfredl/nvim-miniyank
  :init (fn []
          (map :n :p "<Plug>(miniyank-autoput)")
          (map :n :P "<Plug>(miniyank-autoPut)")
          (map :n :<Leader>n "<Plug>(miniyank-cycle)")
          (map :n :<Leader>N "<Plug>(miniyank-cycleback)")
          (map :n :<Leader><Space>c "<Plug>(miniyank-tochar)")
          (map :n :<Leader><Space>l "<Plug>(miniyank-toline)")
          (map :n :<Leader><Space>b "<Plug>(miniyank-toblock)"))}]

