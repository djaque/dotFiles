# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.bashfunc ]; then
	. ~/.bashfunc
fi

if [ -f ~/.bashalias ]; then
	. ~/.bashalias
fi

# User specific aliases and functions
PS1='\n\[\e[1;32m\]\w\[\e[0m\]\n\u@\h: \[\e[1;31m\]$(parse_git_branch)\[\e[0m\]% '
export PS1

if [ -f /usr/share/doc/git-*/contrib/completion/git-completion.bash ]; then
	        . /usr/share/doc/git-*/contrib/completion/git-completion.bash
fi

Grey="\[\e[1;30m\]"
Purple="\[\e[0;35m\]"
Cyan="\[\e[0;36m\]"
LightGreen="\[\e[1;32m\]"
LightRed="\[\e[1;31m\]"
Default="\[\e[0m\]"

PS1="$LightRed+-[$Default\u$LightGreen@$Purple\h$LightGreen \$(get_branch) $Cyan\w$LightRed]\n$LightRed+->$Default "
export PATH=$PATH:~/vendor/bin/
export MSYSTEM_HOME=/opt/m.system/src/
export GOPATH=~/go


