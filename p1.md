#### 一、实验项目名称：

图像的滤波与融合

#### 二、实验原理：

通过傅里叶变换对图像进行滤波处理，再叠加两个图像的高、低频部分对图像进行融合

#### 三、实验目的：

对不同图像分别进行高通和低通滤波，融合图片

#### 四、实验内容：

实验主要分为四个步骤：图像选取、图像过滤、滤波操作、高低分量叠加。

（1）图像选取

选取两幅大小一致的图像，最好是频率上有较大差别。本次选取了data文件夹中marilyn.bmp和einstein.bmp两幅图片进行融合实验。

【图1】marilyn.bmp

【图2】einstein.bmp

（2）图像过滤

这一步骤的目的是去除图像中大于或小于某一频率的分量，经查询可以使用matlab中的fspecial函数，实现对图像高频、低频分量的提取。该函数当设置类型为'gaussian'时可作为高斯低通滤波器，得到图像中频率低于某个阈值的部分。

根据MATLAB Help Center的文档，fspecial函数使用方法如下：

h = fspecial(type,parameters,sigma)

*参数type制定算子类型

*parameters指定相应的参数

*type= 'gaussian'，为高斯低通滤波器，参数有两个，n表示模版尺寸，默认值为[3,3]，sigma表示滤波器的标准差，单位为像素，默认值为0.5。

*Example:`h = fspecial('gaussian',hsize,sigma)` returns a rotationally symmetric Gaussian lowpass filter of size `hsize` with standard deviation `sigma`. 

（3）进行滤波操作

滤波的表达式如下所示：

![img](file:///C:/Users/cy/AppData/Local/Temp/msohtmlclip1/01/clip_image002.png)

*h：滤波后的图像

*f：滤波算子

*I：原始图像

如下图所示：

【图3】滤波示意图

![1587565861805](D:\typora_photo\1587565861805.png)

（4）高低分量叠加

本实验中将marilyn的高频部分与einstein的低频部分进行叠加。

由于本次实验使用的是高斯低通滤波器，因此marilyn的高频部分由原图像减去低频部分得到。

最终得到marilyn的高频部分与einstein的低频部分后将他们相加即可。

#### 五、实验步骤：

matlab代码实现如下：

（1）主函数部分

```matlab
clear
clc

m1=im2double(imread('marilyn.bmp'));%读取图片
m2=im2double(imread('einstein.bmp'));
sigma=40;%sigma-频率的阈值，参数可设置
size=81;%size-滤波器大小，参数可设置（需为奇数）

filter=fspecial('Gaussian',size,sigma);%用高斯滤波器进行滤波操作
low1=myfilter(m1,filter);%得到低频部分
low2=myfilter(m2,filter);

high1=m1-low1;%通过减法得到高频部分
high2=m2-low2;

output=high1+low2;%进行两幅图像的混合

imshow(output);%展示并保存图像
imwrite(low1,'low_m.bmp');
imwrite(high1,'high_m.bmp');
imwrite(low2,'low_e.bmp');
imwrite(high2,'high_e.bmp');
imwrite(output,'me.bmp');
```

```matlab
（2）myfilter子函数部分
function output = myfilter(image, filter)

[I_h,I_w,c]=size(image);%获得原始图片的大小
[f_h,f_w]=size(filter);%获得滤波器的大小

panel=zeros(I_h+f_h-1,I_w+f_w-1,c);%初始化一个矩阵用于存储结果

%先将原图像的信息拷贝至新矩阵，方便计算
panel((f_h-1)/2+1:end-(f_h-1)/2,(f_w-1)/2+1:end-(f_w-1)/2,:)=image;

tmp=zeros(size(filter));%初始化一个和滤波算子同样大小的矩阵，暂时存储滤波器计算结果

%进行滤波计算
for i=1:I_h
    for j=1:I_w
        for k=1:c%保留图片的rgb信息
            tmp=panel(i:i+f_h-1,j:j+f_w-1,k).*filter;
            output(i,j,k)=sum(tmp(:));%求和并放到output
        end
    end
end

```



#### 六、实验数据及结果分析：

（1）设置参数sigma=10，size=21，运行结果如下：

![1587567279789](D:\typora_photo\1587567279789.png)

可见高频部分主要保留了原图的头发，眼睛，衣服等高光细节，而低频部分较为模糊，主要保留了图片的轮廓信息。而融合结果既有Einstein的衣服部分，也有Marilyn的眼睛，头发部分，实现了这两张图片的融合。

（2）控制size值一定（size=21），调整sigma大小，运行结果如下：

![1587568088207](D:\typora_photo\1587568088207.png)

![1587568204869](D:\typora_photo\1587568204869.png)

结果显示，随着sigma的增大，保留的低频部分越多，低频图像越模糊；作为高频部分的Marilyn在融合结果中更明显。

（3）控制sigma值一定，调节size大小，运行结果如下：

![1587569085609](D:\typora_photo\1587569085609.png)

![1587569074693](D:\typora_photo\1587569074693.png)

可见，随着滤波器size的增大，低频图像越来越模糊，作为高频部分的Marilyn在融合结果中更明显。



#### 七、实验结论：

本次实验实现了对两个图片不同频率部分的滤波和融合操作，且随着sigma的增大和size的增大，作为高频部分的Marilyn在融合结果中更明显。



#### 八、总结及心得体会：

本次实验主要分为四个步骤：图像选取、图像滤波、进行滤波操作、高低分量叠加。即首先选取两幅大小一致，频率上有较大差别的图像。接着利用matlab中的fspecial函数去除图像中大于或小于某一频率的分量，实现对高频、低频分量的提取。接下来用滤波算子进行滤波操作。最后将得到的Marilyn高频分量与Einstein的低频部分融合得到结果。本次实验中有两个变量sigma和size，对于他们的作用一开始只是在ppt中有所了解，而本次实验用实验结果对他们有了更深入的认识。此外，也认识到了做实验不能只做一次，应当进行控制变量对变量的作用进行研究和分析。



#### 九、对本实验过程及方法的改进建议：

之前使用了自己的myfilter函数实现滤波，而matlab提供的库函数imfilter可以直接实现对图像进行高斯滤波。

imfilter函数的文档中介绍了用法：

`B = imfilter(A,h)` filters the multidimensional array `A` with the multidimensional filter `h` and returns the result in `B`.

修改后代码如下：

```matlab
clear
clc
m1=im2double(imread('marilyn.bmp'));%读取两张图片
m2=im2double(imread('einstein.bmp'));

size=21;%参数设置为与之前一样的
sigma=10;
filter=fspecial('Gaussian',size,sigma);

%对图片1的RGB三个通道分别进行滤波操作
R1=imfilter(z1(:,:,1),filter);
G1=imfilter(z1(:,:,2),filter);
B1=imfilter(z1(:,:,3),filter);

low1=mari(3,R1,G1,B1);%得到m的低频分量
high1=z1-low1;%得到m的高频分量

%对图片2的RGB三个通道分别进行滤波操作
R2=imfilter(z2(:,:,1),filter);
G2=imfilter(z2(:,:,2),filter);
B2=imfilter(z2(:,:,3),filter);

low2=ein(3,R2,G2,B2);%得到e的低频分量
high2=z2-low2;%得到e的高频分量

%进行图片融合
output=high1+low2;
imshow(output);
imwrite(output,'me.bmp');
imwrite(low1,'low_m.bmp');
imwrite(high1,'high_m.bmp');
imwrite(low2,'low_e.bmp');
imwrite(high2,'high_e.bmp');

```

设置参数size=21,sigma=10，得到结果如下：

![1587617409347](D:\typora_photo\1587617409347.png)



与之前使用myfilter函数的结果对比，他们实现的效果相同，因而这个方法也成功实现了两张图片的融合。

---------

修改部分：

从图像金字塔中可以看到，大的图片和小的图片观测的效果不一样，也就是融合后的图片从远处看和从近处看的效果不一样。具体来说就是，从远处看（图像变小）低频部分就越明显，从近处看（图像变大） 高频部分越明显。我认为这是因为低频部分是图片的大体框架，而高频部分是图片的细节与噪声，经历低通滤波的图像被进行了模糊处理，经过高通滤波的图片被进行了边缘锐化。当图片缩小时，边缘细节会丢失而大体框架能得到更好的保留，因而图片缩小时看起来更像低频的原图。当图片放大时，更多的细节能被留下来，因而高频的部分作用更为显著。



