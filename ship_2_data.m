load ship_2.txt
%只改变下式右边的变量
refre=ship_2(:,2:9);
refre=sortrows(refre,1);
refsum=zeros(18281,2);
refsum(:,1)=refre(:,1);
refsum(:,2)=refre(:,2)+refre(:,4)+1i*refre(:,5)+1i*refre(:,3);
divide=zeros(181,101);
j=1;
for i =1:101:18181
   
   divide(j,:)=refsum(i:i+100,2).'; 
   j=j+1; 
end

ifft_divide=ifft(divide,101,2);
abs_ifft_divide=abs(ifft_divide);
for i =1:1:101
   a=abs_ifft_divide(i,:);
   rowsum=sum(a); 
   for j = 1:1:101
       abs_ifft_divide(i,j)=abs_ifft_divide(i,j)/rowsum;%幅度归一化
   end
   
end
% for i =1:1:101
%    a=abs_ifft_divide(i,:);
%    b=abs_ifft_divide;%复制一份，以免对齐时覆盖原值
%    rowsum=sum(a); 
%    g=0;
%    for j = 1:1:101
%        g=g+j*abs_ifft_divide(i,j)/rowsum;
%        g=round(g);%取整，以便作为索引重心
%    end
%    abs_ifft_divide(i,:)=circshift(b(i,:),51-g);%循环位移，重心法对齐
% %    for j = 1:1:101
% %        
% %        if j+g-51>101
% %            position=j+g-51-101;
% %        elseif j+g-51<1
% %            position=101-j-g+51;
% %        else
% %            position=j+g-51;
% %        end
% %            
% %        abs_ifft_divide(i,j)=b(i,position);%重心法对齐
% %    end
% end
plot(abs_ifft_divide(1,:),'k');
abs_ifft_ship_2=abs_ifft_divide;
save ship_1.mat abs_ifft_ship_2;