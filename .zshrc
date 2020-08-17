export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(git)

export PATH="/usr/local/bin:"$PATH
export PATH="$HOME/.local/bin:"$PATH

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# program aliases
alias v="vim"
alias nv="nvim"
alias config='/usr/bin/git --git-dir=/Users/jose/.cfg/ --work-tree=/Users/jose'
