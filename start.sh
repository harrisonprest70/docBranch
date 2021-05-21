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

git checkout origin/main
echo ${array[1]} 
n=0
while [[ $(array[n]) != "" ]]
do
  sed -i "s+</ul></li></ul></div></div>+<li class=\"toctree-l2\"><a class=\"reference internal\" href=\"$(array[n])/index.html\">$(array[n])</a></li></ul></li></ul></div></div>+" upload/index.html
done
