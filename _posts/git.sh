echo "-----commit-----"
read comm
cd ~/My_github_io/sunbuny.github.io
git add -A
git commit -m ${comm}
git push origin master
