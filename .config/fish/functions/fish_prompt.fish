function fish_prompt --description 'my prompt'
    #Save the return status of the previous command
    set -l last_pipestatus $pipestatus

    set -l pipestatus_string (__fish_print_pipestatus "[" "] " "|" (set_color $fish_color_status) \
                              (set_color --bold $fish_color_status) $last_pipestatus)

    printf '%s%s %s%s%s \f\r$ ' (set_color $fish_color_cwd) $PWD $pipestatus_string  (set_color normal)
end
