%% Setting paths
addpath(genpath(pwd));

%% Full model: synchronized & small-size & random initialization

param6.ne       = 75;
param6.ni       = 25;
param6.p_ee     = 0.15;
param6.p_ie     = 0.5;
param6.p_ei     = 0.5;
param6.p_ii     = 0.4;
param6.s_ee     = 5*5;
param6.s_ie     = 2*5;
param6.s_ei     = 25;
param6.s_ii     = 25;
param6.tau_r    = 2.5;
param6.M        = 100;
param6.Mr       = 66;
param6.lambda_e = 1/7;
param6.lambda_i = 1/7; 
param6.tau_ee   = 1.3; 
param6.tau_ie   = 0.95; 
param6.tau_i    = 4.5;
duration_time   = 1000;

name6 = 'n=100-t=1000-syn';

%random inilialization
s = zeros(4,param6.ne+param6.ni);
s(2:3,:) = double(rand(2,param6.ne+param6.ni)>0.8);
s(1,:) = unidrnd(param6.M+param6.Mr+1,[1,param6.ne+param6.ni])- param6.Mr-1;


start_time6 = clock;
res6 = model_full(s, duration_time, param6);
end_time6 = clock;
run_time6 = etime(end_time6, start_time6);  


%firing_rate6 = firing_rate(res6.spikes, param6.ne, param6.ni);
scatterplot(res6, param6.ne, param6.ni,name6)
correlation(res6,param6.ne, param6.ni,name6)
hist_h(res6, name6)
hist_v(res6, name6)
hist_t(res6, name6)
line_graph(res6,3, param6.ne, param6.ni, name6);
%firing_rate6
%% Full model without ref: synchronized

param8.ne       = 75;
param8.ni       = 25;
param8.p_ee     = 0.15;
param8.p_ie     = 0.5;
param8.p_ei     = 0.5;
param8.p_ii     = 0.4;
param8.s_ee     = 5*5;
param8.s_ie     = 2*5;
param8.s_ei     = 25;
param8.s_ii     = 25;
param8.tau_r    = 2.5;
param8.M        = 100;
param8.Mr       = 66;
param8.lambda_e = 1/7;
param8.lambda_i = 1/7; 
param8.tau_ee   = 1.3; 
param8.tau_ie   = 0.95; 
param8.tau_i    = 4.5;
duration_time   = 1000;

name8 = 'n=100-t=1000-syn-noref';


s=false;
start_time8 = clock;
res8 = model_full_noref(s, duration_time, param8);
end_time8 = clock;
run_time8 = etime(end_time8, start_time8);  


%firing_rate6 = firing_rate(res6.spikes, param6.ne, param6.ni);
line_graph(res8,3, param8.ne, param8.ni, name8);
scatterplot(res8, param8.ne, param8.ni,name8);

%% Reduced Network with Nonfixed P: Synchronized
param9.ne       = 75;
param9.ni       = 25;
param9.p_ee     = 0.15;
param9.p_ie     = 0.5;
param9.p_ei     = 0.5;
param9.p_ii     = 0.4;
param9.lambda_e = 1/7;
param9.lambda_i = 1/7; 
param9.tau_ee   = 1.3; 
param9.tau_ie   = 0.95; 
param9.tau_i    = 4.5;

duration_time   = 1000;
type9='syn';
save9=true;

s=false;
name9 = 'n=100-t=1000-reduced-nonfixedP-syn';
start_time9 = clock;
%P1 = P_generation_histogram(param8, res8);
%P2 = P_generation_histogram(param6, res6);
res9 = model_reduced_network_P(s,duration_time, param9, P2,0.25,1.2);
end_time9 = clock;
run_time9 = etime(end_time9, start_time9);
scatterplot(res9, param9.ne, param9.ni,type9, name9, save9);
%line_graph(res9,3, param9.ne, param9.ni, name9);

%%

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
    

P3.P_BE_Ex  = p1;
P3.P_BI_Ex  = p2;
P3.P_GE_Ex  = p3;
P3.P_GI_Ex  = p4;
P3.P_BE_E   = p5;
P3.P_BI_E   = p6;
P3.P_GE_E   = p7;
P3.P_GI_E   = p8;
P3.P_GE_I   = p9;
P3.P_GI_I   = ones(1,26);

%%
V_e = res.V_e;
V_e1 = V_e(V_e<0);
V_e2 = V_e(V_e>=0);
V_e3 = V_e(V_e>-20);
V_e3 = V_e(V_e<20);
me = mean(V_e3);
va = var(V_e3);
var(V_e1)
var(V_e2)
x1 = [-68.5:1:0];
x2 = [0:1:99.5];
y1 = mvnpdf(x1', me, va);
y2 = mvnpdf(x2',me,va);
histogram(V_e,[-69:1:100],'normalization','probability');
hold on
plot(x1,y1)
hold on 
plot(x2,y2)

V_e1 = V_e + 90;
V_e1 = log(V_e1);
me = mean(V_e1);
va = var(V_e1);
x = [-69:1:100];
y = mvnpdf((log(x+90))', me ,va)'./(x+90);
hold on
plot(x,y)

