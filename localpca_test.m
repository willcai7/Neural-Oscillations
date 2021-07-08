load('trajectory_info_selected');
X=trajectory_info_selected;

X(1,:)=X(1,:)/max(X(1,:));
X(2,:)=X(2,:)/max(X(2,:));
X(3,:)=X(3,:)/max(X(3,:));
X(4,:)=X(4,:)/max(X(4,:));

K=3000;
[D,N] = size(X);
y=zeros(1,N);
X2 = sum(X.^2,1);
distance = repmat(X2,N,1)+repmat(X2',1,N)-2*X'*X;
size(distance)
[sorted,index] = sort(distance);
neighborhood = index(2:(1+K),:);
n_neighborhood = index(K+2:N-1,:);

i=15000;

z = X(:,neighborhood(:,i))-mean(X(:,neighborhood(:,i)),2);
s=svd(z);
s=s.^2
% scatter3(X(3,neighborhood(:,i)),X(4,neighborhood(:,i)),X(1,neighborhood(:,i)),5,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% hold on
% scatter3(X(3,n_neighborhood(:,i)),X(4,n_neighborhood(:,i)),X(1,n_neighborhood(:,i)),5,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);