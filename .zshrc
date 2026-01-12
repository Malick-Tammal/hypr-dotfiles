#----------------------------------------------------------
#-- HACK: ZSH Config
#----------------------------------------------------------

export ZSH_CONFIG="$HOME/.config/zsh"

# 1. Load Options & History
[[ -f "$ZSH_CONFIG/options.zsh" ]] && source "$ZSH_CONFIG/options.zsh"

# 3. Load Aliases
[[ -f "$ZSH_CONFIG/aliases.zsh" ]] && source "$ZSH_CONFIG/aliases.zsh"

# 3. Load FZF customization
[[ -f "$ZSH_CONFIG/fzf.zsh" ]] && source "$ZSH_CONFIG/fzf.zsh"

# 3. Load Zinit
[[ -f "$ZSH_CONFIG/zinit.zsh" ]] && source "$ZSH_CONFIG/zinit.zsh"

# 3. Load Plugins
[[ -f "$ZSH_CONFIG/plugins.zsh" ]] && source "$ZSH_CONFIG/plugins.zsh"

# 3. Load Environment variables
[[ -f "$ZSH_CONFIG/env.zsh" ]] && source "$ZSH_CONFIG/env.zsh"

# 3. Load keys
[[ -f "$HOME/dotfiles/keys.zsh" ]] && source "$HOME/dotfiles/keys.zsh"
