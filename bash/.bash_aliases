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

alias rodin='/opt/rodin/rodin >/dev/null 2>&1 &'

alias activate-ml-env='conda activate ml_cuda12.2'

alias py='python'

alias p='python'
