# ~/.bashrc — Linux shell configuration

# Non-interactive bail
case $- in
    *i*) ;;
      *) return;;
esac

# History
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

# Terminal
shopt -s checkwinsize

# Chroot label (Debian)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Color prompt
case "$TERM" in
    xterm-color|*-256color|xterm-kitty) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1="\[$(tput setaf 114)\]\u\[$(tput setaf 80)\]@\[$(tput setaf 46)\]\h \[$(tput setaf 39)\]\w \[$(tput sgr0)\]$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# Window title
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

# Colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# PATH
export PATH="$PATH:$HOME/.scripts:$HOME/.local/bin"

# Source local overrides (not tracked)
[ -f "$HOME/.bash_aliases" ]  && source "$HOME/.bash_aliases"
[ -f "$HOME/.bash_secrets" ]  && source "$HOME/.bash_secrets"
[ -f "$HOME/.bash_methods" ]  && source "$HOME/.bash_methods"
[ -f "$HOME/.bashrc.local" ]  && source "$HOME/.bashrc.local"

# nvm (if installed)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
