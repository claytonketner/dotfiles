# Bash aliases
if [ "$(uname)" == "Darwin" ]; then
    # brew install coreutils
    alias ls='gls --color -h --group-directories-first'
else
    alias ls='ls --color -h --group-directories-first'
fi
hash -r
set +H  # Turn off history expansion via `!`
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

set -o ignoreeof  # Same as setting IGNOREEOF=10

if [ -f ~/wtf.bash ]; then
   source ~/wtf.bash
fi

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
	# Copied/modified from https://github.com/not-an-aardvark/git-delete-squashed
    git checkout -q master
	branches=$(git for-each-ref refs/heads/ "--format=%(refname:short)")
	branches_to_delete=""
	while read branch; do
		mergeBase=$(git merge-base master $branch)
		if [[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]]; then
			branches_to_delete="$branches_to_delete $branch"
		fi
	done <<< "$branches"
	echo "I'm going to delete these branches:"
	for branch in $branches_to_delete; do
		echo -e "\t$branch"
	done
	read -p "Is that OK? (y/n) " confirmation
	if [[ "$confirmation" =~ ^[yY]$ ]]; then
		git branch -D $branches_to_delete
		return 0
	else
		echo "Aborted"
		return 2
	fi
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
# Autocomplete ssh commands based on known_hosts file
complete -W "$(cat ~/.ssh/known_hosts | awk -F , '{print $1}' | grep '.com' | awk '{print $1}')" ssh
