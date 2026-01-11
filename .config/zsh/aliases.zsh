#----------------------------------------------------------
#--  HACK: Aliases `Make your life easy`
#----------------------------------------------------------

#  INFO: YAY (arch) ---
alias i="yay -S"
alias s="yay -Ss"
alias r="yay -Rns"
alias update="yay -Syu"
alias list="yay -Q"

# INFO: Brew (macos / linux)
# alias bi="brew install"
# alias bic="brew install --cask"
# alias br="brew uninstall"
# alias bu="brew update"
# alias bs="brew search"
# alias bl="brew list"
# alias bfu='brew update; brew upgrade --cask --greedy ; brew upgrade $(brew outdated | awk "{ print $1 }") ; brew cleanup'

#  INFO: ZSH / BASH ---
alias szsh="source ~/.zshrc"
alias vzsh="nvim ~/.zshrc"
alias czsh="code ~/.zshrc"

alias cbash="source ~/.bashrc"
alias vbsh="nvim ~/.bashrc"
alias cbsh="code ~/.bashrc"


# INFO: EDIT ALIASES
alias vals="nvim ~/.config/zsh/aliases.zsh"
alias bals="bat ~/.config/zsh/aliases.zsh"
alias cals="code ~/.config/zsh/aliases.zsh"

# INFO: HYPRLAND
alias nvhypr="nvim ~/.config/hypr/hyprland.conf"
alias chypr="code ~/.config/hypr/hyprland.conf"

# INFO: TERMINAL

# INFO: TERMINAL
alias neo="neofetch"
alias fast="fastfetch"
alias c="clear"
alias rmrf="rm -rf"
alias realrm="/bin/rm -iv"                              #-- Regular rm
alias md="mkdir -p"
alias t="touch" 
alias rm="trash-put"                                    #-- Safe rm

#  INFO: Eza
alias ls="eza --color=always --icons=always"
alias la="eza --color=always --icons=always -a"
alias lsa="eza --color=always --icons=always -la"
alias lsc="ls --color=never --icons=never"

# Lsd
# alias ls="lsd"
# alias lsa="lsd -a"
# alias lsla="lsd -la"

#  INFO: Move
alias cd="z"
alias ..="cd .."
alias ...="cd ../.."

#  INFO: Nvim
alias nv="nvim"
alias nvh="nv ."

#  INFO: Node
alias npmi="npm i"
alias npmig="npm i -g"
alias npmiy="npm init -y"
alias npmisd="npm i --save-dev"
alias npmre="npm remove"
alias npms="npm start"
alias npmrd="npm run dev"
alias npmrp="npm run preview"
alias npmrb="npm run build"
alias npmrde="npm run deploy"
alias npmcv="npm create vite@latest"

#  INFO: Git
alias gcmm="git commit -m"
alias lg="lazygit"

#  INFO: Bench zsh
alias bench="time zsh -i -c exit"

#  INFO: Matrix effect
alias matrix="cmatrix"

#  INFO: Copy current dir path
alias cdp="pwd | tr -d '\n' | wl-copy"

#  INFO: Tmux
alias tn="tmux new-session -s"
alias tl="tmux ls"
alias tan="tmux attach -t"
alias ta="tmux attach"
alias tk="tmux kill-session -t"

#  INFO: Reload touchpad drivers
alias fix-touchpad="sudo modprobe -r i2c_hid_acpi && sudo modprobe i2c_hid_acpi"

#  INFO: Yazi
alias y="yazi"
