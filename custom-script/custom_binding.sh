#!/bin/bash
# Adding keybinding for bash

LIST_CUSTOM_PRINT_USAGE+=("custom_print_usage_binding")
LIST_CUSTOM_PRINT_HELP+=("custom_print_help_binding")
LIST_CUSTOM_PARSE_ARGS+=("custom_parse_args_binding")
LIST_CUSTUM_FUNCTION+=("custom_function_binding")

function custom_print_usage_binding()
{
    cat << EOF

Custom parameters for '${BASH_SOURCE[0]}':
[--enable-binding]
EOF
}

function custom_print_help_binding()
{
    cat << EOF

Custom options for '${BASH_SOURCE[0]}':
  --enable-binding           Adding keybinding for bash
EOF
}

function custom_parse_args_binding()
{
    case ${PARAM} in
        *-enable-binding)
            ENABLE_BINDING=1
            ;;
        -*)
            return -1
            ;;
    esac
}

function custom_function_binding()
{
    ENABLE_BINDING=${ENABLE_BINDING:-"0"}

    if [ $ENABLE_BINDING -eq 1 ]; then
        echo "+ Adding keybinding for bash"
        cat << EOF > $IMG_DIR/etc/profile.d/binding.sh
#!/bin/sh
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

stty werase undef
bind '"\C-w": backward-kill-word'

alias vim=vi
EOF
        chmod +x $IMG_DIR/etc/profile.d/binding.sh
    fi
}