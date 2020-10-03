function output = myfilter(image, filter)
%提取输入图片的大小
[I_h,I_w,c]=size(image);
%提取滤波器的大小
[f_h,f_w]=size(filter);
%设立一个新的图像画板，用于处理原图像的所有像素
panel=zeros(I_h+f_h-1,I_w+f_w-1,c);
%将原图像的信息拷贝至新画板，并使得原图像的中心点和新画板的中心点重合
panel((f_h-1)/2+1:end-(f_h-1)/2,(f_w-1)/2+1:end-(f_w-1)/2,:)=image;
%为了计算滤波后的值，设立一个中间数组用于存储滤波算子协相关计算的结果
tmp=zeros(size(filter));
%进行滤波计算
for i=1:I_h
    for j=1:I_w
        for k=1:c%保留图片的rgb信息
            tmp=panel(i:i+f_h-1,j:j+f_w-1,k).*filter;
            output(i,j,k)=sum(tmp(:));%对计算结果进行求和
        end
    end
end
