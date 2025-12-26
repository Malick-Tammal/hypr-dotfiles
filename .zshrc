#----------------------------------------------------------
#-- HACK: ZSH Config
#----------------------------------------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Powerlevel10k theme
ZSH_THEME="powerlevel10k/powerlevel10k"

##  INFO: Plugins
plugins=(
	git
	zsh-syntax-highlighting
    zsh-autosuggestions
    you-should-use
	fzf
)

##  INFO: Keybindings
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

##  INFO: FZF
# Monokai Pro for fzf
export FZF_DEFAULT_OPTS="
  --layout=reverse 
  --border 
  --height=40% 
  --color=fg:#fcfcfa,bg:-1,hl:#ffd866 
  --color=fg+:#fcfcfa,bg+:#403e41,hl+:#ffd866 
  --color=info:#78dce8,prompt:#fc9867,pointer:#ffd866
  --color=marker:#ff6188,spinner:#ff6188,header:#78dce8
  "

# Faster searching, respects .gitignore, ignores hidden system files
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'

# Preview file content using bat (syntax highlighting)
export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always --line-range=:500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Preview directories using tree (if you have it installed)
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

##  INFO: Oh My Zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

##  INFO: Custom aliases
source ~/.aliases

# Show commands execute time even if instant
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=1
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

##  INFO: History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

##  INFO: Shell integrations
# Zoxide
eval "$(zoxide init zsh --cmd cd)"

# FZF
source <(fzf --zsh)

##  INFO: Setting default editor to "nvim"
export EDITOR="nvim"

##  INFO: NVM Node version manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

##  INFO: BUN
# bun completions
[ -s "/home/malick-tammal/.bun/_bun" ] && source "/home/malick-tammal/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bin path
export PATH="$HOME/.local/bin:$PATH"
