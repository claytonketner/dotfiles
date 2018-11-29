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

set -o ignoreeof  # Same as setting IGNOREEOF=10

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
    if [[ -z $branches ]]; then
        echo "No eligible branches to delete."
        return 1
    fi
    printf "I'm going to delete these branches:\n$branches\n"
    read -p "Is that OK? (y/n) " confirmation
    if [[ "$confirmation" =~ ^[yY]$ ]]; then
        git branch -d $branches
        return 0
    else
        echo "Aborted"
        return 2
    fi
}
function _get_wtf_file {
	# Convenience function for getting the path to the wtf file for the pwd
	for file in `find ~/wtfs -type f`; do
		first_line=`head -n 1 $file`
		if [[ "$PWD" = "$first_line"* ]]; then
			# Match!
			echo $file
			return 0
		fi
	done
	echo ""
	return 1
}
function mkwtf {
	# Creates a new wtf file for the current directory
	current_dir=${PWD##*/}  # Current dir w/o full path
	new_filename=~/wtfs/$current_dir
	if [[ -f $new_filename ]]; then
		echo "$new_filename already exists!"
		echo "Aborting"
		return 1
	else
		touch $new_filename
		echo "$PWD" > $new_filename
		echo -e "---\nPut your help text below\n---\n\n" >> $new_filename
		echo "Created $new_filename - go edit it (try \`editwtf\`)!"
		return 0
	fi
}
function editwtf {
	# Opens the wtf file for the current directory in a text editor
	wtf_file=`_get_wtf_file`
	if [[ $? = 0 ]]; then
		$EDITOR $wtf_file
	else
		echo "Cannot edit WTF file because it wasn't found. Maybe make one with \`mkwtf\`?"
		return 1
	fi
}
alias ewtf=editwtf
function wtf {
	# Looks up a help file from ~/wtfs
	wtf_file=`_get_wtf_file`
	if [[ $? = 0 ]]; then
		wtf_text=`tail -n +5 $wtf_file`  # Omit the text in the first few lines
		echo "$wtf_text"
		echo ""
		return 0
	fi
	echo "WTF file not found. Maybe make one with \`mkwtf\`?"
	return 1
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
