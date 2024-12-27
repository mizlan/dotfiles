; sql for rapper
((quoted_string
   ((quoted_string_content)
    @injection.content
    (#set! injection.language "ocaml"))) @_q (#match? @_q "^\\\{sql\\\|"))
