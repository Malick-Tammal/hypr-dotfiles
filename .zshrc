#----------------------------------------------------------
#-- HACK: ZSH Config
#----------------------------------------------------------

export ZSH_CONFIG="$HOME/.config/zsh"

# 1. Environment
[[ -f "$ZSH_CONFIG/env.zsh" ]] && source "$ZSH_CONFIG/env.zsh"

# 2. Options & History
[[ -f "$ZSH_CONFIG/options.zsh" ]] && source "$ZSH_CONFIG/options.zsh"

# 3. Aliases
[[ -f "$ZSH_CONFIG/aliases.zsh" ]] && source "$ZSH_CONFIG/aliases.zsh"

# 3. FZF customization
[[ -f "$ZSH_CONFIG/fzf.zsh" ]] && source "$ZSH_CONFIG/fzf.zsh"

# 3. Zinit
[[ -f "$ZSH_CONFIG/zinit.zsh" ]] && source "$ZSH_CONFIG/zinit.zsh"

# 6. Plugins
[[ -f "$ZSH_CONFIG/plugins.zsh" ]] && source "$ZSH_CONFIG/plugins.zsh"

# 7. Private keys
[[ -f "$HOME/dotfiles/keys.zsh" ]] && source "$HOME/dotfiles/keys.zsh"
