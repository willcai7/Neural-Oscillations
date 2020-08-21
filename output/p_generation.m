res=load('res7');
res=res.res6;
PDF_e=histogram(res.V_e,[-69:1:100],'normalization','probability');
PDF_e=PDF_e.Values;
close;
PDF_i=histogram(res.V_i,[-69:1:100],'normalization','probability');
PDF_i=PDF_i.Values;
close;


p1=zeros(1,76); %N_g = 0,1,2,...,75
p2=zeros(1,26);
p3=zeros(1,76);
p4=zeros(1,26);
p5=zeros(1,76);
p6=zeros(1,26);
p7=ones(1,76);
p8=zeros(1,26);
p9=ones(1,76);
p10=ones(1,26);


for i=1:76
    j=169;
    count=0;
    if i==1 
        lim=0.5/75; %N_g = 0 时设成0.5（不然直接全是0了）
    else
        lim=(i-1)/75;
    end
    while count<lim && j>1
        count=count+PDF_e(j);
        j=j-1;
    end
    p1(i)=PDF_e(j)/(1-count);
    p3(i)=sum(PDF_e(min(j+23,169):169))/count;
    p5(i)=sum(PDF_e(max(j-23,1):j))/(1-count);
end

for i=1:26
    j=169;
    count=0;
    if i==1
        lim=0.5/25;
    else
        lim=(i-1)/25;
    end
    while count<lim && j>1
        count=count+PDF_i(j);
        j=j-1;
    end
    p2(i)=PDF_i(j)/(1-count);
    p4(i)=sum(PDF_i(min(j+23,169):169))/count;
    p6(i)=sum(PDF_i(max(j-11,1):j))/(1-count);
    p8(i)=sum(PDF_i(min(j+12,169):169))/count;
end
    