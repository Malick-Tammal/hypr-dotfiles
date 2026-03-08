# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# Force a clean initial path
unsetopt PROMPT_SP

setopt correct
setopt auto_cd

# Disable stopping the shell with Ctrl+D
setopt IGNORE_EOF
