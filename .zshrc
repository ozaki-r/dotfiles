########################################
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt completeinword
setopt autolist
setopt listtypes
setopt alwayslastprompt
#setopt menucomplete
#setopt recexact
setopt nolistbeep
fignore=( .o \~ .bak  )
zstyle ":completion:*" users ozaki-r root
compctl -k hosts telnet ftp ssh rsh
compctl -c man nohup killall
compctl -k hosts -S ':' + -f -x 'n[1,:]' -f - 'n[1,@]' \
-k hosts -S ':' -- scp
compctl -c -k '(zshall zshmisc zshexpn zshzle zshparam zshoptions zshbuiltins zshcompctl zshmodules)'\
- 'c[-1,-M]' -k manpath -- man jman whatis jwhatis
compctl -p export
compctl -E printenv
compctl -o setopt unsetopt
compctl -g '(|.)*(-/) *.(|e)ps' lpr
compctl -g '(|.)*(-/) *.[fco]'  \
-x 's[-I][-L]' -g '*(-/)'       \
- 'c[-1,-c]' -g '(|.)*(-/) *.c' --  cc gcc g++
#compctl -g '*(/)'  cd
########################################
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=100000
DIRSTACKSIZE=8
setopt auto_pushd pushd_ignore_dups pushdminus pushdsilent pushdtohome
alias dh='dirs -v'
setopt HIST_IGNORE_DUPS
setopt HIST_NO_STORE
setopt HIST_BEEP
########################################
zstyle ':completion:*:processes' command 'ps ex -o pid,cputime,comm'
zstyle ':completion:*:processes-names' command 'ps xho command'
########################################
# http://kitak.hatenablog.jp/entry/2013/05/25/103059
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT2='%_> '
PROMPT='
%B%m:%~
[%j]	> %b'
RPROMPT='%1(v|%F{green}%1v%f|)'
########################################
export PATH="$HOME/bin:$PATH"
if [ -d /usr/pkg/bin ]; then
	export PATH="$PATH:/usr/pkg/bin"
fi
if [ -d /var/lib/snapd/snap/bin ]; then
	export PATH="$PATH:/var/lib/snapd/snap/bin"
fi
if [ $(uname) = 'NetBSD' ]; then
	export PATH="$PATH:/sbin:/usr/sbin"
fi

########################################

if $(/bin/ls --color >/dev/null 2>&1); then
	alias ls='/bin/ls -Fs --color=auto'
	alias la='/bin/ls -Flas --color=auto'
	alias l.='/bin/ls -Fas --color=auto'
	alias ll='/bin/ls -Fls --color=auto'
	alias lr='/bin/ls -Flsrt --color=auto'
else
	# Mac?
	export CLICOLOR=
	alias ls='/bin/ls -Fs'
	alias la='/bin/ls -Flas'
	alias l.='/bin/ls -Fas'
	alias ll='/bin/ls -Fls'
	alias lr='/bin/ls -Flsrt'
fi
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias -g L='|less'
alias -g G='|grep -i'
alias -g S='|sort'
alias -g T='|tail'
alias -g H='|head'
alias -g W='|wc -l'
alias -g OM='origin/master'
alias sl='ls'
alias rgc='rg --color=always'
if ! $(which colorsvn >/dev/null 2>&1); then
        alias svn=colorsvn
fi
if $(which peco >/dev/null 2>&1); then
        alias -g P='|peco'
fi
if [ $(uname) = 'Linux' ]; then
	alias pstree='pstree -Ghln'
	alias rpm='sudo /bin/rpm'
	alias apt-get='sudo /usr/bin/apt-get'
	alias apt-cache='sudo /usr/bin/apt-cache'
	alias yum='sudo /usr/bin/yum'
	alias a-search='/usr/bin/env LANG=C LC_ALL=C /usr/bin/aptitude search'
	alias a-install='sudo /usr/bin/env LANG=C LC_ALL=C /usr/bin/nice /usr/bin/ionice -c 3 /usr/bin/aptitude install'
	alias a-remove='sudo /usr/bin/env LANG=C LC_ALL=C /usr/bin/aptitude remove'
	alias a-show='sudo /usr/bin/env LANG=C LC_ALL=C /usr/bin/aptitude show'
	alias d-search='/usr/bin/env LANG=C LC_ALL=C /usr/bin/dpkg-query -S'
	alias d-list='/usr/bin/env LANG=C LC_ALL=C /usr/bin/dpkg-query -L'
fi
if $(dmesg -xT >/dev/null 2>&1); then
	alias dmesg='dmesg -xT'
fi
if $(which htop >/dev/null 2>&1); then
        alias top='htop -C'
fi
if [ $(uname) = 'Darwin' ]; then
        alias brew='nice brew'
	alias spotlight='mdfind'
fi
if [ $(uname) = 'NetBSD' ]; then
	alias grepsvn='grep --exclude="*.svn*"'
	alias grepcvs='grep --exclude="*CVS*" --exclude="*.#*"'
fi
which proctree >/dev/null 2>&1
if [ $? = 0 ]; then
	alias pstree=proctree
fi

########################################

function svndiff()
{
  svn diff "${@}" | colordiff
}

function svndiffless()
{
  svn diff "${@}" | colordiff |less -R
}

export JLESSCHARSET=ja
#export LC_ALL=ja_JP.UTF-8
export LC_ALL=en_US.UTF-8
#export PAGER=lv
export PAGER=less
export PRINTER=lp
export LESS=-RMs
export SVN_EDITOR="vim"
if [ $(uname) = 'NetBSD' ]; then
	export MANPATH="/usr/share/man:/usr/pkg/man"
	export CURL_CA_BUNDLE="/etc/openssl/cert.pem"
fi
export EDITOR=vim
export CVS_RSH=ssh
export CVSROOT=ozaki-r@cvs.NetBSD.org:/cvsroot

########################################
# Coloring PROMPT
local RED=$'%{\e[00;31m%}'
local DEFAULT=$'%{\e[00;00m%}'

# For SSH
if [ -n "$SSH_CLIENT" ] ; then
	export PROMPT="${RED}${PROMPT}${DEFAULT}"
fi
if [ -n "$REMOTEHOST" ] ; then
	export DISPLAY="$REMOTEHOST":0.0
fi

# Emacs-like key binding
# It's needed when you ssh-login and use zsh in screen
bindkey -e

# Show the execution time of an executing command if it takes over 3s
export REPORTTIME=3

########################################
if $(which pyenv >/dev/null 2>&1); then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi

if [ -d $HOME/go/bin ]; then
	export PATH="$HOME/go/bin:$PATH"
fi

if [ -f $HOME/.cargo/env ]; then
	source $HOME/.cargo/env
fi

if [ -d "$HOME/.local/bin" ]; then
        export PATH="$HOME/.local/bin:$PATH"
fi

if [ -f $HOME/.zsh.google-cloud-sdk.inc ]; then
	source $HOME/.zsh.google-cloud-sdk.inc
fi

if $(which kubectl >/dev/null 2>&1); then
	source <(kubectl completion zsh)
fi

if [ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

autoload -U compinit
compinit
