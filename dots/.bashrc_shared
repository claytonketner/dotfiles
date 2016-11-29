# Bash aliases
if [ "$(uname)" == "Darwin" ]; then
    # brew install coreutils
    alias ls='gls --color -h --group-directories-first'
else
    alias ls='ls --color -h --group-directories-first'
fi
hash -r
alias l='ls'
alias la='ls -a'
alias ll='ls -lah'
alias sourceall='source ~/.bashrc; source ~/.bash_profile'
alias tmux='tmux -2'
alias vi=vim
alias vimpipe='xargs -o vim'
alias pipreqs='find . -name "requirements*" | xargs -n 1 pip install -r'
alias tree='tree --dirsfirst'
# Make ack output with less by default
alias ack='ACK_PAGER_COLOR="less -x4SRFX" ack'
alias ag='ag --pager "less -x4SRFX"'
alias less='less -R'
# Virtualenv
alias de='deactivate'
function venv
{
    maxdepth=4
    if [ $# -eq 1 ]; then
        maxdepth=$1
    fi
    for file in $( find . -type f -maxdepth $maxdepth -regex .*env.*/bin/activate | head -n 1 ); do
        echo source $file
        source $file
        break
    done
}
# Git
function diffadd {
    # Runs git add on the file(s) you just git diff-ed
    cmd=$(history | tail -n 2 | head -n 1 | sed "s/^ *[0-9]* *//g")
    if [[ ! $cmd == "git diff"* ]]; then
        echo "Invalid previous command"
        return
    fi
    # Strip off the "git diff"
    cmd=$(echo $cmd | sed "s/git diff//g")
    prefix="git add"
    for argument in "$@"
    do
        prefix="$prefix $argument"
    done
    cmd="$prefix $cmd"
    echo $cmd
    eval $cmd
}
function brclean {
    # Delete all merged branches, excluding master and the current branch
    branches=$(git branch --merged master | grep -v master | grep -v \*)
    if [[ ! $branches ]]; then
        echo "No eligible branches to delete."
        return
    fi
    git branch -d $branches
}
# Colorized man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
