#!/bin/zsh

set -e

sln() {
  ln -iTvs "$1" "$2"
}

DIR=`pwd`

setopt EXTENDED_GLOB
for rcfile in prezto/runcoms/^README.md(.N); do
  sln "$DIR/$rcfile" "$HOME/.${rcfile:t}"
done


mkdir -p "$HOME/.zsh"
for file in zsh/*; do
  sln "$DIR/$file" "$HOME/.zsh/${file:t}"
done

sln "$DIR/prezto" "$HOME/.zprezto"

mkdir -p "$HOME/.config/mc"
sln "$DIR/mc/ini" "$HOME/.config/mc/ini"

mkdir -p "$HOME/.local/share/mc/skins"
for sfile in mc/skins/*.ini(.N); do
  sln "$DIR/$sfile" "$HOME/.local/share/mc/skins/${sfile:t}";
done

sln "$DIR/vim/vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.vim/bundle"
mkdir -p "$HOME/.vim/swap"
mkdir -p "$HOME/.vim/backup"
mkdir -p "$HOME/.vim/snippets"
sln "$DIR/vim/spell" "$HOME/.vim/spell"
[[ ! -d "$HOME/.vim/bundle/vundle" ]] && git clone https://github.com/gmarik/vundle.git "$HOME/.vim/bundle/vundle"
vim +BundleInstall +wqa

sln "$DIR/gdbinit/gdbinit" "$HOME/.gdbinit"
sln "$DIR/gdbinit.local/gdbinit.local" "$HOME/.gdbinit.local"

mkdir -p "$HOME/.config/ipython/profile_default"
sln "$DIR/ipython/ipython_config.py" "$HOME/.config/ipython/profile_default/ipython_config.py"

sln "$DIR/screen/screenrc" "$HOME/.screenrc"
sln "$DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
