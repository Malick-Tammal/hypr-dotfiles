#  INFO: Starship
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

#  INFO: Zinit plugins
zinit ice wait"0" lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"0" lucid; zinit light zsh-users/zsh-completions
zinit ice wait"0" lucid; zinit light MichaelAquilina/zsh-you-should-use
# zinit ice wait"0" lucid; zinit light mroth/evalcache
zinit ice wait"0" lucid; zinit snippet OMZP::git
zinit ice wait"0" lucid; zinit snippet OMZP::sudo

# fzf-tab
zinit ice wait"0" lucid atinit'
  autoload -Uz compinit && compinit -C
'
zinit light Aloxaf/fzf-tab

#  INFO: FZF
source <(fzf --zsh)

#  INFO: Zoxide
eval "$(zoxide init zsh)"

#  INFO: Load completions
zinit ice wait"0" lucid atinit'
  autoload -Uz compinit
  compinit -C
'
zinit light zdharma-continuum/null

#  INFO: NVM
function nvm() {
    unset -f nvm node npm npx
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

#  INFO: BUN
export PATH="$BUN_INSTALL/bin:$PATH"
