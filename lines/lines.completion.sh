_lines_complete() {
    local cur prev words cword
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}    # Current word being typed by user
    prev=${COMP_WORDS[COMP_CWORD-1]} # Previous word typed by user
    cword=${COMP_CWORD}              # Index of current word

    case $cword in
        1)
            compopt +o default +o bashdefault 2>/dev/null
            ;;
        2)
            compopt +o default +o bashdefault 2>/dev/null
            ;;
        3)
            compopt -o default -o bashdefault 2>/dev/null
            ;;
        *)
            ;;
    esac
}

# Register the function for the command "lines"
complete -F _lines_complete lines
