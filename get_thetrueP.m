%% Setting paths
addpath(genpath(pwd));
%% Full model: syn, small-size, noref
addpath(genpath(pwd));
param9.ne       = 75;
param9.ni       = 25;
param9.p_ee     = 0.15;
param9.p_ie     = 0.5;
param9.p_ei     = 0.5;
param9.p_ii     = 0.4;
param9.s_ee     = 25;
param9.s_ie     = 10;
param9.s_ei     = 25;
param9.s_ii     = 25;
param9.tau_r    = 0;
param9.M        = 100;
param9.Mr       = 66;
param9.lambda_e = 1/7;
param9.lambda_i = 1/7;
param9.tau_ee   = 1.3;
param9.tau_ie   = 0.95;
param9.tau_i    = 4.5;
param9.gate     = 70;
duration_time   = 60000;
param9.time_delta = 1;
name9 = 'n=100-t=1000-syn-noref';
save=false;
param9.type     = 'syn';

%random inilialization
s = zeros(4,param9.ne+param9.ni);
s(2:3,:) = double(rand(2,param9.ne+param9.ni)>0.8);
s(1,:) = unidrnd(param9.M+param9.Mr+1,[1,param9.ne+param9.ni])- param9.Mr-1;



t = clock;
res9 = model_full(s, duration_time, param9);
runtime9 = etime(clock,t);

%% Calculate the P

res = res9;
V_e = res.V_e;
V_i = res.V_i;
N_GI = res.N_GI;
N_GE = res.N_GE;

P1.P_BE_Ex = zeros(1, 76);
P1.P_GE_Ex = zeros(1, 76);
P1.P_BE_E  = zeros(1, 76);
P1.P_GE_E  = ones(1, 76);
P1.P_GE_I  = ones(1, 76);
P1.P_BI_Ex = zeros(1, 26);
P1.P_GI_Ex = zeros(1, 26);
P1.P_BI_E  = zeros(1, 26);
P1.P_GI_E  = zeros(1, 26);
P1.P_GI_I  = ones(1, 26);


max_N_GE = max(N_GE);
max_N_GI = max(N_GI);
check_times = length(N_GE);
V_e = reshape(V_e, 75, check_times);
V_i = reshape(V_i, 25 ,check_times);

for i =1:max_N_GE+1
V_e_temp = V_e(:, N_GE==(i-1));
% V_e_temp = reshape(V_e_temp, 1, 75*sum(N_GE==(i-1)));
PDF_e_temp = histogram(V_e_temp,[-66:1:101],'normalization','probability');
PDF_e_temp = PDF_e_temp.Values;
close;
P1.P_BE_Ex(i) = PDF_e_temp(76+66)/sum(PDF_e_temp(1: (76+66)));
P1.P_GE_Ex(i) = PDF_e_temp(166)/sum(PDF_e_temp(143: 167));
P1.P_BE_E(i) = sum(PDF_e_temp((142-24):142))/sum(PDF_e_temp(1:142));
end

for i =1:max_N_GI+1
V_i_temp = V_i(:, N_GI==(i-1));
% V_i_temp = reshape(V_i_temp, 1, 25*sum(N_GI==(i-1)));
PDF_i_temp = histogram(V_i_temp,[-66:1:101],'normalization','probability');
PDF_i_temp = PDF_i_temp.Values;
close;

P1.P_BI_Ex(i) = PDF_i_temp(76+66)/sum(PDF_i_temp(1: (76+66)));
P1.P_GI_Ex(i) = PDF_i_temp(166)/sum(PDF_i_temp(143: 167));
P1.P_BI_E(i) = sum(PDF_i_temp((142-15):142))/sum(PDF_i_temp(1:142));
P1.P_GI_E(i) = sum(PDF_i_temp((167-15):167))/sum(PDF_i_temp(143:167));

end

%%
res=load('res7');
res=res.res6;
PDF_e=histogram(res.V_e,[-69:1:100],'normalization','probability');
PDF_e=PDF_e.Values;
close;
PDF_i=histogram(res.V_i,[-69:1:100],'normalization','probability');
PDF_i=PDF_i.Values;
close;
% % 
% PDF_e=gaussian_vector(10.5402,-1.7394);
% PDF_i=gaussian_vector(13.3019,-2.0295);


p1=zeros(1,76);
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
        lim=0.5/75;
    else
        lim=(i-1)/75;
    end
    while count<lim && j>1
        count=sum(PDF_e(j: min(j+25,169)));
        j=j-1;
    end
    p1(i)=PDF_e(j)/(1-count);
    if j+25>169
        p3(i)=0;
    else
        p3(i)=PDF_e(j+25)/count;
    end
%     p3(i)=PDF_e(min(j+25,169))/count;
    p5(i)=sum(PDF_e(max(j-25,1):min(j,169)))/(1-count);
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
        count=sum(PDF_e(j: min(j+25,169)));
        j=j-1;
    end
    p2(i)=PDF_i(j)/(1-count);
    if j+25>169
        p4(i)=0;
    else
        p4(i)=PDF_i(j+25)/count;
    end
%     p4(i)=PDF_i(min(j+25,169))/count;
    p6(i)=sum(PDF_i(max(j-10,1):j))/(1-count);
    if j+15 >169
        p8(i)=0;
    else
        p8(i)=sum(PDF_i(j+15:min(j+25,169)))/count;
    end
%     p8(i)=sum(PDF_i(min(j+10,169):min(j+25,169)))/count;
end
    

    

P2.P_BE_Ex = p1;
P2.P_BI_Ex = p2;
P2.P_GE_Ex = p3;
P2.P_GI_Ex = p4;
P2.P_BE_E = p5;
P2.P_BI_E = p6;
P2.P_GE_E = p7;
P2.P_GI_E = p8;
P2.P_GE_I = p9;
P2.P_GI_I = p10;

compare_P(P1,P2)
