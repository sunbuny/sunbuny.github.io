echo "-----commit-----"
read comm
cd ~/Src/sunbuny.github.io
git add -A
git commit -m ${comm}
git push origin master
