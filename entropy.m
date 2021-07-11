function s=entropy(tra,size)
tra=(tra-min(tra,[],2)+0.00001)./(max(tra,[],2)-min(tra,[],2)+0.00001);
d=1./size;
val=zeros(size(1),size(2),size(3),size(4));
for i=1:length(tra)
    val(ceil(tra(1,i)/d(1)),ceil(tra(2,i)/d(2)),ceil(tra(3,i)/d(3)),ceil(tra(4,i)/d(4)))...
        =val(ceil(tra(1,i)/d(1)),ceil(tra(2,i)/d(2)),ceil(tra(3,i)/d(3)),ceil(tra(4,i)/d(4)))+1;
end
val=val/sum(sum(sum(sum(val))));
val=val(find(val~=0));
s=sum(-val.*log2(val));
end