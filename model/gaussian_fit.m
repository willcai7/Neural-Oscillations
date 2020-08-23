function [sigma,p]=gaussian_fit(a)
%index-70+0.5 is real position.
[h,p]=max(a);
p=p-70+0.5;
sigma=1/h/sqrt(2*pi);
r=0.1;
for i=1:100000
    ds=(norm(a-gaussian_vector(sigma+0.0001,p))-norm(a-gaussian_vector(sigma,p)))/0.0001;
    dp=(norm(a-gaussian_vector(sigma,p+0.0001))-norm(a-gaussian_vector(sigma,p)))/0.0001;
    sigma=sigma-r*ds;
    p=p-r*dp;
end
bar([-68.5:1:99.5],a);
hold on
plot([-68.5:1:99.5],gaussian_vector(sigma,p));
end
