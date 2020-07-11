# bilinear
Bilinear interpolation realizes image scaling based on FPGA

# python目录

trans.py为python实现的双线性插值算法

merge.py为基于python的对FPGA仿真处理后的数据的处理，即对R，G，B的合成。

# matlab目录

RGB.m为对原始图像的RGB分离

# verilog目录

bilinear.v为顶层模块

coordinate_trans.v为坐标变换模块

mem_control.v为内存管理模块

# 模块框图

![image-20200711152658739](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20200711152658739.png)

