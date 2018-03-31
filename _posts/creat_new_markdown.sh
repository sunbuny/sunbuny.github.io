echo "-----请输入文件名-----"
read filename
echo "-----请输入描述-----"
read description
echo "-----请输入归类-----"
read cate
cd ~/MyWebSite/sunbuny.github.io/_posts

touch `date +%F`"-${filename}.md"
echo  "---" >> `date +%F`"-${filename}.md"
echo  "layout: post"  >> `date +%F`"-${filename}.md"
echo  "title: ${filename}"  >> `date +%F`"-${filename}.md"
echo  "categories: ["${cate}"]"  >> `date +%F`"-${filename}.md"
echo  "tags: "[c++, 开发，Eigen]  >> `date +%F`"-${filename}.md"


echo  "redirect_from:"  >> `date +%F`"-${filename}.md"
echo  "  - "`date +'/%Y/%m/%d'`  >> `date +%F`"-${filename}.md"
echo  "---"  >> `date +%F`"-${filename}.md"
haroopad `date +%F`"-${filename}.md"
