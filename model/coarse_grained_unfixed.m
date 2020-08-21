% res=load('res7');
% res=res.res6;
% PDF_e=histogram(res.V_e,[-69:1:100],'normalization','probability');
% PDF_e=PDF_e.Values;
% close;
% PDF_i=histogram(res.V_i,[-69:1:100],'normalization','probability');
% PDF_i=PDF_i.Values;
% close;

PDF_e=gaussian_vector(10.5402,-1.7394);
PDF_i=gaussian_vector(13.3019,-2.0295);


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
    

    









s=ones(1,4); %representing (N_ge,N_gi,H_e,H_i)

 c=0.3;
 r=100;
 p1=p1*c;%p^ext_bge
 p2=p2*c;%p^ext_bgi
 p3=p3;%p^ext_gsbe
 p4=p4;%p^ext_gsbi
 p5=p5*c;%p^pe_bge
 p6=p6*c;%p^pe_bgi



P_e=24;
P_i=48;

lambda_e=1/7;
lambda_i=1/7;
tau_ee=2;
tau_ie=1.2;
tau_i=4.5;
a_ee=0.6;
a_ie=0.4;
a_ei=0.79;
a_ii=0.21;





t=0;
duration_time=1000;
spike=zeros(2,2000);


rec=zeros(5,1000);
count=0;

while t<= duration_time
    c=[p1(s(1)+1)/lambda_e,p2(s(2)+1)/lambda_i,p3(s(1)+1)/lambda_e,p4(s(2)+1)/lambda_i,...
        p5(s(1)+1)*a_ee/tau_ee,p6(s(2)+1)*a_ie/tau_ie,p7(s(1)+1)*a_ee/tau_ee,p8(s(2)+1)*a_ie/tau_ie,0,...
        p9(s(1)+1)*a_ei/tau_i,p10(s(2)+1)*a_ii/tau_i,0];
    q=[75-s(1),25-s(2),s(1),s(2),(1-s(1)/75)*s(3),(1-s(2)/25)*s(3),s(1)*s(3)/75,...
        s(2)*s(3)/25,0,s(1)*s(4)/75,s(2)*s(4)/25,0];
    q=q.*c; %q就是这一步所需要的q矩阵的元（那十二个）
    q(9)=q(5)*(1-p5(s(1)+1))/p5(s(1)+1)+q(6)*(1-p6(s(2)+1))/p6(s(2)+1)...
        +q(7)*(1-p7(s(1)+1))/p7(s(1)+1)+q(8)*(1-p8(s(2)+1))/p8(s(2)+1);
    q(12)=s(4)/tau_i-q(10)-q(11);
    dt=exprnd(1/sum(q));
    t=t+dt;
    if floor(t)-floor((t-dt))==1
        count=count+1;
        rec(:,count)=[s,t-dt]';
    end
    q=q/sum(q);
    d=rand(1);%用的就是一个指数分布一个均匀分布找位置
    per=q(1);
    i=1;
    while per<d
        i=i+1;
        per=per+q(i);
    end
    if i==1
        s(1)=s(1)+1;
    elseif i==2
        s(2)=s(2)+1;
    elseif i==3
        s(1)=s(1)-1;
        s(3)=s(3)+P_e;
        spike(1,1)=spike(1,1)+1;
        spike(1,spike(1,1)+1)=t;
        if s(3)>r*2000
            s(3)=r*2000;
        end
    elseif i==4
        s(2)=s(2)-1;
        s(4)=s(4)+P_i;
        spike(2,1)=spike(2,1)+1;
        spike(2,spike(2,1)+1)=t;
        if s(4)>r*4000
            s(4)=r*4000;
        end
    elseif i==5
        s(1)=s(1)+1;
        s(3)=s(3)-1;
    elseif i==6
        s(2)=s(2)+1;
        s(3)=s(3)-1;
    elseif i==7
        s(1)=s(1)-1;
        s(3)=s(3)-1+P_e;
        spike(1,1)=spike(1,1)+1;
        spike(1,spike(1,1)+1)=t;
        if s(3)>r*2000
            s(3)=r*2000;
        end
    elseif i==8
        s(2)=s(2)-1;
        s(3)=s(3)-1;
        s(4)=s(4)+P_i;
        spike(2,1)=spike(2,1)+1;
        spike(2,spike(2,1)+1)=t;
        if s(4)>r*4000
            s(4)=r*4000;
        end
    elseif i==9
        s(3)=s(3)-1;
    elseif i==10
        s(1)=s(1)-1;
        s(4)=s(4)-1;
    elseif i==11
        s(2)=s(2)-1;
        s(4)=s(4)-1;
    elseif i==12
        s(4)=s(4)-1;
    end
end



% hold on
% scatter(spike(2,2:spike(2,1)+1), 2*ones(1,spike(2,1)),'.','b');


    
                                    
            
    


