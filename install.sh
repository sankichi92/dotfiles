#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

repo_root=$(
  cd "$(dirname "${BASH_SOURCE[0]}")"
  pwd
)

echo "== Setup prezto =="

git clone --recursive https://github.com/sankichi92/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/z*; do
  rcdest="${ZDOTDIR:-$HOME}/.$(basename "$rcfile")"

  if [[ -f "$rcdest" ]]; then
    mv "$rcdest" "${rcdest}_backup"
  fi

  ln -s "$rcfile" "$rcdest"
done

echo "== Setup global gitignore =="

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/git"

for name in Linux macOS VisualStudioCode; do
  curl -sSf "https://raw.githubusercontent.com/github/gitignore/main/Global/${name}.gitignore" >>"${XDG_CONFIG_HOME:-$HOME/.config}/git/ignore"
done

echo "== Setup vimrc =="

ln -s "${repo_root}/config/vim/vimrc" "$HOME/.vimrc"
