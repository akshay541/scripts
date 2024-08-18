#!/bin/bash

# Step 1: Make the script executable (no need to do it within the script itself)

# Step 2: Define an associative array of Git aliases
declare -A git_aliases=(
    [cfg]='!git config --global -e'
    [pl]='pull'
    [ps]='push -u origin HEAD'
    [ck]='checkout'
    [b]='branch'
    [st]='status -s'
    [l]='!git log --graph --decorate --pretty=oneline --abbrev-commit --all | less -R'
    [rbi]='rebase -i'
    [rbm]='rebase main'
    [sw]='!~/Desktop/Devops/git-codebases/scripts/devops_scripts/switchmenu.sh'
    [db]='!~/Desktop/Devops/git-codebases/scripts/devops_scripts/deletebranch.sh'
    [a]='add -A'
    [cm]='commit -m'
    [acm]='!git add -A && git commit -m'
    [rnb]='branch -m'
    [i]='init'
    [ra]='remote add'
    [rr]='remote remove'
    [rv]='remote -v'
)

# Step 3: Function to set a Git alias
set_git_alias() {
    alias_name=$1
    alias_command=$2

    # Attempt to set the Git alias
    if git config --global alias."$alias_name" "$alias_command"; then
        echo "Alias '$alias_name' set successfully."
    else
        echo "Failed to set alias '$alias_name'."
    fi
}

# Step 4: Loop through the aliases and set them
for alias_name in "${!git_aliases[@]}"; do
    set_git_alias "$alias_name" "${git_aliases[$alias_name]}"
done

echo "Git aliases configuration complete!"

# Step 5: Verify by printing all Git aliases
echo -e "\nConfigured Git Aliases:"
git config --global --get-regexp '^alias\.' | awk '{print $1}' | sed 's/alias\.//'
