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

mkdir -p "$HOME/.config/"
sln "$DIR/starship/starship.toml" "$HOME/.config/starship.toml"

mkdir -p "$HOME/.config/mc"
sln "$DIR/mc/ini" "$HOME/.config/mc/ini"

mkdir -p "$HOME/.local/share/mc/skins"
for sfile in mc/skins/*.ini(.N) mc/mc-dracula/skins/*.ini(.N); do
  sln "$DIR/$sfile" "$HOME/.local/share/mc/skins/${sfile:t}";
done

sln "$DIR/gdbinit/gdbinit" "$HOME/.gdbinit"
sln "$DIR/gdbinit.local/gdbinit.local" "$HOME/.gdbinit.local"

mkdir -p "$HOME/.config/ipython/profile_default"
sln "$DIR/ipython/ipython_config.py" "$HOME/.config/ipython/profile_default/ipython_config.py"

sln "$DIR/screen/screenrc" "$HOME/.screenrc"

mkdir -p "$HOME/.tmux/plugins"
sln "$DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
sln "$DIR/tmux/tpm" "$HOME/.tmux/plugins/tpm"


sln "$DIR/nvim" "$HOME/.config/nvim"

sln "$DIR/rofi" "$HOME/.config/rofi"

mkdir -p "$HOME/.themes"
for d in themes/*; do
  sln "$DIR/$d" "$HOME/.themes/${d:t}";
done

sln "$DIR/kitty" "$HOME/.config/kitty"

sln "$DIR/hypr" "$HOME/.config/hypr"
