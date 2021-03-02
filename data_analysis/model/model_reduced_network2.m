
function [res] = model_reduced_network2(s,param, P)
c                                 = zeros(4,param.ne + param.ni);
c(1,1:param.ne)                   = param.lambda_e;
c(1,param.ne+1:param.ne+param.ni) = param.lambda_i;
c(2,1:param.ne)                   = param.tau_ee;
c(2,param.ne+1:param.ne+param.ni) = param.tau_ie;
c(3,:)                            = param.tau_i;

duration_time = param.duration;
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
res.H_ieg = 0;
res.H_ii = 0;
res.H_iig = 0;
res.H_ee = 0;
res.H_eeg = 0;
res.H_ei = 0;
res.H_eig = 0;
res.N_state_e = 0;
res.N_state_i = 0;

time_check = 1;
time_delta = 0;

while t<= duration_time
    N_state_e                              = sum(s(1,1:param.ne));
    N_state_i                              = sum(s(1, param.ne+1:param.ne+param.ni));
    P_BE_Ex                           = P.P_BE_Ex(N_state_e+1);
    P_state_e_Ex                           = P.P_GE_Ex(N_state_e+1);
    P_BI_Ex                           = P.P_BI_Ex(N_state_i+1);
    P_state_i_Ex                           = P.P_GI_Ex(N_state_i+1);
    P_BE_E                            = P.P_BE_E(N_state_e+1);
    P_BI_E                            = P.P_BI_E(N_state_i+1);
    P_state_e_E                            = P.P_GE_E(N_state_e+1);
    P_state_i_E                            = P.P_GI_E(N_state_i+1);
    P_state_e_I                            = P.P_GE_I(N_state_e+1);
    P_state_i_I                            = P.P_GI_I(N_state_i+1);
    is_spike = 0;
    %disp(["iteration: ", step]);
    
    if sum(s(1,:))~=0
        %state_e state_i是单独提取出来e和i的状态，方便分别操作。最后一步会有s=[state_e,state_i
        state_e=s(1:2,1:param.ne);
        state_i=s(1:2,param.ne+1:param.ne+param.ni);
        
        index1=state_e(1,:)==1;%e的gate neuron位置
        index2=state_i(1,:)==1;%i的gate neuron位置
        fge=sum(index1)/param.ne;%fraction of gate e
        fgi=sum(index2)/param.ni;%fraction of gate i

        if sum(state_e(2,index1))~=0 && sum(state_e(2,~index1))~=0
            %如果都不为零，可以直接乘以系数调整H_eeg和H_eeb的比例
            H_ee_tot=sum(state_e(2,:));
            state_e(2,index1)=state_e(2,index1)*fge/(sum(state_e(2,index1))/H_ee_tot);
            state_e(2,~index1)=state_e(2,~index1)*(1-fge)/(sum(state_e(2,~index1))/H_ee_tot);
        elseif sum(state_e(2,index1))~=0 || sum(state_e(2,~index1))==0
            %一旦有一个为零，不为零的项乘以系数，为零的项则改为相应系数ones向量
            H_ee_tot=sum(state_e(2,:));
            state_e(2,index1)=state_e(2,index1)*fge;
            state_e(2,~index1)=(1-fge)*H_ee_tot*ones(1,sum(~index1))/sum(~index1);
        elseif sum(state_e(2,index1))==0 || sum(state_e(2,~index1))~=0
            H_ee_tot=sum(state_e(2,:));
            state_e(2,~index1)=state_e(2,~index1)*(1-fge);
            state_e(2,index1)=fge*H_ee_tot*ones(1,sum(index1))/sum(index1);
        end
        
        if abs(sum(state_e(2,:))-H_ee_tot)>1
            %这一段是用来查错的
            sum(state_e(2,:))
            H_ee_tot
            pause(5)
        end
        if abs(sum(state_e(2,index1))/H_ee_tot-fge)>0.01
            %查错
            break;
        end

        
        if sum(state_i(2,index2))~=0 && sum(state_i(2,~index2))~=0
            H_ie_tot=sum(state_i(2,:));
            state_i(2,index2)=state_i(2,index2)*fgi/(sum(state_i(2,index2))/H_ie_tot);
            state_i(2,~index2)=state_i(2,~index2)*(1-fgi)/(sum(state_i(2,~index2))/H_ie_tot); 
        elseif sum(state_i(2,index2))~=0 || sum(state_i(2,~index2))==0
            H_ie_tot=sum(state_i(2,:));
            state_i(2,index2)=state_i(2,index2)*fgi;
            state_i(2,~index2)=(1-fgi)*H_ie_tot*ones(1,sum(~index2))/sum(~index2);
        elseif sum(state_i(2,index2))==0 || sum(state_i(2,~index2))~=0
            H_ie_tot=sum(state_i(2,:));
            state_i(2,~index2)=state_i(2,~index2)*(1-fgi);
            state_i(2,index2)=fgi*H_ie_tot*ones(1,sum(index2))/sum(index2);
        end
        
        
        if abs(sum(state_i(2,:))-H_ie_tot)>1
            %查错
            sum(state_i(2,:))
            H_ie_tot
            pause(5)
        end
        
        s(1:2,:)=[state_e, state_i];
    end
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
            if rand(1)<P_state_e_Ex
                is_spike = 1;
                s(1,y) = 0;
            end
        elseif s(1,y)==0 && y>param.ne
            if rand(1)<P_BI_Ex
                s(1,y)=1;
            end
        else
            if rand(1)<P_state_i_Ex
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
            if rand(1)<P_state_e_E
                s(1,y)= 0;
                is_spike =1;
            end
        else
            if rand(1)<P_state_i_E
                s(1,y)=0;
                is_spike = 1;
            end
        end
    else %H_i operates
        s(x,y)=s(x,y)-1;
        if s(1,y) == 1 && y<= param.ne
            if rand(1)<P_state_e_I
                s(1,y)=0;
            end
        elseif s(1,y)==1 && y>param.ne
            if rand(1)<P_state_i_I
                s(1,y)=0;
            end
        end
    end
    if is_spike == 1
        if y<=param.ne %an excitatory spike
            %decide the postsynaptic neurons
            perm=randperm(75);
            s(2,perm(1:11))=s(2,perm(1:11))+1;
            perm=randperm(25);
            s(2,75+perm(1:13))=s(2,75+perm(1:13))+1;
%                         p=rand(1,param.ne+param.ni);
%                         p(1:param.ne)=-p(1:param.ne)+param.p_ee; p(param.ne+1:param.ne+param.ni)=-p(param.ne+1:param.ne+param.ni)+param.p_ie;
%                         p=sign(abs(p)+p);
%                         s(2,:)=s(2,:)+p;
        else %an inhibitory spike
            %decide the postsynaptic neurons
            perm=randperm(75);
            s(3,perm(1:38))=s(3,perm(1:38))+1;
            perm=randperm(25);
            s(3,75+perm(1:10))=s(3,75+perm(1:10))+1;
%                         p=rand(1,param.ne+param.ni);
%                         p(1:param.ne)=-p(1:param.ne)+param.p_ei; p(param.ne+1:param.ne+param.ni)=-p(param.ne+1:param.ne+param.ni)+param.p_ii;
%                         p=sign(abs(p)+p);
%                         s(3,:)=s(3,:)+p;
        end
        res.spike(1,y)=res.spike(1,y)+1; %write down the spike time
        res.spike(res.spike(1,y)+1,y)=t;
    end
    
    time_delta = time_delta + a(x,y);
    if time_delta >= time_check
        t
        res.H_ee = [res.H_ee s(2,1:param.ne)*ones(param.ne,1)];
        res.H_eeg = [res.H_eeg sum(s(2,find(s(1,1:param.ne)==1)))];
        res.H_ei = [res.H_ei s(3,1:param.ne)*ones(param.ne,1)];
        res.H_eig = [res.H_eig sum(s(3,find(s(1,1:param.ne)==1)))];
        res.H_ie = [res.H_ie s(2,param.ne+1:param.ne+param.ni)*ones(param.ni,1)];
        res.H_ieg = [res.H_ieg sum(s(2,param.ne+find(s(1,param.ne+1:param.ne+param.ni)==1)))];
        res.H_ii = [res.H_ii s(3,param.ne+1:param.ne+param.ni)*ones(param.ni,1)];
        res.H_iig = [res.H_iig sum(s(3,param.ne+find(s(1,param.ne+1:param.ne+param.ni)==1)))];
        time_delta = 0;
        res.N_state_e = [res.N_state_e s(1, 1:param.ne)*ones(param.ne,1)];
        res.N_state_i = [res.N_state_i s(1,param.ne+1:param.ne+param.ni)*ones(param.ni,1)];
    end
end
end

