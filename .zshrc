export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(git)

export PATH="/usr/local/bin:"$PATH
export PATH="$HOME/.local/bin:"$PATH
export PATH="$HOME/.cargo/bin:"$PATH

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

#[[ $TERM != "screen" ]] && exec tmux
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [ $TERM != "screen" ]; then
    tmux attach -t hack || tmux new -s hack; exit
  fi
fi

# program aliases
alias v="vim"
alias nv="nvim"
alias config='/usr/bin/git --git-dir=/Users/jose/.cfg/ --work-tree=/Users/jose'
