keybinds="ctrl-l:accept"
prompt_symbol="❯ "

export FZF_DEFAULT_OPTS="--layout=reverse --border --height=40% --bind $keybinds \
--color=fg:#fcfcfa,bg:-1,hl:#ffd866 \
--color=fg+:#fcfcfa,bg+:#403e41,hl+:#ffd866 \
--color=info:#78dce8,prompt:#fc9867,pointer:#ffd866 \
--color=marker:#ff6188,spinner:#ff6188,header:#78dce8 \
--color=border:#606359,gutter:#606359 \
--preview-window=right:60% \
--pointer ▌ \
--prompt '$prompt_symbol'"

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range=:500 {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'eza --color=always --icons=always --tree --all {} | head -200'"

# fzf tab
zstyle ':fzf-tab:*' fzf-flags ${(z)FZF_DEFAULT_OPTS} --prompt="$prompt_symbol"

zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':fzf-tab:complete:*' fzf-preview \
'if [ -d $realpath ]; then
     eza --color=always --icons=always --tree --all $realpath | head -200
   else
     bat --color=always --style=numbers $realpath
   fi'

