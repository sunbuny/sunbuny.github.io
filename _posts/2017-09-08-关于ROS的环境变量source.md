---
layout: post
title: "关于ROS的环境变量source"
description: "关于ROS的环境变量source."
categories: [ROS]
tags: [ROS, source]
redirect_from:
  - /2017/09/08/
---

# 关于ROS的环境变量source

最近发现一个非常有趣的事情，ros 在标准的source过程中会根据package.xml来查找依赖。也就是说会自动的将这个包所需的环境变量自动添加。

所以我写的那个小脚本就jj了。因为我是只添加了单独这个包的环境变量。