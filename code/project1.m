%本代码是利用高斯滤波器得到两幅有差异性的图片的高频和低频部分，并将其进行叠加
clear
clc
%读取图片
z1=im2single(imread('cat.bmp'));
z2=im2single(imread('dog.bmp'));
sigma=10;%由于sigma的取值和频域宽度有关，故认为sigma的值代表频域的阈值
size=21;
%使用高斯滤波算子（对应的是高斯低通滤波操作）
filter=fspecial('Gaussian',size,sigma);
low1=myfilter(z1,filter);
low2=myfilter(z2,filter);
%提取出第一幅图片的高频部分
high1=z1-low1;
high2=z2-low2;
%进行两幅图像的混合
output=high1+low2;

imshow(output);
pry=vis_hybrid_image(output);
imshow(pry);
imwrite(low1,'low_m.bmp');
imwrite(high1,'high_m.bmp');
imwrite(low2,'low_e.bmp');
imwrite(high2,'high_e.bmp');
imwrite(output,'me.bmp');
