alias cd-semester="cd '/home/daniel/York/ENG Y5/Winter Term/'"

alias cd-master="cd '/home/daniel/York/Masters/'"
alias cd-masters="cd '/home/daniel/York/Masters/'"
alias cd-eecs6444="cd '/home/daniel/York/Masters/EECS6444'"
alias cd-rxpx="cd '/home/daniel/York/Masters/RxPx'"

mastersdir=/home/daniel/York/Masters
eecs6444dir=/home/daniel/York/Masters/EECS6444
rxpxdir=/home/daniel/York/Masters/RxPx

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
alias dolph='dolphin . -stylesheet /home/daniel/my-linux-configs/dolphin/dolphin.qss >/dev/null 2>&1 &'

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

alias p='python'
alias py='python'

npdoc() {
    python -c "import numpy; print(numpy.info(numpy.$1))"
}

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
        echo "Usage: cb from [clip|cb|tmux|<ssh>:<path>] to [clip|cb|tmux|<ssh>:<path>]"
        return 1
    fi

    local src="$2" dst="$4"
    local content

    # Get content
    if [[ "$src" == "clip" || "$src" == "cb" ]]; then
        content=$(xclip -selection clipboard -out)
    elif [[ "$src" == "tmux" ]]; then
        content=$(tmux show-buffer)
    elif [[ "$src" == "-" ]]; then
        content=$(cat)
    elif [[ "$src" == *":"* ]]; then
        local ssh_host="${src%%:*}"
        local ssh_path="${src#*:}"
        [[ -z "$ssh_path" ]] && ssh_path="/tmp/cb"
        if [[ -z "$ssh_host" ]]; then
            content=$(cat "$ssh_path")
        else
            content=$(ssh "$ssh_host" "cat '$ssh_path'")
        fi
    else
        echo "cb: unrecognized source '$src'" >&2
        return 1
    fi

    # Send content
    if [[ "$dst" == "clip" || "$dst" == "cb" ]]; then
        printf '%s' "$content" | xclip -selection clipboard -in
    elif [[ "$dst" == "tmux" ]]; then
        printf '%s' "$content" | tmux load-buffer -
    elif [[ "$dst" == "-" ]]; then
        printf '%s' "$content"
    elif [[ "$dst" == *":"* ]]; then
        local ssh_host="${dst%%:*}"
        local ssh_path="${dst#*:}"
        [[ -z "$ssh_path" ]] && ssh_path="/tmp/cb"
        if [[ -z "$ssh_host" ]]; then
            printf '%s' "$content" > "$ssh_path"
        else
            printf '%s' "$content" | ssh "$ssh_host" "cat > '$ssh_path'"
        fi
    else
        echo "cb: unrecognized destination '$dst'" >&2
        return 1
    fi
}

resrename() {
  local file="$1" arg1="$2" arg2="$3"
  local ext="${file##*.}"
  local dir="$(dirname "$file")"
  local date="$(date -u +"%Y-%m-%d_%H-%M-%S-%3NZ")"
  mv "$file" "$dir/$arg1-$arg2-$date.$ext"
}

ziproot() {
    roots=$(unzip -Z1 "$1" | cut -d/ -f1 | sort -u)
    count=$(echo "$roots" | wc -l)
    if [ "$count" -eq 1 ]; then
        echo "Contained in: $roots"
    else
        echo "Loose files ($count top-level entries)"
    fi
}

lint() {
    local target="${1:-.}"
    local BLUE='\033[1;34m'
    local RED='\033[1;31m'
    local GREEN='\033[1;32m'
    local NC='\033[0m'

    echo -e "${BLUE}==> [1/4] ruff format ($target)${NC}"
    if ! uv run ruff format "$target"; then
        echo -e "${RED}FAILED: ruff format failed${NC}" >&2
        return 1
    fi

    echo -e "${BLUE}==> [2/4] ruff check --fix ($target)${NC}"
    if ! uv run ruff check --fix "$target"; then
        echo -e "${RED}FAILED: ruff check found unfixable issues${NC}" >&2
        return 1
    fi

    echo -e "${BLUE}==> [3/4] ruff format ($target)${NC}"
    if ! uv run ruff format "$target"; then
        echo -e "${RED}FAILED: ruff format failed${NC}" >&2
        return 1
    fi

    echo -e "${BLUE}==> [4/4] pyright ($target)${NC}"
    if ! uv run pyright "$target"; then
        echo -e "${RED}FAILED: pyright found type errors${NC}" >&2
        return 1
    fi

    echo -e "${GREEN}==> All checks passed${NC}"
}
