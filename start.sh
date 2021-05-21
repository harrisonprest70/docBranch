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

git fetch
git checkout origin/docs
ls

array=($(ls -d */))
echo ${array[1]} 
sed -i "s+</ul></li></ul></div></div>+<li class=\"toctree-l2\"><a class=\"reference internal\" href=\"$INPUT_BRANCHNAME/index.html\">$INPUT_BRANCHNAME</a></li></ul></li></ul></div></div>+" index.html

