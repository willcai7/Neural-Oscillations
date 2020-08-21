%% Setting paths
addpath(genpath(pwd));

%% Full model: Homogeneous
param1.ne       = 300;
param1.ni       = 100;
param1.p_ee     = 0.15;
param1.p_ie     = 0.5;
param1.p_ei     = 0.5;
param1.p_ii     = 0.4;
param1.s_ee     = 5;
param1.s_ie     = 2;
param1.s_ei     = 4.91;
param1.s_ii     = 4.91;
param1.tau_r    = 2.5;
param1.M        = 100;
param1.Mr       = 66;
param1.lambda_e = 1/7;
param1.lambda_i = 1/7;
%7000 spikes/sec means time constant is 1/7 ms.
param1.tau_ee   = 4;
param1.tau_ie   = 1.2;
param1.tau_i    = 4.5;
param1.gate      = 70;
duration_time   = 1000;
%About 300 ms
s               = false;

start_time1 = clock;
res1 = model_full(s, duration_time, param1);
end_time1 = clock;
run_time1 = etime(end_time1, start_time1);
firing_rate1 = firing_rate(res1.spikes, param1.ne, param1.ni);
scatterplot(res1.spikes, param1.ne, param1.ni,'scatter-n=400-t=1000-hom')
correlation(res1.spikes, param1.ne, param1.ni,'correlation-n=400-t=1000-hom')
firing_rate1

%% Full model: Regular
param2.ne       = 300;
param2.ni       = 100;
param2.p_ee     = 0.15;
param2.p_ie     = 0.5;
param2.p_ei     = 0.5;
param2.p_ii     = 0.4;
param2.s_ee     = 5;
param2.s_ie     = 2;
param2.s_ei     = 4.91;
param2.s_ii     = 4.91;
param2.tau_r    = 2.5;
param2.M        = 100;
param2.Mr       = 66;
param2.lambda_e = 1/7;
param2.lambda_i = 1/7;
param2.tau_ee   = 2;
param2.tau_ie   = 1.2;
param2.tau_i    = 4.5;
param2.gate      = 70;
duration_time   = 1000;
s               = false;

start_time2 = clock;
res2 = model_full(s, duration_time, param2);
end_time2 = clock;
run_time2 = etime(end_time2, start_time2);
firing_rate2 = firing_rate(res2.spikes, param2.ne, param2.ni);
scatterplot(res2.spikes, param2.ne, param2.ni,'scatter-n=400-t=1000-reg')
correlation(res2.spikes, param2.ne, param2.ni,'correlation-n=400-t=1000-reg')
firing_rate2

%% Full model: Sychronized
param3.ne       = 300;
param3.ni       = 100;
param3.p_ee     = 0.15;
param3.p_ie     = 0.5;
param3.p_ei     = 0.5;
param3.p_ii     = 0.4;
param3.s_ee     = 5;
param3.s_ie     = 2;
param3.s_ei     = 4.91;
param3.s_ii     = 4.91;
param3.tau_r    = 2.5;
param3.M        = 100;
param3.Mr       = 66;
param3.lambda_e = 1/7;
param3.lambda_i = 1/7;
param3.tau_ee   = 1.3;
param3.tau_ie   = 0.95;
param3.tau_i    = 4.5;
param3.gate      = 70;
duration_time   = 1000;
s               = false;

start_time3 = clock;
res3 = model_full(s, duration_time, param3);
end_time3 = clock;
run_time3 = etime(end_time3, start_time3);

firing_rate3 = firing_rate(res3.spikes, param3.ne, param3.ni);
scatterplot(res3.spikes, param3.ne, param3.ni,'scatter-n=400-t=1000-syn')
correlation(res3.spikes, param3.ne, param3.ni,'correlation-n=400-t=1000-syn')
firing_rate3

%% Full model: homogeneous & small-size & random initialization

param4.ne       = 75;
param4.ni       = 25;
param4.p_ee     = 0.15;
param4.p_ie     = 0.5;
param4.p_ei     = 0.5;
param4.p_ii     = 0.4;
param4.s_ee     = 5*4.5;
param4.s_ie     = 2*4.5;
param4.s_ei     = 25;
param4.s_ii     = 25;
param4.tau_r    = 0;
param4.M        = 100;
param4.Mr       = 66;
param4.lambda_e = 1/7;
param4.lambda_i = 1/7;
param4.tau_ee   = 4;
param4.tau_ie   = 1.2;
param4.tau_i    = 4.5;
param4.gate      = 70;
duration_time   = 1000;

name4 = 'scatter-n=100-t=1000-hom';
save=false;
type='sync';

% random inilialization
s = zeros(4,param4.ne+param4.ni);
s(2:3,:) = double(rand(2,param4.ne+param4.ni)>0.8);
s(1,:) = unidrnd(param4.M+param4.Mr+1,[1,param4.ne+param4.ni])- param4.Mr-1;


%  model_full_video(s, duration_time, param4);
res4 = model_full(s, duration_time, param4);



firing_rate4 = firing_rate(res4.spike, param4.ne, param4.ni);
scatterplot(res4, param4.ne, param4.ni,type, name4,save)
correlation(res4, param4.ne, param4.ni,type, name4,save)
hist_h(res4,type, name4,save)
hist_v(res4,type, name4,save)
hist_t(res4,type, name4,save)
% firing_rate4

%% Full model: regular & small-size & random initialization

param5.ne       = 75;
param5.ni       = 25;
param5.p_ee     = 0.15;
param5.p_ie     = 0.5;
param5.p_ei     = 0.5;
param5.p_ii     = 0.4;
param5.s_ee     = 2*4.5;
param5.s_ie     = 5*4.5;
param5.s_ei     = 25;
param5.s_ii     = 25;
param5.tau_r    = 2.5;
param5.M        = 100;
param5.Mr       = 66;
param5.lambda_e = 1/7;
param5.lambda_i = 1/7;
param5.tau_ee   = 2;
param5.tau_ie   = 1.2;
param5.tau_i    = 4.5;
param5.gate      = 70;
duration_time   = 1000;
name5 = 'n=100-t=1000-reg';
save=false;
type='sync';
% random inilialization
s = zeros(4,param5.ne+param5.ni);
s(2:3,:) = double(rand(2,param5.ne+param5.ni)>0.8);
s(1,:) = unidrnd(param5.M+param5.Mr+1,[1,param5.ne+param5.ni])- param5.Mr-1;



%  model_full_video(s, duration_time, param5);
res5 = model_full(s, duration_time, param5);



firing_rate5 = firing_rate(res5.spike, param5.ne, param5.ni);
scatterplot(res5, param5.ne,type, param5.ni, name5,save)
correlation(res5, param5.ne,type ,param5.ni, name5,save)
hist_h(res5,type, name5,save)
hist_v(res5,type, name5,save)
hist_t(res5,type, name5,save)
%firing_rate5

%% Full model: synchronized & small-size & random initialization

param6.ne       = 75;
param6.ni       = 25;
param6.p_ee     = 0.15;
param6.p_ie     = 0.5;
param6.p_ei     = 0.5;
param6.p_ii     = 0.4;
param6.s_ee     = 2*4.5;
param6.s_ie     = 5*4.5;
param6.s_ei     = 25;
param6.s_ii     = 25;
param6.tau_r    = 0;
param6.M        = 100;
param6.Mr       = 66;
param6.lambda_e = 1/7;
param6.lambda_i = 1/7;
param6.tau_ee   = 1.3;
param6.tau_ie   = 0.95;
param6.tau_i    = 4.5;
param6.gate      = 70;
duration_time   = 1000;

name6 = 'n=100-t=1000-syn';
save=false;
type='sync';

%random inilialization
s = zeros(4,param6.ne+param6.ni);
s(2:3,:) = double(rand(2,param6.ne+param6.ni)>0.8);
s(1,:) = unidrnd(param6.M+param6.Mr+1,[1,param6.ne+param6.ni])- param6.Mr-1;



% model_full_video(s, duration_time, param6);
res6 = model_full(s, duration_time, param6);


%firing_rate6 = firing_rate(res6.spikes, param6.ne, param6.ni);
scatterplot(res6,param6.ne,type,param6.ni,name6,save)
correlation(res6,param6.ne,type, param6.ni,name6,save)
hist_h(res6,type,name6,save)
hist_v(res6,type,name6,save)
hist_t(res6,type,name6,save)
%firing_rate6

%% Coarse grained fixed probabiliy model:

c=0.2;
param7.ne=75;
param7.ni=25;

param7.P_BE_Ex=0.0067*ones(1,76)*c;
param7.P_BI_Ex=0.0104*ones(1,26)*c;
param7.P_GE_Ex=0.02*ones(1,76)*c;
param7.P_GI_Ex=0.00247*ones(1,26)*c;
param7.P_BE_E=0.029*ones(1,76)*c;
param7.P_BI_E=0.07*ones(1,26)*c;
param7.P_BE_E=ones(1,76)*c;
param7.P_GI_E=ones(1,26)*c;
param7.P_GE_I=ones(1,76)*c;
param7.P_GI_I=ones(1,26)*c;




param7.lambda_e = 1/7;
param7.lambda_i = 1/7;
param7.tau_ee   = 1.3;
param7.tau_ie   = 0.95;
param7.tau_i    = 4.5;
param7.S_e = 24;
param7.S_i = 48;
param7.a_ee=0.5;
param7.a_ie=0.5;
param7.a_ei=0.79;
param7.a_ii=0.21;
param7.pending_i_maximum=2000000;
param7.pending_e_maximum=1000000;
duration_time   = 1000;

%random initialization
s=ones(1,4);
res7=model_coarse_grained(s,duration_time,param7);

save=false;
type='reg';
name7='t=1000';
coarse_grained_plot(param7,res7,duration_time,type,name7,save);

% line_graph(res7,time_delta,ne, ni, name)


