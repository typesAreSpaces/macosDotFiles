export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(git)

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export APPS_DIR="$HOME/Documents/Apps"
export GITHUB_PROJECTS_DIR="$HOME/Documents/GithubProjects"
export BOSQUE_DIR="$GITHUB_PROJECTS_DIR/BosqueLanguage"
export MASTER_THESIS_DIR="$GITHUB_PROJECTS_DIR/master-thesis"
export PHD_THESIS_DIR="$GITHUB_PROJECTS_DIR/phd-thesis"
export MSAT_DIR="$APPS_DIR/mathsat-5.6.5-linux-x86_64"
export WALLPAPERS_DIR="\$HOME/Pictures/Wallpapers"
#export DYLD_LIBRARY_PATH="$HOME/AXDInterpolator/lib"

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

#[[ $TERM != "screen" ]] && exec tmux
#if which tmux 2>&1 >/dev/null; then
  #if [ $TERM != "screen-256color" ] && [ $TERM != "screen" ]; then
    #tmux attach -t hack || tmux new -s hack; exit
  #fi
#fi

# General Aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias git_discard_dhanges="git stash save --keep-index --include-untracked"
alias sshVB="ssh -p 2222 jose@127.0.0.1"
alias find_cpp_etags="find . -type f -iname \"*.[chS]p*\" | xargs etags -a"

# Directory Aliases
alias master_thesis="cd $MASTER_THESIS_DIR/Software/Cpp/EUFInterpolant"
alias master_thesis_paper="cd $MASTER_THESIS_DIR/Write\ Ups/thesis"
alias thesis="cd $PHD_THESIS_DIR/Documents/Write\ Ups/thesis"
alias papers_for_thesis="cd $PHD_THESIS_DIR/Documents/Papers"
alias reports="cd $PHD_THESIS_DIR/Documents/Write\ Ups/weekly_reports"
alias math_logic="cd $PHD_THESIS_DIR/Courses/Math\ 439"

alias bosque_paper="cd $BOSQUE_DIR/Technical\ Reports/Automatic\ verification\ for\ the\ Bosque\ Programming\ Language"

alias prof_kapur="cd $GITHUB_PROJECTS_DIR/Extended-Groebner-Basis"
alias basis_conversion="cd $GITHUB_PROJECTS_DIR/Basis-Conversion"

# Program Aliases
alias emacs="emacs -nw"
alias emacs26="emacs26 -nw"
alias ocaml="rlwrap ocaml"
alias wolfram="rlwrap wolfram"
alias v="vim"
alias nv="nvim"
alias smtinterpol="java -jar $APPS_DIR/smtinterpol-2.5-663-gf15aa217.jar"

# Docker Aliases
alias seahorn="systemctl start docker && sudo docker run -v $(pwd):/host -it seahorn/seahorn-llvm5"

# Scripts
quickConfigUpdate(){
  config status | grep "modified:" | sed 's/modified:/git --git-dir=$HOME\/.cfg --work-tree=$HOME add/g' | zsh;
  config status | grep "new file:" | sed 's/new file:/git --git-dir=$HOME\/.cfg --work-tree=$HOME add/g' | zsh;
}
quickConfigRestore(){
  config status | grep "modified:" | sed 's/modified:/git --git-dir=$HOME\/.cfg --work-tree=$HOME restore/g' | zsh;
}
 
se(){ du -a $HOME/* | awk '{ gsub (" ", "\\ ", $0); $1 = ""; print $0; }' | fzf | xargs -r xdg-open; }


pwdclip(){ pwd | awk '{gsub( " ","\\ " ); print}' | xclip -selection c }
cdclip(){ $(xclip -o) }

updateBrewPackages(){ brew bundle dump }
installBrewPackages() { brew bundle }

installZ3(){ 
  pushd "$GITHUB_PROJECTS_DIR/z3"; 
  python ./scripts/mk_make.py
  cd ./build;
  sudo make install -j$(nproc);
  popd; 
}
installMyZ3(){ 
  pushd "$GITHUB_PROJECTS_DIR/z3__"; 
  python ./scripts/mk_make.py
  cd ./build;
  sudo make install -j$(nproc);
  popd; 
}
installZ3InterpPlus(){ 
  pushd "$GITHUB_PROJECTS_DIR/z3-interp-plus"; 
  python ./scripts/mk_make.py
  cd ./build;
  sudo make install -j$(nproc);
  popd; 
}

bosqueProject(){
  Z3_VER=$(z3 --version);
  RESULT=$(echo $Z3_VER | awk '{ print $3; print "4.7.1"; }' | sort -rV | head -1);
  if [ "$RESULT" = "4.7.1" ]; then
    installZ3;
  fi
  cd $BOSQUE_DIR/impl;
}
bosqueVerifier(){
  tsc -p $BOSQUE_DIR/impl/tsconfig.json;
  node $BOSQUE_DIR/impl/bin/verifier/typescript_files/run_verifier.js $1
}
bosqueOptimizer(){
  tsc -p $BOSQUE_DIR/impl/tsconfig.json;
  node $BOSQUE_DIR/impl/bin/optimizer/run_optimizer.js $1
}
bosqueSymTest(){
  npm run-script build;
  if [ $# -eq 1 ]; then
    node $BOSQUE_DIR/impl/bin/runtimes/symtest/symtest.js $1 -v;
  else
    node $BOSQUE_DIR/impl/bin/runtimes/symtest/symtest.js $1 -v -o $2;
  fi
}

axdProject(){
  #Z3_VER=$(z3 --version | awk '{ print $3; }');
  #if [ "$Z3_VER" != "4.7.1" ]; then
    #installZ3InterpPlus;
  #fi
  cd $GITHUB_PROJECTS_DIR/AXDInterpolator
}

eufProject(){
  cd $GITHUB_PROJECTS_DIR/EUFInterpolator
}

editSyms(){
  pushd $HOME/texmf/tex/latex/local;
  nv symbols.sty;
  git add symbols.sty;
  git commit -m "Minor changes."; 
  git push;
  popd;
}

gruvboxTheme(){
  alacritty-theme-switch --select gruvbox_dark.yml
  #~/.config/polybar/scripts/colors.sh -gruvbox-dark
  #sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/iron_lady.jpg|g" ~/.config/i3/config
  perl -i -pe"s|color.*|color gruvbox|g" ~/.config/nvim/init.vim
}
nordTheme(){
  alacritty-theme-switch --select nord.yml
  #~/.config/polybar/scripts/colors.sh -nord
  #sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/minimal_mountains.png|g" ~/.config/i3/config
  perl -i -pe"s|color.*|color nord|g" ~/.config/nvim/init.vim
}
tokyo_nightTheme(){
  alacritty-theme-switch --select tokyo-night.yml
  #~/.config/polybar/scripts/colors.sh -tomorrow-night
  #sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/tokyo_night_2.jpg|g" ~/.config/i3/config
  perl -i -pe"s|color.*|color tokyonight|g" ~/.config/nvim/init.vim
}
