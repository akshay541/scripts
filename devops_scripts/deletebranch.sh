#!/bin/zsh

echo "Available branches:"
# Define protected branches
protected_branches=("master" "main")

# Select branch using fzf
branch=$(git branch --list --format="%(refname:short)" | sed '/^\*/d' | fzf)

# Check if the selected branch is a protected branch
if [[ " ${protected_branches[@]} " =~ " ${branch} " ]]; then
  echo "Error: Attempt to delete a protected branch ('${branch}') aborted."
else
  if [[ -n $branch ]]; then
    git branch -d $branch
    if [[ $? -eq 0 ]]; then
      echo "Branch '$branch' deleted successfully."
    else
      echo "Failed to delete branch '$branch'. It may not be fully merged."
    fi
  else
    echo "No branch selected."
  fi
fi


