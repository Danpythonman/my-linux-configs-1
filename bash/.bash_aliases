alias cd-semester="cd '/home/daniel/York/ENG Y5/Winter Term/'"

alias cd-master="cd '/home/daniel/York/Masters/'"

alias cd-masters="cd '/home/daniel/York/Masters/'"

alias shh='systemctl suspend'

alias tlatoolbox='/opt/tlatoolbox/toolbox/toolbox'

dateiso() {
    date -d "$*" +%Y-%m-%dT%H:%M:%S%z
}

datehr() {
    date -d "$*"
}

alias nbg="nautilus . &> /dev/null &"

alias nvidia-reload='sudo rmmod nvidia_uvm && sleep 1 && sudo modprobe nvidia_uvm'

alias thun='thunar >/dev/null 2>&1 &'

alias c='clear'

taskr() {
    ssh pi5bts -- "task $@"
}

tasky() {
    local desc="$1"
    local project="$2"
    local date="$3"
    local priority="$4"

    if [[ -z "$desc" || -z "$project" || -z "$date" ]]; then
        echo "usage: tasky \"DESCRIPTION\" PROJECT DATE|eod [H|M|L]"
        return 1
    fi

    # Validate priority if provided
    if [[ -n "$priority" && ! "$priority" =~ ^[HML]$ ]]; then
        echo "priority must be one of: H, M, L"
        return 1
    fi

    local due_arg
    if [[ "$date" == "eod" ]]; then
        due_arg="due:eod"
    else
        due_arg="due:$(dateiso "$date")"
    fi

    if [[ -n "$priority" ]]; then
        taskr add "$desc" project:"$project" "$due_arg" priority:"$priority"
    else
        taskr add "$desc" project:"$project" "$due_arg"
    fi
}

alias rodin='/opt/rodin/rodin >/dev/null 2>&1 &'

alias activate-ml-env='conda activate ml_cuda12.2'

alias py='python'

alias p='python'

pdf() {
    if [ "$#" -eq 0 ]; then
        echo "usage: pdf <file.pdf>" >&2
        return 1
    fi

    # Join all arguments into a single path
    local path="$*"

    # Expand ~
    path="${path/#\~/$HOME}"

    # Launch evince (reuse running instance)
    evince "$path" >/dev/null 2>&1 &
}

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -out'

cb() {
    if [[ "$1" != "from" || "$3" != "to" ]]; then
        echo "Usage: cb from [clip|tmux|<ssh>:<path>] to [clip|tmux|<ssh>:<path>]"
        return 1
    fi

    local src="$2" dst="$4"
    local content

    # Get content
    if [[ "$src" == "clip" ]]; then
        content=$(xclip -selection clipboard -out)
    elif [[ "$src" == "tmux" ]]; then
        content=$(tmux show-buffer)
    elif [[ "$src" == *":"* ]]; then
        local ssh_host="${src%%:*}"
        local ssh_path="${src#*:}"
        [[ -z "$ssh_path" ]] && ssh_path="/tmp/cb"
        content=$(ssh "$ssh_host" "cat '$ssh_path'")
    else
        content=$(cat "$src")
    fi

    # Send content
    if [[ "$dst" == "clip" ]]; then
        printf '%s' "$content" | xclip -selection clipboard -in
    elif [[ "$dst" == "tmux" ]]; then
        printf '%s' "$content" | tmux load-buffer -
    elif [[ "$dst" == *":"* ]]; then
        local ssh_host="${dst%%:*}"
        local ssh_path="${dst#*:}"
        [[ -z "$ssh_path" ]] && ssh_path="/tmp/cb"
        printf '%s' "$content" | ssh "$ssh_host" "cat > '$ssh_path'"
    else
        printf '%s' "$content" > "$dst"
    fi
}
