#!/bin/bash
export GIT_HASH=$(git rev-parse HEAD)
export GIT_REMOTE=$(git ls-remote --get-url)
export REPO_NAME=$(echo $GIT_REMOTE | sed -n 's#^.*github\.com[:\/]\(.*\)\.git$#\1#p')


curl -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" \
"https://api.github.com/repos/${REPO_NAME}/commits/${GIT_HASH}/statuses" 2> /dev/null | jq -r '.[] | .target_url'
