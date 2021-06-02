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
n=0
for i in "${array[@]}"
do
 
  if [[ ${array[n]} != "_static/" && ${array[n]} != "docs/" ]]; then
    echo "valore: ${array[n]}"
    sed -i "s+<ul></ul></li></ul></div></div></div></div><footer>+<li class=\"toctree-l2\"><a class=\"reference internal\" href=\"${array[n]}/index.html\">${array[n]}</a></li><ul></ul></li></ul></div></div></div></div><footer>+" upload/index.html
  fi
  n=$n+1
done
cat upload/index.html
