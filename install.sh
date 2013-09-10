#!/bin/zsh

sln() {
  ln -iTvs "$1" "$2"
}

DIR=`pwd`

setopt EXTENDED_GLOB
for rcfile in prezto/runcoms/^README.md(.N); do
  sln "$DIR/$rcfile" "$HOME/.${rcfile:t}"
done

sln "$DIR/zsh" "$HOME/.zsh"
sln "$DIR/prezto" "$HOME/.zprezto"

mkdir -p "$HOME/.config/mc"
sln "$DIR/mc/ini" "$HOME/.config/mc/ini"

mkdir -p "$HOME/.local/share/mc/skins"
for sfile in mc/skins/*.ini(.N); do
  sln "$DIR/$sfile" "$HOME/.local/share/mc/skins/${sfile:t}";
done

sln "$DIR/vim/vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.vim/bundle"
sln "$DIR/vim/spell" "$HOME/.vim/spell"
git clone https://github.com/gmarik/vundle.git "$HOME/.vim/bundle/vundle"
vim +BundleInstall +wqa
cd "$HOME/.vim/bundle/YouCompleteMe"
mkdir build
cd build
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON  . ../cpp
make ycm_core
