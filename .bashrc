# ███╗   ███╗██╗███╗   ██╗██████╗ ██╗  ██╗██╗   ██╗███╗   ██╗████████╗███████╗██████╗ 
# ████╗ ████║██║████╗  ██║██╔══██╗██║  ██║██║   ██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗
# ██╔████╔██║██║██╔██╗ ██║██║  ██║███████║██║   ██║██╔██╗ ██║   ██║   █████╗  ██████╔╝
# ██║╚██╔╝██║██║██║╚██╗██║██║  ██║██╔══██║██║   ██║██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗
# ██║ ╚═╝ ██║██║██║ ╚████║██████╔╝██║  ██║╚██████╔╝██║ ╚████║   ██║   ███████╗██║  ██║
# ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝

# dotfiles circa 2024 

                                                                                   
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
color_prompt=yes
else
color_prompt=
fi
fi

if [ "$color_prompt" = yes ]; then
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
;;
*)
;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
if [ -f /usr/share/bash-completion/bash_completion ]; then
. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
fi

#Alias
# alias clear="echo -ne '\033c'"
alias c="clear"
alias e="exit"
alias install="sudo nala install"
alias fuckoff="exit"
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
# alias update="sudo apt update && sudo apt full-upgrade -y"
alias update="sudo nala update && sudo nala upgrade"
alias open="xdg-open"
alias ..="cd .."
alias r="cd ~-"
alias grep="grep --color=always"
alias ll="exa -l -g --color=always --icons"
alias la="exa -d .* --color=always --icons"
# alias ls="ls --color=always --group-directories-first"
alias ls="exa --icons --group-directories-first"
alias irc="ssh -i ~/.ssh/blinkenshell blinken"
# alias v="vim"
alias tsm="transmission-remote"
alias feh="feh -Tcatp"
alias curs="source ~/.bashrc"
alias cursx="xrdb ~/.Xresources"
alias duck="w3m duckduckgo.com"
alias google="w3m google.com"
alias b="w3m -B -cols 10"
alias dns="ping 8.8.8.8"
alias rss="newsboat"
alias m="neomutt"
alias fm="TERM=alacritty ranger"
alias clock="tty-clock -c -t"
alias i3conf="v ~/.config/i3/config"
alias ms="ncmpcpp"
alias lib="ranger ~/library"
alias clip="xclip -sel clip"
# alias dark="telegram-send --config ~/.config/dark_academia.conf"
alias nocte="sudo ip netns exec darkvpn openvpn --config ./darkacademia.ovpn &"
alias kaizoku="~/projects/kaizoku/kaizoku"
alias dshell="sudo ip netns exec darkvpn sudo -u mindhunter bash"
alias spotify="LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify"
alias arttime="~/github/arttime/bin/arttime"
alias artprint="~/github/arttime/bin/artprint"
# alias nordify="python3 ~/github/ImageGoNord/src/cli.py"
alias gettk="pass mindhunter/github/token | clip"
alias tors="transgression-tui"
alias scim="sc-im"
alias wloc="curl ifconfig.co/city"
alias upipe="systemctl --user restart pipewire"
alias yt="ytfzf -c Y,R"
alias sudo="sudo -E "
alias v="~/.bin/nv_curs"
# alias th="tmuxp load ~/.config/tmuxp/default.yaml"

# alias nv="nvim"

# lolcat -a -s 1000 ~/banner/sic

# Cursor Colour
# echo -ne '\e]12;#FF4500\a' # orange red
# echo -ne '\e]12;#FF6666\a'
# echo -ne '\e]12;#008080\a' # teal
# echo -ne '\e]12;#3CB371\a' # sea green
# echo -ne '\e]12;#0A40BC\a' # blue
# echo -ne '\e]12;#d0d0d0\a'
# echo -ne '\e]12;#708099\a'   # slate grey
echo -ne '\e]12;#5F5F87\a'

# Cursor style
echo -ne '\e[5 q'

# Text Foreground
# echo -ne '\e]10;#F601D5\a' # Magenta
# echo -ne '\e]10;#66CC00\a' # Green
# echo -ne '\e]10;#6666FF\a' # Purple
# echo -ne '\e]10;#FF6666\a' # Red
#  echo -ne '\e]10;#4C0099\a' # New Purp
# echo -ne '\e]10;#005F5F\a' # Deep Sky Blue
# echo -ne '\e]10;#5F5F87\a' # Medium Purple
# echo -ne '\e]10;#F94877\a' # Red Pop
echo -ne '\e]10;#AFAFAF\a' # Grey69
# echo -ne '\e]10;#F5E0DC\a' # Rosewater
# echo -ne '\e]10;#d0d0d0\a' # Grey82
# echo -ne '\e]10;#FBF1C7\a'   # Paper


# echo -ne '\e]10;#AC88BC\a'  # Nocte purp

#Bind
# bind '"∆":"ʞ"'
bind -x '"\e[11~":"ʞ"'
bind -x '"\e[12~":"chdir"'
bind -x '"\e[13~":"aps"'
bind '"\e[24~":"sudo "'

#PS Var
# PS1="\[\e[1;38;5;208m\]mindhunter@sephiroth:\W\[\\e[0m\] "
# PS1="\[\e[1;38;5;161m\]\W ⵀ\[\\e[0m\] "

if [[ -z "$(ip netns identify)" ]]
   then
      PS1="\[\e[1;38;5;210m\]\w\[\e[0m\] in \[\e[1;38;5;216m\]\h\n$\[\e[0m\] "
   else
      ns_name="$(ip netns identify)"
      PS1="\[\e[1;38;5;210m\]\w\[\e[0m\] in \[\e[1;38;5;216m\]${ns_name}\n$\[\e[0m\] "

# Set variables
export XDG_RUNTIME_DIR=/run/user/1000
fi

PS3="% "

#Bookmarks
source ~/.local/bin/bashmarks.sh
source ~/.bin/func

#shopt
shopt -s autocd histreedit extglob globstar direxpand
shopt -u histverify
set -o vi

#stty
stty -ixon

exec {BASH_XTRACEFD}> /dev/null
export HISTCONTROL="erasedups":"ignoreboth"
export PROMPT_DIRTRIM=2
# source ~/.bin/dir_colors
unalias l

#-------- Color Manpages
export LESS_TERMCAP_mb=$'\E[01;31m'             # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'             # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end mode
export LESS_TERMCAP_se=$'\E[0m'                 # end standout-mode
export LESS_TERMCAP_so=$'\E[01;33m'             # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[01;32m'             # begin underline
export PATH=$PATH:/home/mindhunter/.spicetify



# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%D %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"


source /home/mindhunter/.bash_completions/nala.sh
. "$HOME/.cargo/env"

eval `dircolors ~/git_repos/dircolors/bliss.dircolors`

# Starship
# eval "$(starship init bash)"

# Zoxide
eval "$(zoxide init --cmd cd bash)"
bind '"\C-xe":call-last-kbd-macro'
