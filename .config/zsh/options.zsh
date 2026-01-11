# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# # Enable the complist module (required for colored menu)
# zmodload zsh/complist
#
# # Use the arrow keys to navigate the completion menu
# zstyle ':completion:*' menu select
#
# # Colorize the completion menu to match your LS_COLORS
# # 'ma' (match) sets the highlight color for your selection
# # 01;30;43 is Bold; Black Text; Yellow Background
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" "ma=01;30;43"
#
# # Group results by category (Directories, Files, etc.)
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
#
# # Optional: Case-insensitive completion
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
