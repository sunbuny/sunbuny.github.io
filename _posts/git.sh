echo "-----commit-----"
read comm
cd ~/MyWebSite/sunbuny.github.io
git add -A
git commit -m ${comm}
git push origin master
