function webm2gif ()
{
	ffmpeg -y -i "$1" -vf palettegen _tmp_palette.png
	ffmpeg -y -i "$1" -i _tmp_palette.png -filter_complex paletteuse -r ${2:-"15"} "${1%.webm}.gif"
	rm _tmp_palette.png
	
}

function timestamp() {
	echo $(($(date +%s%N)/1000000))
}

function rand() {
	# Generates random alphanumeric string with special characters
	# for password generation
	# $1: length of string
	tr -dc "[:alnum:][:punct:]" < /dev/urandom | head -c $1 
	echo ''
}

function cheat(){ 
	# Online cheatsheet
	curl cheat.sh/$1 
}

function weather(){ 
	# Display full weather of location
	curl -s wttr.in/${1:-"Patras"}\?2F | head -n -1 
}

function wt(){ 
	# Display full weather widget of location
	# curl -s wttr.in/${1:-"Patras"}\?2 | head -n 7 | tail -n6
	curl -s wttr.in/${1:-"Patras"}\?0
}

function qrenc(){
	# Encode a string to QR format
	printf "%s" "$@" | curl -F-=\<- qrenco.de
}

function dict() { 
 	# Dictionary definitions for words
	curl -s dict://dict.org/d:$1 | sed -n '/^151/,/^250/{//!p;}'
}

function sxcv() {
	# Read .cbz files with sxiv
	dir=$(mktemp -p /tmp -d sxiv-XXX)
	7z x "${@: -1}" -o$dir > /dev/null
	sxiv "${@:1:-1}" -r $dir
	\rm -r $dir
}

function man() {
	# Alias of man commands with colors
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

precmd () {
    tmux  set -g status-right "#[fg=#3b383e, bg=#a9dc76, bold]  #[fg=#a9dc76,bg=#3b383e, bold] #{pane_current_path} #[default] "
}


# Enable colors and change prompt:
autoload -U colors && colors
# PS1="─[%~]"$'\n'"─▪ "
PS1="─▪ "

# History in cache directory:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.histfile

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
#_comp_options+=(globdots)		# Include hidden files.
# Coloring
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=255'


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

alias ls="ls --color=always" 
alias vi="nvim"
alias vim="nvim"
alias pacman="pacman --color=auto" 
alias mv="mv -i"
alias rm="rm -i"

alias sudo='doas'
alias tuxguitar="JAVA_HOME=/usr/lib/jvm/java-11-openjdk tuxguitar"
alias neofetch="neofetch --ascii"

PATH+=":/opt/pypy3/bin"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/key-bindings.zsh

