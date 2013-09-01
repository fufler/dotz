#!/bin/zsh

DIR=`pwd`

setopt EXTENDED_GLOB
for rcfile in prezto/runcoms/^README.md(.N); do
  ln -iTvs "$DIR/$rcfile" "$HOME/.${rcfile:t}"
done

ln -iTvs "$DIR/zsh" "$HOME/.zsh"
ln -iTvs "$DIR/prezto" "$HOME/.zprezto"
