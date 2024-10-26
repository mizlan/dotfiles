(import-macros {: req : au} :disciple.macros)

;; Use the Cursor highlight group for the cursor,
;; which has been disabled by default
; (set vim.opt.guicursor
;      "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor")
(set vim.opt.guicursor "a:hor20-StatusLineTerm")

;; Don't display mode indicators, our cursor communicates that to us
(set vim.opt.showmode false)

;; Display the cursorline
(set vim.opt.cursorline true)

;; Simple statusline
(set vim.opt.statusline " %t")

;; Only display a global statusline, not one per window
(set vim.opt.laststatus 3)

;; Display line numbers
(set vim.opt.number true)

;; Don't wrap lines
(set vim.opt.wrap false)

;; Set background to light to allow plugins
;; to understand we're using a light background
;; (especially nvim-web-devicons)
(set vim.opt.background :light)

(au :TextYankPost
    {:group (vim.api.nvim_create_augroup :highlight_yank {})
     :desc "Highlight on yank"
     :callback (fn []
                 (vim.highlight.on_yank {:higroup :Todo :timeout 200}))})

;; Neovide configuration
(au [:UIEnter]
    {:callback (fn []
                 (when vim.g.neovide
                   (set vim.g.neovide_input_macos_option_key_is_meta :only_left)
                   (set vim.opt.linespace 5)
                   (set vim.g.neovide_floating_shadow true)
                   (set vim.g.neovide_floating_shadow true)
                   (set vim.g.neovide_floating_z_height 5)
                   (set vim.g.neovide_light_angle_degrees 45)
                   (set vim.g.neovide_light_radius 60)
                   (set vim.g.neovide_cursor_animate_command_line false)
                   ;; (set vim.g.neovide_cursor_vfx_mode :railgun)
                   (set vim.g.neovide_cursor_vfx_opacity 300.0)
                   (set vim.g.neovide_cursor_vfx_particle_lifetime 1.5)
                   (set vim.g.neovide_cursor_vfx_particle_speed 20.0)
                   (set vim.g.neovide_cursor_vfx_particle_density 45.0)
                   (set vim.g.neovide_cursor_vfx_particle_phase 12.0)
                   (set vim.g.neovide_cursor_vfx_particle_curl 0.8)
                   (vim.keymap.set :n :<C-+>
                                   (fn []
                                     (set vim.g.neovide_scale_factor
                                          (+ vim.g.neovide_scale_factor 0.1))
                                     (os.execute :/Users/ml/.config/yabai/microshift.sh)))
                   (vim.keymap.set :n :<C-->
                                   (fn []
                                     (set vim.g.neovide_scale_factor
                                          (- vim.g.neovide_scale_factor 0.1))
                                     (os.execute :/Users/ml/.config/yabai/microshift.sh)))
                   (vim.keymap.set :n :<C-0>
                                   (fn []
                                     (set vim.g.neovide_scale_factor 1)
                                     (os.execute :/Users/ml/.config/yabai/microshift.sh)))))})

[{1 :rose-pine/neovim
  :lazy false
  :priority 1000
  :main :rose-pine
  :config (fn []
            (req :rose-pine :setup
                 {:disable_italics true
                  :highlight_groups {:LineNr {:fg :highlight_high}
                                     :CursorLineNr {:fg :muted
                                                    :bg :highlight_low
                                                    :inherit false}
                                     :CursorLineSign {:bg :highlight_low}
                                     :StatusLine {:fg :muted
                                                  :bg :highlight_low}
                                     ;; :MatchParen {:bg "#f6ebdd" :inherit false}
                                     :DiagnosticVirtualTextError {:bg "#f5e9e3"}
                                     :DiagnosticVirtualTextWarn {:bg "#f6ebdd"}
                                     :DiagnosticVirtualTextInfo {:bg "#eaeae5"}
                                     :DiagnosticVirtualTextHint {:bg "#efe8e6"}
                                     :DiagnosticSignErrorCul {:fg :love
                                                              :bg :highlight_low}
                                     :DiagnosticSignWarnCul {:fg :gold
                                                             :bg :highlight_low}
                                     :DiagnosticSignInfoCul {:fg :foam
                                                             :bg :highlight_low}
                                     :DiagnosticSignHintCul {:fg :iris
                                                             :bg :highlight_low}
                                     :EndOfBuffer {:fg :highlight_med}
                                     :WinSeparator {:fg :highlight_med}
                                     :IblScope {:fg :highlight_med}
                                     :IblIndent {:fg :highlight_low}
                                     :CursorLine {:bg :highlight_low}
                                     :TelescopeSelectionCaret {:fg :love
                                                               :bg :highlight_med}
                                     :TelescopeMultiSelection {:fg :text
                                                               :bg :highlight_high}
                                     :TelescopeTitle {:fg :base :bg :love}
                                     :TelescopePromptTitle {:fg :base
                                                            :bg :pine}
                                     :TelescopePreviewTitle {:fg :base
                                                             :bg :iris}
                                     :TelescopePromptNormal {:fg :text
                                                             :bg :surface}
                                     :TelescopePromptBorder {:fg :surface
                                                             :bg :surface}
                                     :CoqtailChecked {:bg "#eaeae5"}
                                     :CoqtailSent {:bg "#f2e9e1"}
                                     :QuickFixLine {:fg :foam
                                                    :bg "#DCE3DF"
                                                    :inherit false}
                                     :LuaLineDiffAdd {:fg "#56949f"
                                                      :bg "#faf4ed"}
                                     :LuaLineDiffChange {:fg "#d7827e"
                                                         :bg "#faf4ed"}
                                     :DiffAdd {:bg "#bacfc4" :inherit false}
                                     :DiffDelete {:bg "#dbb6b4" :inherit false}
                                     :GitSignsAdd {:fg "#bacfc4"}
                                     :GitSignsAddCul {:fg "#bacfc4"
                                                      :bg :highlight_low}
                                     :GitSignsChange {:fg "#e6d2c1"}
                                     :GitSignsChangeCul {:fg "#e6d2c1"
                                                         :bg :highlight_low}
                                     :GitSignsDelete {:fg "#dbb6b4"}
                                     :GitSignsDeleteCul {:fg "#dbb6b4"
                                                         :bg :highlight_low}
                                     :DelimitedError {:fg :love
                                                      :bg "#EDDAD8"
                                                      :inherit false}
                                     :DelimitedWarn {:fg :gold
                                                     :bg "#F7E4CB"
                                                     :inherit false}
                                     :DelimitedInfo {:fg :foam
                                                     :bg "#DCE3DF"
                                                     :inherit false}
                                     :DelimitedHint {:fg :iris
                                                     :bg "#E7DEE1"
                                                     :inherit false}
                                     :CopilotSuggestion {:fg :highlight_high}
                                     :TreesitterContext {:bg "#f3ede8"}}})
            (vim.cmd "colorscheme rose-pine-dawn"))}
 {1 :luukvbaal/statuscol.nvim
  :config (fn []
            (req :statuscol :setup
                 {:ft_ignore [:aerial]
                  :bt_ignore [:terminal]
                  :segments [{:text [" "]}
                             ;; This pattern should capture the different types
                             ;; of signs resulting from diagnostics
                             {:sign {:namespace [:.*diagnostic/signs]
                                     :colwidth 2
                                     :auto false}}
                             {:text [" "]}
                             {:text [(. (require :statuscol.builtin) :lnumfunc)]
                              :click "v:lua.ScLa"}
                             {:text [" "]}
                             {:sign {:namespace [:gitsigns]
                                     :maxwidth 2
                                     :colwidth 1
                                     :auto false}}]})
            ;; For each line with a diagnostic, only display the diagnostic
            ;; with the highest severity (e.g., if a line had both a warning
            ;; and an error, only the symbol for an error would be shown
            (let [severe-ns (vim.api.nvim_create_namespace :severe-diagnostics)
                  max-diag (fn [callback]
                             (fn [_ bufnr diagnostics opts]
                               (let [line->diag {}]
                                 (each [_ d (ipairs diagnostics)]
                                   (let [m (. line->diag d.lnum)]
                                     (when (or (not m)
                                               (< d.severity m.severity))
                                       (tset line->diag d.lnum d))))
                                 (callback severe-ns bufnr
                                           (vim.tbl_values line->diag) opts))))
                  signs-handler vim.diagnostic.handlers.signs]
              (set vim.diagnostic.handlers.signs
                   (vim.tbl_extend :force signs-handler
                                   {:show (max-diag signs-handler.show)
                                    :hide (fn [_ bufnr]
                                            (signs-handler.hide severe-ns bufnr))})))
            ;; Display diagnostics subtly: no virtual text, no underlines
            ;; or squigglies; only signs
            (vim.diagnostic.config {:underline false
                                    :virtual_text false
                                    :signs {:text {vim.diagnostic.severity.ERROR ""
                                                   vim.diagnostic.severity.WARN ""
                                                   vim.diagnostic.severity.HINT ""
                                                   vim.diagnostic.severity.INFO ""}
                                            ;; Display signs on the cursor line with their background
                                            ;; matching CursorLineSign
                                            :cursorlinehl {vim.diagnostic.severity.ERROR :DiagnosticSignErrorCul
                                                           vim.diagnostic.severity.WARN :DiagnosticSignWarnCul
                                                           vim.diagnostic.severity.HINT :DiagnosticSignHintCul
                                                           vim.diagnostic.severity.INFO :DiagnosticSignInfoCul}}
                                    :float {:header ""
                                            :max_width (math.min (math.floor (* vim.o.columns
                                                                                0.7))
                                                                 100)
                                            :max_height (math.min (math.floor (* vim.o.lines
                                                                                 0.3))
                                                                  30)}}))}
 {1 :lukas-reineke/indent-blankline.nvim
  :main :ibl
  ;; Load indent-blankline after colorscheme,
  ;; so IBLIndent and IBLScope highlights are applied
  :dependencies [:rose-pine/neovim]
  :config (fn []
            (req :ibl :setup
                 {:indent {:char "│"}
                  :scope {:show_start false :show_end false}})
            ;; HACK: hide indent lines in visual mode
            ;; ref: https://github.com/lukas-reineke/indent-blankline.nvim/issues/132#issuecomment-1781195298
            (let [ibl-visual-hide (vim.api.nvim_create_augroup :ibl_visual_hide
                                                               {:clear true})]
              (au :ModeChanged
                  {:group ibl-visual-hide
                   ;; visual → anything
                   :pattern "[vV\022]*:*"
                   :command :IBLEnable
                   :desc "Enable IBL in non-Visual mode"})
              (au :ModeChanged
                  {:group ibl-visual-hide
                   ;; anything → visual
                   :pattern "*:[vV\022]*"
                   :command :IBLDisable
                   :desc "Disable IBL in non-Visual mode"})))}
 {1 :norcalli/nvim-colorizer.lua
  :opts {1 "*"
         ;; Highlight rgb() and hsl() functions as well in CSS
         :css {:css true}}}
 ; {1 :nvim-lualine/lualine.nvim :opts {}}
 {1 :nvim-tree/nvim-web-devicons
  :dependencies [:rose-pine/neovim]
  :opts {:override_by_extension {:v {:icon "" :color "#dba25c" :name :Coq}}}}
 {1 :romainl/vim-cool}
 {1 :stevearc/dressing.nvim}]

