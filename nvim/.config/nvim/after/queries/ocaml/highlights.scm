; inherits: ocaml

; TODO broken highlighting
((type_variable) @variable (#eq? @variable "'a") (#set! conceal "α"))
((type_variable) @variable (#eq? @variable "'b") (#set! conceal "β"))
((type_variable) @variable (#eq? @variable "'c") (#set! conceal "γ"))
