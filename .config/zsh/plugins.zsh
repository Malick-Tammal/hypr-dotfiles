#  INFO: Starship
zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

#  INFO: FZF
if (( $+commands[fzf] )); then
  # Grouping the source command hides the zle options bleed from subshells 
  { source <(fzf --zsh) } 2>/dev/null
fi

#  INFO: Zoxide
eval "$(zoxide init zsh)"

# -------------------------------------------------------------------
# ASYNC PLUGINS (Turbo mode) - ORDER IS CRITICAL
# 1. OMZ Snippets & Utilities
zinit ice wait"0" lucid; zinit light MichaelAquilina/zsh-you-should-use
zinit ice wait"0" lucid; zinit snippet OMZP::git
zinit ice wait"0" lucid; zinit snippet OMZP::sudo

# 2. Add extra completions to $fpath BEFORE compinit
zinit ice wait"0" lucid; zinit light zsh-users/zsh-completions

# 3. Run compinit ONCE
zinit ice wait"0" lucid atinit'
  autoload -Uz compinit
  compinit -C
'
zinit light zdharma-continuum/null

# 4. fzf-tab MUST load after compinit, but before autosuggestions
zinit ice wait"0" lucid
zinit light Aloxaf/fzf-tab

# 5. autosuggestions MUST load after fzf-tab
zinit ice wait"0" lucid
zinit light zsh-users/zsh-autosuggestions

# 6. syntax-highlighting MUST be the absolute last plugin loaded
zinit ice wait"0" lucid
zinit light zsh-users/zsh-syntax-highlighting
# -------------------------------------------------------------------

#  INFO: NVM
function nvm node npm npx yarn() {
    unset -f nvm node npm npx yarn
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    if [ "$0" = "nvm" ]; then
        nvm "$@"
    else
        command "$0" "$@"
    fi
}

#  INFO: BUN
export PATH="$BUN_INSTALL/bin:$PATH"
