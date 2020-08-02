#!/usr/bin/env bash

set -x

pacman --noconfirm -Syyu

pacman --noconfirm -S \
  base-devel \
  clang \
  automake \
  cmake \
  sudo \
  unzip \
  \
  git \
  grep \
  zsh{,-completions} tmux \
  exa ripgrep jq fd bat hexyl \
  \
  nodejs npm \
  python{,2}{,-pip} \
  ruby{,gems,-irb} \
  \
  feh \
  shellcheck \
  docker \
  xclip

# curl -Lko VictorMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/VictorMono.zip
# unzip VictorMono.zip -d /usr/share/fonts/TTF/
# fc-cache -fv

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

set +x
