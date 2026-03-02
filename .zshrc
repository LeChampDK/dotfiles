# ~/.zshrc — macOS shell configuration

# History
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# Prompt (matches bashrc color style)
PROMPT='%F{green}%n%f@%F{blue}%m %F{cyan}%~%f $ '

# Colors & aliases
alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Completion
autoload -Uz compinit
compinit

# PATH
export PATH="$PATH:$HOME/.scripts:$HOME/.local/bin:/opt/homebrew/bin"

# pnpm (if installed)
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# proto (if installed)
if [ -d "$HOME/.proto" ]; then
  export PROTO_HOME="$HOME/.proto"
  export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
fi

# bun completions (if installed)
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Source local overrides (not tracked)
[ -f "$HOME/.zsh_aliases" ]  && source "$HOME/.zsh_aliases"
[ -f "$HOME/.zsh_secrets" ]  && source "$HOME/.zsh_secrets"
[ -f "$HOME/.zsh_methods" ]  && source "$HOME/.zsh_methods"
[ -f "$HOME/.zshrc.local" ]  && source "$HOME/.zshrc.local"
[ -f "$HOME/.scripts/shared-methods" ] && source "$HOME/.scripts/shared-methods"
