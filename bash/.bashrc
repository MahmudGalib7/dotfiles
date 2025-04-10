# export IDEA_JDK=/usr/lib/jvm/java-17-openjdk
# . "$HOME/.cargo/env"
# . "/home/galib/.deno/env"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		color_prompt=yes
	else
		color_prompt=
	fi
fi

# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=no
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
	VIRTUAL_ENV_DISABLE_PROMPT=1

	prompt_color='\[\033[;32m\]'
	info_color='\[\033[1;34m\]'
	prompt_symbol=㉿
	if [ "$EUID" -eq 0 ]; then
		prompt_color='\[\033[;94m\]'
		info_color='\[\033[1;31m\]'
		prompt_symbol=💀
	fi
	case "$PROMPT_ALTERNATIVE" in
	twoline)
		PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '
		;;
	oneline)
		PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h\[\033[00m\]:'$prompt_color'\[\033[01m\]\w\[\033[00m\]\$ '
		;;
	backtrack)
		PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
		;;
	esac
	unset prompt_color
	unset info_color
	unset prompt_symbol
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;
esac

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	export LS_COLORS="$LS_COLORS:ow=30;44:"

	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias diff='diff --color=auto'
	alias ip='ip --color=auto'

	export LESS_TERMCAP_mb=$'\E[1;31m'
	export LESS_TERMCAP_md=$'\E[1;36m'
	export LESS_TERMCAP_me=$'\E[0m'
	export LESS_TERMCAP_so=$'\E[01;33m'
	export LESS_TERMCAP_se=$'\E[0m'
	export LESS_TERMCAP_us=$'\E[1;32m'
	export LESS_TERMCAP_ue=$'\E[0m'
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=1

# FZF
eval "$(fzf --bash)"

# Bat
alias bat='bat'
export BAT_THEME="Dracula"
export BAT_STYLE="full"

# Fd
alias fd='fdfind'

export PATH="/home/galib/.local/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(oh-my-posh init bash --config ~/1_shell.omp.json)"
source /home/galib/perl5/perlbrew/etc/bashrc
export PATH="$PATH:/home/galib/julia-1.10.4/bin"

# pnpm
export PNPM_HOME="/home/galib/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias pbcopy="xsel --input --clipboard"
alias pbpaste="xsel --output --clipboard"

. "$HOME/.cargo/env"
