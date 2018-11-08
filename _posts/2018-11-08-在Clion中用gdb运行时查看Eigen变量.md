---
layout: post
title: 在Clion中用gdb运行时查看Eigen变量
categories: []
tags: [c++, 开发，Eigen]
redirect_from:
  - /2018/11/08
---

# 在Clion中用gdb运行时查看Eigen变量
我们在开发的时候常常会使用到Eigen库，但是我们在debug的时候发现Eigen的vector或者matrix变量在gdb中打印出来都是不能阅读的。而且特别在clion中Eigen的解析非常的慢，这就导致开发的时候不开心。

所幸地是有一些辅助工具可以帮助我们方便得对Eigen的变量进行debug。
我推荐[drake_gdb](https://github.com/SeanCurtis-TRI/drake_gdb) ，主要是其与clion配合比较好
安装方式就不写了，其项目readme写了。


