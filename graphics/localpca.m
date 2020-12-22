%local PCA
%This function computes the percentage of the sum of the first d singular
%values of the neigborhood matrix of each point;
%The input x is D x N matrix, where D denotes dimensionality.
%The ouput y is the percentage of each point with the same order of X.
function y = localpca(X,K)
[D,N] = size(X);
y=zeros(1,N);
X2 = sum(X.^2,1);
distance = repmat(X2,N,1)+repmat(X2',1,N)-2*X'*X;

[sorted,index] = sort(distance);

neighborhood = index(2:(1+K),:);

for i = 1:N
    z = X(:,neighborhood(:,i))-mean(X(:,neighborhood(:,i)),2);
    s=svd(z);
    s=s.^2;
    y(i)=sum(s)^2/sum(s.^2);
end

end
