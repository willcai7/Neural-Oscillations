function [res] = model_coarse_grained2(s, param,P)

ne=param.ne;
ni=param.ni;
max_pe=param.pending_e_maximum;
max_pi=param.pending_i_maximum;
duration_time = param.duration;
P_BE_Ex=P.P_BE_Ex;
P_BI_Ex=P.P_BI_Ex;
P_GE_Ex=P.P_GE_Ex;
P_GI_Ex=P.P_GI_Ex;
P_BE_E=P.P_BE_E;
P_BI_E=P.P_BI_E;
P_GE_E=P.P_BE_E;
P_GI_E=P.P_GI_E;
P_GE_I=P.P_GE_I;
P_GI_I=P.P_GI_I;

P_ee=param.S_ee;
P_ie=param.S_ie;
P_i=param.S_i;

lambda_e=param.lambda_e;
lambda_i=param.lambda_i;
tau_ee=param.tau_ee;
tau_ie=param.tau_ie;
tau_i=param.tau_i;

a_ei=param.a_ei;
a_ii=param.a_ii;

t=0;

res.spike = zeros(2,4000);
res.rec   = zeros(6,900);

count=0;
count_oper=zeros(2,15);

while t<= duration_time
    c=[P_BE_Ex(s(1)+1)/lambda_e, P_BI_Ex(s(2)+1)/lambda_i,P_GE_Ex(s(1)+1)/lambda_e,P_GI_Ex(s(2)+1)/lambda_i,0,...
        P_BE_E(s(1)+1)/tau_ee, P_BI_E(s(2)+1)/tau_ie,P_GE_E(s(1)+1)/tau_ee,P_GI_E(s(2)+1)/tau_ie,0,0,...
        P_GE_I(s(1)+1)*a_ei/tau_i,P_GI_I(s(2)+1)*a_ii/tau_i,0];
    q=[ne-s(1),ni-s(2),s(1),s(2),0,(1-s(1)/ne)*s(3),(1-s(2)/ni)*s(4),s(1)*s(3)/ne,...
        s(2)*s(4)/ni,0,0,s(1)*s(5)/ne,s(2)*s(5)/ni,0];
    q=q.*c;
    q(5)=ne/lambda_e+ni/lambda_i-q(1)-q(2)-q(3)-q(4);
    q(5) = 0;
    q(10)= s(3)/tau_ee - q(6) - q(8);
    q(11)= s(4)/tau_ie - q(7) - q(9);
    q(14)=s(5)/tau_i-q(10)-q(11);
    dt=exprnd(1/sum(q));
    t=t+dt;
    if floor(t)-floor((t-dt))==1
        t
        count=count+1;
        res.rec(:,count)=[s,t-dt]';
    end
    q=q/sum(q);
    d=rand(1);
    per=q(1);
    i=1;
    while per<d
        i=i+1;
        per=per+q(i);
    end
    count_oper(1,i)=count_oper(1,i)+1;
    count_oper(2,i)=count_oper(2,i)+dt;
    count_oper(1,15)=count_oper(1,15)+1;
    
    if i~=5
        
        if i==1
            s(1)=s(1)+1;
        elseif i==2
            s(2)=s(2)+1;
        elseif i==3
            s(1)=s(1)-1;
            s(3)=s(3)+P_ee;
            s(4)=s(4)+P_ie;
            res.spike(1,1)=res.spike(1,1)+1;
            res.spike(1,res.spike(1,1)+1)=t;
            if s(3)>max_pe
                s(3)=max_pe;
            end
        elseif i==4
            s(2)=s(2)-1;
            s(5)=s(5)+P_i;
            res.spike(2,1)=res.spike(2,1)+1;
            res.spike(2,res.spike(2,1)+1)=t;
            if s(5)>max_pi
                s(5)=max_pi;
            end
        elseif i==6
            s(1)=s(1)+1;
            s(3)=s(3)-1;
        elseif i==7
            s(2)=s(2)+1;
            s(4)=s(4)-1;
        elseif i==8
            s(1)=s(1)-1;
            s(3)=s(3)-1+P_ee;
            s(4)=s(4)+P_ie;
            res.spike(1,1)=res.spike(1,1)+1;
            res.spike(1,res.spike(1,1)+1)=t;
            if s(3)>max_pe
                s(3)=max_pe;
            end
        elseif i==9
            s(2)=s(2)-1;
            s(4)=s(4)-1;
            s(5)=s(5)+P_i;
            res.spike(2,1)=res.spike(2,1)+1;
            res.spike(2,res.spike(2,1)+1)=t;
            if s(5)>max_pi
                s(5)=max_pi;
            end
        elseif i==10
            s(3)=s(3)-1;
        elseif i==11
            s(4)=s(4)-1;
        elseif i==12
            s(1)=s(1)-1;
            s(5)=s(5)-1;
        elseif i==13
            s(2)=s(2)-1;
            s(5)=s(5)-1;
        elseif i==14
            s(5)=s(5)-1;
        end
    end
    
end

end





