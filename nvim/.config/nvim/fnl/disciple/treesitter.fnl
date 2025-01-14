(import-macros {: req} :disciple.macros)

[{1 :nvim-treesitter/nvim-treesitter-textobjects}
 {1 :nvim-treesitter/nvim-treesitter
  ; treesitter slow :(
  :lazy false
  :dependencies [:nvim-treesitter/nvim-treesitter-textobjects]
  :main :nvim-treesitter.configs
  :opts {:ensure_installed [:c
                            :cpp
                            :css
                            :python
                            :lua
                            :fennel
                            :ocaml
                            :haskell
                            :perl
                            :gitcommit
                            :go
                            :java
                            :javascript
                            :prolog
                            :svelte
                            :typescript
                            :tsx]
         :highlight {:enable true}
         :sync_install true
         :textobjects {:select {:enable true
                                :lookahead true
                                :keymaps {:af "@function.outer"
                                          :if "@function.inner"
                                          :ac "@class.outer"
                                          :ic "@class.inner"
                                          :aa "@parameter.outer"
                                          :ia "@parameter.inner"}}}}
  :config (fn [opts]
            (req :nvim-treesitter.configs :setup opts.opts)
            (let [cfgs (req :nvim-treesitter.parsers :get_parser_configs)]
              (set cfgs.sql {:install_info {:url "~/Repositories/tree-sitter-sql"
                                            :files [:src/parser.c
                                                    :src/scanner.c]
                                            :branch :main
                                            :generate_requires_npm false
                                            :requires_generate_from_grammar :true}
                             :filetype :sql})
              (set cfgs.ocaml_type
                   {:filetype :ocamltype
                    :install_info {:url "https://github.com/tree-sitter/tree-sitter-ocaml"
                                   :files [:src/parser.c :src/scanner.c]
                                   :location :grammars/type}
                    :maintainers ["@undu"]})))}
 {1 :nvim-treesitter/nvim-treesitter-context :opts {}}]
