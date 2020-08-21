function b=gaussian_vector(sigma,p)
b=zeros(1,169);
for i=1:169
    x=i-70+0.5;
    b(i)=exp(-(x-p)^2/(2*sigma^2))/sqrt(2*pi*sigma^2);
end
end
    