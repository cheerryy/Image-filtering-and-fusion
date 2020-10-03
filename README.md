# Image-filtering-and-fusion

详细内容可见word文件

##### 1 实验目的

- 通过高斯滤波器对两张同样大小的图像进行滤波处理，一个保留高频一个保留低频
- 叠加两个图像的高、低频部分以对图像进行融合，形成一张远近观察效果会不同的图像
- 使用了图像金字塔的方式模拟远近观察的效果

##### 2 代码结构

- myfilter.m：输入某张图片和要使用的滤波器，得到滤波后的结果

- vis_hybrid_image.m：输入融合后的图片，得到图像金字塔

- project1.m：主函数，输入两张大小相同的图片，得到图像金字塔和融合结果

##### 3 使用方法

- 将3个.m文件及大小相同的图片放入matlab的路径中
- 运行project1.m文件

##### 3 工作原理

###### 3.1 滤波器

这一步骤的目的是去除图像中大于或小于某一频率的分量，可以使用matlab中的fspecial函数，实现对图像高频、低频分量的提取。
该函数当设置类型为'gaussian'时可作为高斯低通滤波器，得到图像中频率低于某个阈值的部分。

根据MATLAB Help Center的文档，fspecial函数使用方法如下：
$h = fspecial(type,parameters,sigma)$
参数：
- *type：制定算子类型，type= 'gaussian'时为高斯低通滤波器*

- *parameters：指定相应的参数*

- *sigma：表示滤波器的标准差，单位为像素，默认值为0.5。*

  

- *例如: h= fspecial('gaussian',hsize,sigma) returns a rotationally symmetric Gaussian lowpass filter of size hsize with standard deviation sigma.* 



###### 3.2 滤波

滤波的表达式如下所示：

![image](https://github.com/cheerryy/Image-filtering-and-fusion/blob/main/ImagesForREADME/2.png)

- *h：滤波后的图像*
- *f：滤波算子*
- *I：原始图像*

![image](https://github.com/cheerryy/Image-filtering-and-fusion/blob/main/ImagesForREADME/11.png)

##### 4 实验结果

将爱因斯坦的低频部分与梦露的高频部分融合，结果如下：

![image](https://github.com/cheerryy/Image-filtering-and-fusion/blob/main/ImagesForREADME/33.png)

图像金字塔如下：

![image](https://github.com/cheerryy/Image-filtering-and-fusion/blob/main/ImagesForREADME/44.png)
