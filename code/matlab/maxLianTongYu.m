%���룺I    ����ͼ��
%�����img  �����������ͨ���ͼ�� 
function [img]=maxLianTongYu(I)
if length(size(I))>2
    I = rgb2gray(I);
end
if ~islogical(I)
    imBw = im2bw(I);                        %ת��Ϊ��ֵ��ͼ��
else
    imBw = I;
end
% imBw = im2bw(I);                        %ת��Ϊ��ֵ��ͼ��
imLabel = bwlabel(imBw);                %�Ը���ͨ����б��
stats = regionprops(imLabel,'Area');    %�����ͨ��Ĵ�С
area = cat(1,stats.Area);
index = find(area == max(area));        %�������ͨ�������
img = ismember(imLabel,index);          %��ȡ�����ͨ��ͼ��