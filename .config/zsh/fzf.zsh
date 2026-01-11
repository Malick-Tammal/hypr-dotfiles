keybinds="ctrl-l:accept"

export FZF_DEFAULT_OPTS="--layout=reverse --border --height=40% --bind $keybinds \
--color=fg:#fcfcfa,bg:-1,hl:#ffd866 \
--color=fg+:#fcfcfa,bg+:#403e41,hl+:#ffd866 \
--color=info:#78dce8,prompt:#fc9867,pointer:#ffd866 \
--color=marker:#ff6188,spinner:#ff6188,header:#78dce8 \
--preview-window=right:60%"

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range=:500 {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# fzf tab
zstyle ':fzf-tab:*' fzf-flags ${(z)FZF_DEFAULT_OPTS}

zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*' fzf-preview \
  'if [ -d $realpath ]; then
     tree -C $realpath | head -200
   else
     cat $realpath
   fi'

