---
layout: post
title: "C++ Eigen库 cmake 找不到"
description: "解决Eigen库找不到的问题"
categories: [ROS]
tags: [c++, 开发，Eigen]
redirect_from:
  - /2017/09/09/
---

# C++ Eigen库 cmake 找不到
今天遇到一个小问题，就是C++的Eigen库突然在cmake的时候提醒找不到。
到另外一个ros包，同样的写法居然找得到。

```

cmake_minimum_required (VERSION 3.0)
project (myproject)
find_package (Eigen3 3.3 REQUIRED NO_MODULE)
add_executable (example example.cpp)
target_link_libraries (example Eigen3::Eigen
```
官网推荐的这种写法完全不顶事啊 ......

google查找后发现，是这样的Eigen库是一个只有头文件的库，完全不需要做find_package操作可以直接使用cmake环境变量
```
INCLUDE_DIRECTORIES ( "$ENV{EIGEN3_INCLUDE_DIR}" )
```
或者：
```
SET( EIGEN3_INCLUDE_DIR "$ENV{EIGEN3_INCLUDE_DIR}" )
IF( NOT EIGEN3_INCLUDE_DIR )
    MESSAGE( FATAL_ERROR "Please point the environment variable EIGEN3_INCLUDE_DIR to the include directory of your Eigen3 installation.")
ENDIF()
INCLUDE_DIRECTORIES ( "${EIGEN3_INCLUDE_DIR}" )
```
参考：
https://stackoverflow.com/questions/12249140/find-package-eigen3-for-cmake































