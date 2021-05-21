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

sed -i "s+<li class=\"toctree-l2\"><a class=\"reference internal\" href=\"{{BRANCHNAME}}/index.html\">{{BRANCHNAME}}</a></li></ul></li></ul></div></div></div></div><footer>+</ul></li></ul></div></div></div></div><footer>+" index.html
sed -i "s/{{BRANCHNAME}}/$INPUT_BRANCHNAME/" index.html
