#----------------------------------------------------------
#-- HACK: ZSH Config
#----------------------------------------------------------

#  INFO: Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#  PERF: Performance Flags
ZSH_DISABLE_COMPFIX="true"
DISABLE_AUTO_UPDATE="true"

#  INFO: Environment Variables
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="codium"
export BUN_INSTALL="$HOME/.bun"
export NVM_DIR="$HOME/.nvm"

#  INFO: Add Paths
path=("$BUN_INSTALL/bin" "$HOME/.local/bin" $path)
export PATH


#  INFO: Theme & Plugins
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git 
    zsh-syntax-highlighting 
    zsh-autosuggestions 
    you-should-use 
    fzf
)

#  INFO: Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

#  INFO: Tool Configurations (FZF, P10k, Zoxide)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#  INFO: Integrations
[[ -f ~/.cache/zsh/zoxide.zsh ]] && source ~/.cache/zsh/zoxide.zsh
[[ -f ~/.cache/zsh/fzf_init.zsh ]] && source ~/.cache/zsh/fzf_init.zsh

# FZF Monokai Pro Theme & Behavior
export FZF_DEFAULT_OPTS="--layout=reverse --border --height=40% \
--color=fg:#fcfcfa,bg:-1,hl:#ffd866 \
--color=fg+:#fcfcfa,bg+:#403e41,hl+:#ffd866 \
--color=info:#78dce8,prompt:#fc9867,pointer:#ffd866 \
--color=marker:#ff6188,spinner:#ff6188,header:#78dce8"

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range=:500 {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

#  INFO:  History Settings
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY        # Append to history file, don't overwrite
setopt SHARE_HISTORY         # Share history between sessions
setopt HIST_IGNORE_DUPS      # Don't record an entry if it's a duplicate of the previous one
setopt HIST_IGNORE_ALL_DUPS  # Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_SPACE     # Don't record entries starting with a space
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from history

#  INFO: External Sources & Keybindings
[[ -f ~/.aliases ]] && source ~/.aliases

#  INFO: Lazy-load NVM (Massively speeds up shell startup)
function nvm() {
    unset -f nvm node npm npx
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}
# Load NVM automatically when these commands are used
alias node='nvm node'
alias npm='nvm npm'
alias npx='nvm npx'

#  PERF: Performance: Faster Completion Loading (compinit)
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

#  INFO: Keybindings
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

#  INFO: Prompt Customization
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=1
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

#  INFO: Bun completions
[ -s "/home/malick-tammal/.bun/_bun" ] && source "/home/malick-tammal/.bun/_bun"
