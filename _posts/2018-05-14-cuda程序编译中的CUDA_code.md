---
layout: post
title: cuda程序编译中的CUDA code
categories: [cuda]
tags: [c++, 开发，Eigen]
redirect_from:
  - /2018/05/14
---

* Kramdown table of contents
{:toc .toc}

```
Error: invalid texture reference
```
  
Source and Assembly  
上述是我最近在使用一个pose estimation库编译cuda时出现的错误。  
查阅资料后发现，是nvcc编译选项的问题。[参考资料](https://github.com/mp3guy/ElasticFusion/issues/52)
编译CUDA代码，我们通常需要指定我们的代码需要运行在那个gpu架构上面。这里通常会涉及三个选项，`-arch`，`-code`，`-gencode`。  
解释一下这三个参数，这涉及到CUDA架构的两层结构。第一层，高层次PTX(Parallel Thread Execution)架构，其作为一种虚拟机。第二层，产生配合低层级的GPU架构的特性的汇编代码。  
在第一阶段，编译器寻找一些高层级的特征，这些特征被虚拟PTX架构支持，并且为这些特性创建高层级的代码。第二阶段，编译器将PTX代码翻译成SASS代码，这些代码会针对特定的低层级GPU架构。  

## arch
这个代码会告诉编译器，其将会运行在那种PTX架构，这是在编译的第一阶段。PTX架构是用类似于`compute_xy`的代码来指定的。这里的`xy`是指定的架构版本号。  
举个例子：  
```
-arch=compute_35
```
这可以让编译器生成针对sm_35GPU的PTX代码。  
如果想指定GPU型号：  
```
-arch=sm_35
```
这样编译器就会生成只针对`sm_35`的SASS代码。

## code
这个代码会告诉编译器，在第二阶段生成的SASS代码将会运行在哪个GPU上。他会针对这个GPU架构来选择合适的PTX架构。  
举个例子：  
```
-code=sm_21
```
这样编译器会生产只在sm_21的GPU运行的SASS代码。

## gencode
这个代码会生成针对多种GPU的代码。
举个例子：  
```
-gencode -gencode arch=compute_20,code=compute_20 -gencode arch=compute_35,code=sm_35
```
## 针对不同GPU的设置
## Supported SM and Gencode variations
Below are the supported sm variations and sample cards from that generation

### Supported on CUDA 7 and later
- Fermi (CUDA 3.2 and later, deprecated from CUDA 9):
  - SM20 or SM_20, compute_30 – Older cards such as GeForce 400, 500, 600, GT-630
- Kepler (CUDA 5 and later):
 - SM30 or SM_30, compute_30 – Kepler architecture (generic – Tesla K40/K80, GeForce 700, GT-730)  Adds support for unified memory programming
 - SM35 or SM_35, compute_35 – More specific Tesla K40  Adds support for dynamic parallelism. Shows no real benefit over SM30 in my experience.
 - SM37 or SM_37, compute_37 – More specific Tesla K80  Adds a few more registers. Shows no real benefit over SM30 in my experience
- Maxwell (CUDA 6 and later):
 - SM50 or SM_50, compute_50 – Tesla/Quadro M series
 - SM52 or SM_52, compute_52 – Quadro M6000 , GeForce 900, GTX-970, GTX-980, GTX Titan X
 - SM53 or SM_53, compute_53 – Tegra (Jetson) TX1 / Tegra X1
- Pascal (CUDA 8 and later)
 - SM60 or SM_60, compute_60 – GP100/Tesla P100 – DGX-1 (Generic Pascal)
 - SM61 or SM_61, compute_61 – GTX 1080, GTX 1070, GTX 1060, GTX 1050, GTX 1030, Titan Xp, Tesla P40, Tesla P4
 - SM62 or SM_62, compute_62 – Drive-PX2, Tegra (Jetson) TX2, Denver-based GPU
- Volta (CUDA 9 and later)
 - SM70 or SM_70, compute_70 – Tesla V100
 - SM71 or SM_71, compute_71 – probably not implemented
 - SM72 or SM_72, compute_72 – currently unknown

## Sample flags
According to NVIDIA:
> The arch= clause of the -gencode= command-line option to nvcc specifies the front-end compilation target and must always be a PTX version. The code= clause specifies the back-end compilation target and can either be cubin or PTX or both. Only the back-end target version(s) specified by the code= clause will be retained in the resulting binary; at least one must be PTX to provide Volta compatibility.

Sample flags for generation on CUDA 7 for maximum compatibility:
```
-arch=sm_30 \
 -gencode=arch=compute_20,code=sm_20 \
 -gencode=arch=compute_30,code=sm_30 \
 -gencode=arch=compute_50,code=sm_50 \
 -gencode=arch=compute_52,code=sm_52 \
 -gencode=arch=compute_52,code=compute_52
```
Sample flags for generation on CUDA 8 for maximum compatibility:
```
-arch=sm_30 \
 -gencode=arch=compute_20,code=sm_20 \
 -gencode=arch=compute_30,code=sm_30 \
 -gencode=arch=compute_50,code=sm_50 \
 -gencode=arch=compute_52,code=sm_52 \
 -gencode=arch=compute_60,code=sm_60 \
 -gencode=arch=compute_61,code=sm_61 \
 -gencode=arch=compute_61,code=compute_61
```
Sample flags for generation on CUDA 9 for maximum compatibility. Note the removed SM_20:
```
-arch=sm_30 \
 -gencode=arch=compute_30,code=sm_30 \
 -gencode=arch=compute_50,code=sm_50 \
 -gencode=arch=compute_52,code=sm_52 \
 -gencode=arch=compute_60,code=sm_60 \
 -gencode=arch=compute_61,code=sm_61 \
 -gencode=arch=compute_62,code=sm_62 \
 -gencode=arch=compute_70,code=sm_70 \
 -gencode=arch=compute_70,code=compute_70
```

## refer to
[Matching SM architectures (CUDA arch and CUDA gencode) for various NVIDIA cards](http://arnon.dk/matching-sm-architectures-arch-and-gencode-for-various-nvidia-cards/)
[How to specify architecture to compile CUDA code](https://codeyarns.com/2014/03/03/how-to-specify-architecture-to-compile-cuda-code/)