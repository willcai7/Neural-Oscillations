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

duration_time   = 1000;
%About 300 ms
s               = false;

start_time1 = clock;
spikes1 = model_full(s, duration_time, param1);
end_time1 = clock;
run_time1 = etime(end_time1, start_time1);
firing_rate1 = firing_rate(spikes1, param1.ne, param1.ni);
scatterplot(spikes1,param1.ne, param1.ni,'scatter-n=400-t=1000-hom')
correlation(spikes1,param1.ne, param1.ni,'correlation-n=400-t=1000-hom')
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

duration_time   = 1000;
s               = false;

start_time2 = clock;
spikes2 = model_full(s, duration_time, param2);
end_time2 = clock;
run_time2 = etime(end_time2, start_time2);
firing_rate2 = firing_rate(spikes2, param2.ne, param2.ni);
scatterplot(spikes2,param2.ne, param2.ni,'scatter-n=400-t=1000-reg')
correlation(spikes2,param2.ne, param2.ni,'correlation-n=400-t=1000-reg')
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

duration_time   = 1000;
s               = false;

start_time3 = clock;
spikes3 = model_full(s, duration_time, param3);
end_time3 = clock;
run_time3 = etime(end_time3, start_time3);

firing_rate3 = firing_rate(spikes3, param3.ne, param3.ni);
scatterplot(spikes3,param3.ne, param3.ni,'scatter-n=400-t=1000-syn')
correlation(spikes3,param3.ne, param3.ni,'correlation-n=400-t=1000-syn')
firing_rate3

%% Full model: homogeneous & small-size & random initialization

param4.ne       = 75;
param4.ni       = 25;
param4.p_ee     = 0.15;
param4.p_ie     = 0.5;
param4.p_ei     = 0.5;
param4.p_ii     = 0.4;
param4.s_ee     = 5*5;
param4.s_ie     = 2*5;
param4.s_ei     = 30;
param4.s_ii     = 30;
param4.tau_r    = 2.5;
param4.M        = 100;
param4.Mr       = 66;
param4.lambda_e = 1/7;
param4.lambda_i = 1/7; 
param4.tau_ee   = 4; 
param4.tau_ie   = 1.2; 
param4.tau_i    = 4.5;
duration_time   = 1000;

% random inilialization
s = zeros(4,param4.ne+param4.ni);
s(2:3,:) = double(rand(2,param4.ne+param4.ni)>0.8);
s(1,:) = unidrnd(param4.M+param4.Mr+1,[1,param4.ne+param4.ni])- param4.Mr-1;

start_time4 = clock;
spikes4 = model_full(s, duration_time, param4,'n=100-hom');
end_time4 = clock;
run_time4 = etime(end_time4, start_time4);

% firing_rate4 = firing_rate(spikes4, param4.ne, param4.ni);
% scatterplot(spikes4, param4.ne, param4.ni,'scatter-n=100-t=1000-hom')
% correlation(spikes4,param4.ne, param4.ni,'correlation-n=100-t=1000-hom')
% firing_rate4

%% Full model: regular & small-size & random initialization

param5.ne       = 75;
param5.ni       = 25;
param5.p_ee     = 0.15;
param5.p_ie     = 0.5;
param5.p_ei     = 0.5;
param5.p_ii     = 0.4;
param5.s_ee     = 5*5;
param5.s_ie     = 2*5;
param5.s_ei     = 30;
param5.s_ii     = 30;
param5.tau_r    = 2.5;
param5.M        = 100;
param5.Mr       = 66;
param5.lambda_e = 1/7;
param5.lambda_i = 1/7; 
param5.tau_ee   = 2; 
param5.tau_ie   = 1.2; 
param5.tau_i    = 4.5;
duration_time   = 1000;

% random inilialization
s = zeros(4,param5.ne+param5.ni);
s(2:3,:) = double(rand(2,param5.ne+param5.ni)>0.8);
s(1,:) = unidrnd(param5.M+param5.Mr+1,[1,param5.ne+param5.ni])- param5.Mr-1;


start_time5 = clock;
spikes5 = model_full(s, duration_time, param5,'n=100-reg');
end_time5 = clock;
run_time5 = etime(end_time5, start_time5);

% firing_rate5 = firing_rate(spikes5, param5.ne, param5.ni);
% scatterplot(spikes5, param5.ne, param5.ni,'scatter-n=100-t=1000-reg')
% correlation(spikes5,param5.ne, param5.ni,'correlation-n=100-t=1000-reg')
% firing_rate5

%% Full model: synchronized & small-size & random initialization

param6.ne       = 75;
param6.ni       = 25;
param6.p_ee     = 0.15;
param6.p_ie     = 0.5;
param6.p_ei     = 0.5;
param6.p_ii     = 0.4;
param6.s_ee     = 5*5;
param6.s_ie     = 2*5;
param6.s_ei     = 30;
param6.s_ii     = 30;
param6.tau_r    = 2.5;
param6.M        = 100;
param6.Mr       = 66;
param6.lambda_e = 1/7;
param6.lambda_i = 1/7; 
param6.tau_ee   = 1.3; 
param6.tau_ie   = 0.95; 
param6.tau_i    = 4.5;
duration_time   = 1000;

%random inilialization
s = zeros(4,param6.ne+param6.ni);
s(2:3,:) = double(rand(2,param6.ne+param6.ni)>0.8);
s(1,:) = unidrnd(param6.M+param6.Mr+1,[1,param6.ne+param6.ni])- param6.Mr-1;


start_time6 = clock;
spikes6 = model_full(s, duration_time, param6,'n=100-syn');
end_time6 = clock;
run_time6 = etime(end_time6, start_time6);  

% firing_rate6 = firing_rate(spikes6, param6.ne, param6.ni);
% scatterplot(spikes6, param6.ne, param6.ni,'scatter-n=100-t=1000-syn')
% correlation(spikes6,param6.ne, param6.ni,'correlation-n=100-t=1000-syn')
% firing_rate6