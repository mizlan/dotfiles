; sql for rapper
((quoted_string
   ((quoted_string_content)
    @injection.content
    (#set! injection.language "sql")
    (#set! injection.include-children)
    )) @_q (#match? @_q "^\\\{sql\\\|"))
