#!/bin/bash
git status || exit 1
git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all
repo_name=${PWD##*/}
if [ $# -eq 1 ]; then
  repo_name=$1
fi
gh repo create eranunplugged/${repo_name} --private
git remote add github git@github.com:eranunplugged/${repo_name}.git
git push --mirror github
