function [res] = coarse_grained(s,duration_time,param)

% s=ones(1,4); %representing (N_ge,N_gi,H_e,H_i)

ne=param.ne;
ni=param.ni;
max_pe=param.pending_e_maximum;
max_pi=param.pending_i_maximum;

p1=param.p1;
p2=param.p2;
p3=param.p3;
p4=param.p4;
p5=param.p5;
p6=param.p6;
p7=param.p7;
p8=param.p8;
p9=param.p9;
p10=param.p10;

P_e=param.S_e;
P_i=param.S_i;

lambda_e=param.lambda_e;
lambda_i=param.lambda_i;
tau_ee=param.tau_ee;
tau_ee=param.tau_ie;
tau_i=param.tau_i;
a_ee=param.a_ee;
a_ie=param.a_ie;
a_ei=param.a_ei;
a_ii=param.a_ii;

t=0;

res.spike=zeros(2,2000);
res.rec=zeros(5,1000);

count=0;

while t<= duration_time
    c=[p1(s(1)+1)/lambda_e,p2(s(2)+1)/lambda_i,p3(s(1)+1)/lambda_e,p4(s(2)+1)/lambda_i,...
        p5(s(1)+1)*a_ee/tau_ee,p6(s(2)+1)*a_ie/tau_ie,p7(s(1)+1)*a_ee/tau_ee,p8(s(2)+1)*a_ie/tau_ie,0,...
        p9(s(1)+1)*a_ei/tau_i,p10(s(2)+1)*a_ii/tau_i,0];
    q=[ne-s(1),ni-s(2),s(1),s(2),(1-s(1)/ne)*s(3),(1-s(2)/ni)*s(3),s(1)*s(3)/ne,...
        s(2)*s(3)/ni,0,s(1)*s(4)/ne,s(2)*s(4)/ni,0];
    q=q.*c;
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
    d=rand(1);
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
        if s(3)>max_pe
            s(3)=max_pe;
        end
    elseif i==4
        s(2)=s(2)-1;
        s(4)=s(4)+P_i;
        spike(2,1)=spike(2,1)+1;
        spike(2,spike(2,1)+1)=t;
        if s(4)>max_pi
            s(4)=max_pi;
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
        if s(3)>max_pe
            s(3)=max_pe;
        end
    elseif i==8
        s(2)=s(2)-1;
        s(3)=s(3)-1;
        s(4)=s(4)+P_i;
        spike(2,1)=spike(2,1)+1;
        spike(2,spike(2,1)+1)=t;
        if s(4)>max_pi
            s(4)=max_pi;
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

end

scatter(spike(1,2:spike(1,1)+1), 1*ones(1,spike(1,1)),'.','r');
hold on
scatter(spike(2,2:spike(2,1)+1), 2*ones(1,spike(2,1)),'.','b');
hold on
plot(rec(5,:),rec(1,:)/75+1.2);
hold on
plot(rec(5,:),rec(2,:)/25+1.2);
hold on
plot(rec(5,:),rec(3,:)/(r*4000));
hold on
plot(rec(5,:),rec(4,:)/(r*4000));
legend('spikes of E','spikes of I','N_{ge}/75','N_{gi}/25','H_e/20000','H_i/20000');

% hold on
% scatter(spike(2,2:spike(2,1)+1), 2*ones(1,spike(2,1)),'.','b');


    
                                    
            
    


