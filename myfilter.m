function output = myfilter(image, filter)
%��ȡ����ͼƬ�Ĵ�С
[I_h,I_w,c]=size(image);
%��ȡ�˲����Ĵ�С
[f_h,f_w]=size(filter);
%����һ���µ�ͼ�񻭰壬���ڴ���ԭͼ�����������
panel=zeros(I_h+f_h-1,I_w+f_w-1,c);
%��ԭͼ�����Ϣ�������»��壬��ʹ��ԭͼ������ĵ���»�������ĵ��غ�
panel((f_h-1)/2+1:end-(f_h-1)/2,(f_w-1)/2+1:end-(f_w-1)/2,:)=image;
%Ϊ�˼����˲����ֵ������һ���м��������ڴ洢�˲�����Э��ؼ���Ľ��
tmp=zeros(size(filter));
%�����˲�����
for i=1:I_h
    for j=1:I_w
        for k=1:c%����ͼƬ��rgb��Ϣ
            tmp=panel(i:i+f_h-1,j:j+f_w-1,k).*filter;
            output(i,j,k)=sum(tmp(:));%�Լ������������
        end
    end
end
