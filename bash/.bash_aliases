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
    ssh gcp -- "task $@"
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
