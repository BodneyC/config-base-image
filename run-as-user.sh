#!/usr/bin/env bash

# shellcheck disable=SC2164

set -x

GITCLONES="$HOME/gitclones"

mkdir -p "$GITCLONES" && cd "$GITCLONES"

mkdir -p "$HOME/.local"
echo "prefix=/home/benjc/.local" > "$HOME/.npmrc"

npm i -g \
  bash-language-server \
  yarn \
  neovim \
  vim-language-server \
  bash-language-server \
  dockerfile-language-server-nodejs \
  markdownlint \
  markdownlint-cli

pip install --user \
  pynvim \
  pylint \
  vim-vint \
  python-language-server \
  libtmux \
  tmux_dash \
  shell-functools

gem install neovim

# --- OMZ

export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# --- TMUX

mkdir -p "$HOME/.tmux/plugins"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins"

# --- Dotfiles.git

git clone --recurse-submodules -j4 https://github.com/bodneyc/dotfiles.git && cd dotfiles
yes | ./softlink-dots.sh

# --- Nvim.git
cd "$GITCLONES"

git clone https://github.com/BodneyC/vim-neovim-config.git
cd vim-neovim-config

mkdir -p "$HOME/.config/coc/extensions"

curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

yes | ./softlink-config.sh || echo "Not root"

./neovim-from-source.sh
"$HOME/.local/bin/nvim" -u "$HOME/.config/nvim/config/plugins.vim" \
  -c "PlugInstall | qa" --headless

cd "$HOME/.config/coc/extensions" && yarn

sed -i 's/REVERSE=.*/REVERSE="\\x1b\[3m\\x1b\[1m/' \
  "$HOME/.local/share/nvim/plugged/fzf.vim/bin/preview.sh"

### Rem

cd "$GITCLONES"

git clone https://github.com/bodneyc/rem.git
cd rem

ln -s "$(realpath rem)" "$HOME/.local/bin/rem"

### Bak

git clone https://github.com/bodneyc/bak.git
cd bak

ln -s "$(realpath bak)" "$HOME/.local/bin/bak"

### Fonts

set +x
