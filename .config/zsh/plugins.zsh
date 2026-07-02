#  INFO: Starship
zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

#  INFO: FZF
if (( $+commands[fzf] )); then
    { source <(fzf --zsh) } 2>/dev/null
fi

#  INFO: Zoxide
eval "$(zoxide init zsh)"

#  INFO: OMZ Snippets & Utilities
zinit ice wait"0" lucid; zinit light MichaelAquilina/zsh-you-should-use
zinit ice wait"0" lucid; zinit snippet OMZP::git
zinit ice wait"0" lucid; zinit snippet OMZP::sudo

#  INFO: Completions
zinit ice wait"0" lucid; zinit light zsh-users/zsh-completions

#  INFO: Compinit
zinit ice wait"0" lucid atinit'
  autoload -Uz compinit
  compinit -C
'
zinit light zdharma-continuum/null

#  INFO: Fzf-tab
zinit ice wait"0" lucid
zinit light Aloxaf/fzf-tab

# INFO: autosuggestions
zinit light zsh-users/zsh-autosuggestions

#  INFO: Syntax Highlighting
zinit ice wait"0" lucid
zinit light zsh-users/zsh-syntax-highlighting

#  INFO: NVM
lazy_load_nvm() {
    unset -f nvm node npm npx pnpm yarn bun

    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    "$@"
}

nvm()  { lazy_load_nvm nvm "$@"; }
node() { lazy_load_nvm node "$@"; }
npm()  { lazy_load_nvm npm "$@"; }
npx()  { lazy_load_nvm npx "$@"; }
pnpm() { lazy_load_nvm pnpm "$@"; }
yarn() { lazy_load_nvm yarn "$@"; }
bun()  { lazy_load_nvm bun "$@"; }
