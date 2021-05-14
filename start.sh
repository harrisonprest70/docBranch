#!/bin/bash

set -e

INPUT_BRANCHNAME=${INPUT_BRANCHNAME:-'main'}

DIR="$(dirname "${BASH_SOURCE[0]}")"

cp -r "$DIR/copytoyourdocsbranch" "$GITHUB_WORKSPACE"
mv "copytoyourdocsbranch" "upload"
cd upload 
touch .nojekyll
cd -
cp -r "docs/_build" "upload"
mv "upload/_build" "upload/$INPUT_BRANCHNAME"
