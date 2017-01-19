# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PS1='\n\[\e[1;32m\]\w\[\e[0m\]\n\u@\h: \[\e[1;31m\]$(parse_git_branch)\[\e[0m\]% '
export PS1
function parse_git_branch () {
	local he="$(git branch 2>&- | sed '/^\*/!d; s/.* //')";
	if [ ! -z $he ]; then
		echo -e "[ $he ]";
	fi
}

if [ -f /usr/share/doc/git-*/contrib/completion/git-completion.bash ]; then
	        . /usr/share/doc/git-*/contrib/completion/git-completion.bash
fi

function git_diff() {
	git diff --no-ext-diff -w "$@" | vim -R -
}

# export PROMPT_COMMAND="source /usr/local/bin/check_git_branch"
alias initpackcars='make -C ~/yapo_cl/ db-load-accounts db-load-diff_pack_cars1 db-snap-packauto db-restore-packauto rebuild-asearch redis-flushall'
alias initpackinmo='make -C ~/yapo_cl/ db-load-accounts db-load-diff_pack_inmo1 db-snap-packinmo db-restore-packinmo rebuild-asearch redis-flushall'
alias restorepackcars='make -C ~/yapo_cl/ db-restore-packauto rebuild-asearch redis-flushall'
alias restorepackinmo='make -C ~/yapo_cl/ db-restore-packinmo rebuild-asearch redis-flushall'
alias home='cd ~'
alias work='cd ~/yapo_cl'
alias gork='cd ~/go/src/github.schibsted.io/Yapo/creditos'
alias api='cd ~/accounts_api'
alias psux='ps ux'
alias mkae='make -s'
alias make='make -s'
alias mk='make'
alias meka='make'
alias rinfo='make rinfo'
alias rall='make rall'
alias cleanlogs='make cleanlogs'
alias translog='less /tmp/`echo $USER`-regress.log'
alias database='psql -h /dev/shm/regress-`echo $USER`/pgsql0/data blocketdb'
alias redissession='redis-cli -p 23449'
alias makefinal='make -C ~/yapo_cl/regress/final/' 
alias loadaccounts='make -C ~/yapo_cl/ db-load-accounts rebuild-asearch' 
alias pbconf='printf "cmd:bconf\ncommit:1\nend\n"'
alias totrans='nc localhost 23405'
alias dnylog='git log --graph --pretty=format:"%C(yellow)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=short'
alias mk='make'
alias got='git'
alias gut='git'
alias mail='php ~/yapo_cl/util/quoteprinteable2text/quoteprinteable2text.php ~/yapo_cl/regress_final/logs/mail.txt > ~/decodedmail.txt && cat ~/decodedmail.txt|grep "^http"'
alias moil='php ~/yapo_cl/util/quoteprinteable2text/quoteprinteable2text.php ~/yapo_cl/regress_final/logs/mail.txt.old > ~/decodedmail.txt && cat ~/decodedmail.txt|grep "^http"'


# set my shortcuts
alias add='git add'
alias grm='git rm'
alias more='less'
alias show='git remote show origin'
alias co='git checkout'
alias fetch='git fetch'
alias show_branches='git branch'
alias status='git status;echo " ";show_local;'
alias clean='git clean'
alias pop_stash='git stash pop'
alias list_stash='git stash list'
alias showstash='git stash show "$@"'
alias ci='git commit --all -m '
alias mergeci='git commit'
alias stash='git stash save'
alias merge='git merge --no-ff '
alias mergetool='git mergetool'
alias merge_over='git merge -Xtheirs'
alias merge_master='git pull --no-rebase origin master'
alias show_dev_log='git log origin/develop..devevelop'
alias help='git help'
alias clean_preview='git clean -n -f'
alias clean='git clean -f'
alias clean_shit_up='git clean -Xfd'
alias gg='git grep -ni'
alias resource='source ~/.bashrc'

function show_local
{
    echo "Showing unpushed Commits";
    git log origin/$(get_branch)..HEAD --pretty=format:"%Cred%h%Creset-%C(bold blue)<%an> %Cgreen(%ar)%Creset : %s";
}

function prep_current
{
    echo "Preping";
    echo "";
    echo "fetching";
    git fetch;
    echo "pulling";
    git pull;
    echo "hard resetting";
    git reset --hard;
    echo "Done";
}

# diff 2 branches
# diff_b <branch_name> <branch_name>
function diffb()
{
   branch=$2;  
   echo "Compare $1 to $branch"
   git difftool --dir-diff $1..$branch
}

# diff the given branch with master
# diff_master <branch_name>
function diff_master()
{
   branch=$1;  
   echo "Compare master to $branch"
   git difftool --dir-diff origin/master..$branch
}

# diff your uncommitted work to what's checked in
# diff_work
function diff_work()
{
    git status;
    echo " ";
    show_local;
    git difftool --dir-diff HEAD;
}

# pull branch from origin
function pull
{
    branch=$(get_branch);
    git pull --rebase origin $branch
}

# push branch 
function push 
{
    branch=$(get_branch);
    git push origin $branch
}

#hard reset current branch
function reset_hard
{
    branch=$(get_branch);
    git reset --hard origin/$branch;
}

# create a new branch from master
# call with branch_master <branch name>
function branch_master() { 
   branch=$@;
   echo "creating $branch";
   echo "fetch master";
   git fetch origin master;
   echo "branch from master";
   git checkout -b $branch master; 
   echo "push branch remotely";
   git push origin $branch;
   git branch -vv;
}

# create a new branch from master
# call with branch_master <branch name>
function branch_current() { 
   branch=$@;
   curr=$(get_branch);
   echo "creating $branch";
   echo "fetch master";
   git fetch origin $curr;
   echo "branch from master";
   git checkout -b $branch $curr; 
   echo "push branch remotely";
   git push origin $branch;
   git branch -vv;
}

# delete branch locally and remotely
# call with nuke_branch <branch name>
function nuke_branch() { 
    branch=$@;
    echo "deleting local branch";
    git branch -D $branch; 
    echo "deleting remote branch";
    git push origin --delete $branch;
    echo "show current branches";
    git remote show origin;
}

#delete branch locally
#call with delete_branch <branch name>
function delete_branch()
{
    branch=$@;
    echo "deleting local branch";
    git branch -d $branch; 
    echo "show current branches";
    git branch
}

function show_custom()
{
    echo "Aliases ... "
    alias
    echo "Functions ... "
    set | grep -A 1000 "branch" |grep \(\)
}

Grey="\[\e[1;30m\]"
Purple="\[\e[0;35m\]"
Cyan="\[\e[0;36m\]"
LightGreen="\[\e[1;32m\]"
LightRed="\[\e[1;31m\]"
Default="\[\e[0m\]"

function get_branch
{
    git branch 2> /dev/null | grep "*" | sed "s/* //";
}

#lowercase a string
function toLower() {
   echo "$1" | tr "[:upper:]" "[:lower:]";
}

PS1="$LightRed+-[$Default\u$LightGreen@$Purple\h$LightGreen \$(get_branch) $Cyan\w$LightRed]\n$LightRed+->$Default "
export PATH=$PATH:~/vendor/bin/
export MSYSTEM_HOME=/opt/m.system/src/
export GOPATH=~/go

function nose
{
	echo "$1" | sed 's/\.\([A-Z]\)/:\1/g' | xargs ./nose.sh;
}
