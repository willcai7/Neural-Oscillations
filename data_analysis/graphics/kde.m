%data is a matrix representing several d-dimension samples. h is convolution
%kernel width. n is grid size.
function [x,y,z,val]=kde(data,h,n)
data=data';
max_point=max(data)+0.5;
min_point=min(data)-0.5;
edge=max_point-min_point;
data=data';
d=size(data);
N=d(2); %N is sample sivale
d=d(1);


grid=zeros(d,n+1);
gsize=edge/n;

for i=1:d
    grid(i,:)=(max_point(i)-edge(i):gsize(i):max_point(i));
end

if d==2
    val=zeros(n+1,n+1);
    x=zeros(n+1,n+1);
    y=zeros(n+1,n+1);
    z=zeros(n+1,n+1);
    for i=1:n+1
        for j=1:n+1
            x1=grid(1,i);
            x2=grid(2,j);
            x(i,j)=x1;
            y(i,j)=x2;
            x1=(data(1,:)-x1)/h;
            x2=(data(2,:)-x2)/h;
            val(i,j)=sum(exp(-x1.^2/2).*exp(-x2.^2/2))/N/h^2/(2*pi);
        end
    end
    
elseif d==3
    val=zeros(n+1,n+1,n+1);
    x=zeros(n+1,n+1,n+1);
    y=zeros(n+1,n+1,n+1);
    z=zeros(n+1,n+1,n+1);
    for i=1:n+1
        for j=1:n+1
            for k=1:n+1
                x1=grid(1,i);
                x2=grid(2,j);
                x3=grid(3,k);
                x(i,j,k)=x1;
                y(i,j,k)=x2;
                z(i,j,k)=x3;
                x1=(data(1,:)-x1)/h;
                x2=(data(2,:)-x2)/h;
                x3=(data(3,:)-x3)/h;
                val(i,j,k)=sum(exp(-x1.^2/2).*exp(-x2.^2/2).*exp(-x3.^2/2))/N/h^3/((2*pi)^1.5);
            end
        end
    end
end

% if d==2
%     subplot(1,2,1)
%     mesh(grid(1,:),grid(2,:),val');
%     subplot(1,2,2)
%     imagesc(val');
% end




    
    
    
