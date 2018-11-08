---
layout: post
title: 在Clion用gdb运查看cvMat
categories: [opencv]
tags: [c++, 开发，Eigen]
redirect_from:
  - /2018/11/08
---
# 在Clion用gdb运查看cvMat
我们在编写opencv程序的时候，常常会使用imshow来debug程序。但是有的时候imshow不能随便在程序中插入，而其这样写的话会比较麻烦。那么有没有什么办法在debug的时候，直接查看cvMat变量。一番搜索过发现确实有解决方法的。
首先我们去[github](https://github.com/renatoGarcia/gdb-imshow)下载这个项目。
但是我们要把它整合到clion中去。方法是差不多的。
首先在home目录下面创建.gdbinit文件。
然后填入如下代码
```
source /PATH TO/cv_imshow.py
```
但是现在还是不能在clion的gdb中使用的。我们直接点击gdb会报错。就是找不到PIL什么的。那装一下PIL就好了嘛？
没那么简单，gbb调用的python不是我们系统里的任何一个python版本，是gdb自己整合的一个版本。但是它留了这个文件夹可以放置第三方库。
> clion-2017.2.3/bin/gdb/linux/lib/python3.6/site-packages

OK，我们把PIL拷过来就完了，但是pil会提示找不到一些so文件。具体原因我也不清楚。我把
```
_imaging-xxxx.so -> _imaging.so 

```
修改一下动态链接库名称就好了。这样我们就可以愉快的在gdb中输入cv_imshow来查看cvMat了。

refer to:
https://github.com/renatoGarcia/gdb-imshow
