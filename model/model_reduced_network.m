function [res] = model_reduced_network(s,duration_time,param)

c                                 = zeros(4,param.ne + param.ni);
c(1,1:param.ne)                   = param.lambda_e;
c(1,param.ne+1:param.ne+param.ni) = param.lambda_i;
c(2,1:param.ne)                   = param.tau_ee;
c(2,param.ne+1:param.ne+param.ni) = param.tau_ie;
c(3,:)                            = param.tau_i;
P_BE_Ex                           = param.P_BE_Ex;
P_GE_Ex                           = param.P_GE_Ex;
P_BI_Ex                           = param.P_BI_Ex;
P_GI_Ex                           = param.P_GI_Ex;
P_GE_E                            = param.P_GE_E;
P_GI_E                            = param.P_GI_E;
P_BE_E                            = param.P_BE_E;
P_BI_E                            = param.P_BI_E;
P_GE_I                            = param.P_GE_I;
P_GI_I                            = param.P_GI_I;

if s == false
    s=zeros(3,param.ne+param.ni);
end
%s is state matrix. The three rows indicate the triplet(V,H_e,H_i)for
%each neuron.

m=zeros(3,param.ne+param.ni);
m(1,:)=c(1,:);
res.spike=zeros(2000,param.ne+param.ni);

t=0;
i=1;
res.V_e = 0;
res.V_i = 0;
res.H_ie = 0;
res.H_ii = 0;
res.H_ee = 0;
res.H_ei = 0;
res.N_GE = 0;
res.N_GI = 0;

time_check = 3;
time_delta = 0;

while t<= duration_time
    is_spike = 0;
    %disp(["iteration: ", step]);
    m(2:3,:)=c(2:3,:)./s(2:3,:);
    a=exprnd(m);
    %exponential distribution random variable
    min_a=min(min(a));
    [x,y]=find(a==min_a);
    %the position of the minimum decides the next operation.
    t = t+a(x,y);
    
    res.delta_t(i) = a(x,y);
    i = i+1;
    if x == 1 %external input operates
        if s(1,y) == 0 && y<= param.ne
            if rand(1)< P_BE_Ex
                s(1,y)=1;
            end
        elseif s(1,y)==1 && y<=param.ne
            if rand(1)<P_GE_Ex
                is_spike = 1;
                s(1,y) = 0;
            end
        elseif s(1,y)==0 && y>param.ne
            if rand(1)<P_BI_Ex
                s(1,y)=1;
            end
        else
            if rand(1)<P_GI_Ex
                is_spike = 1;
                s(1,y) = 0;
            end
        end
    elseif x == 2 %H_e operates
        s(x,y) = s(x,y)-1;
        if s(1,y) == 0 && y<=param.ne
            if rand(1)<P_BE_E
                s(1,y)=1;
            end
        elseif s(1,y)==0 && y> param.ne
            if rand(1)<P_BI_E
                s(1,y)=1;
            end
        elseif s(1,y)==1 && y<= param.ne
            if rand(1)<P_GE_E
               s(1,y)= 0;
               is_spike =1;
            end
        else
            if rand(1)<P_GI_E
                s(1,y)=0;
                is_spike = 1;
            end
        end
    else %H_i operates
        s(x,y)=s(x,y)-1;
        if s(1,y) == 1 && y<= param.ne
            if rand(1)<P_GE_I
                s(1,y)=0;
            end
        elseif s(1,y)==1 && y>param.ne
            if rand(1)<P_GI_I
                s(1,y)=0;
            end
        end
    end
    if is_spike == 1
        if y<=param.ne %an excitatory spike
            %decide the postsynaptic neurons
            p=rand(1,param.ne+param.ni);
            p(1:param.ne)=-p(1:param.ne)+param.p_ee; p(param.ne+1:param.ne+param.ni)=-p(param.ne+1:param.ne+param.ni)+param.p_ie;
            p=sign(abs(p)+p);
            s(2,:)=s(2,:)+p;
        else %an inhibitory spike
            %decide the postsynaptic neurons
            p=rand(1,param.ne+param.ni);
            p(1:param.ne)=-p(1:param.ne)+param.p_ei; p(param.ne+1:param.ne+param.ni)=-p(param.ne+1:param.ne+param.ni)+param.p_ii;
            p=sign(abs(p)+p);
            s(3,:)=s(3,:)+p;
        end
        res.spike(1,y)=res.spike(1,y)+1; %write down the spike time
        res.spike(res.spike(1,y)+1,y)=t;
    end
    
    time_delta = time_delta + a(x,y);
    if time_delta >= time_check
        res.H_ee = [res.H_ee s(2,1:param.ne)*ones(param.ne,1)];
        res.H_ei = [res.H_ei s(3,1:param.ne)*ones(param.ne,1)];
        res.H_ie = [res.H_ie s(2,param.ne+1:param.ne+param.ni)*ones(param.ni,1)];
        res.H_ii = [res.H_ii s(3,param.ne+1:param.ne+param.ni)*ones(param.ni,1)];
        time_delta = 0;
        res.N_GE = [res.N_GE s(1, 1:param.ne)*ones(param.ne,1)];
        res.N_GI = [res.N_GI s(1,param.ne+1:param.ne+param.ni)*ones(param.ni,1)];
    end
end
end

