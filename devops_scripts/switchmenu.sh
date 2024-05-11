#!/bin/zsh
echo "Available branches:"
branch=$(git branch --list --format="%(refname:short)" | sed '/^\*/d' | fzf)
if [[ -n $branch ]]; then
  git switch $branch
else
  echo "No branch selected."
fi

