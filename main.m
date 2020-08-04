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

iter            = 1500000;
%About 300 ms
s               = false;

start_time1 = clock;
spikes1 = model_full(s, iter, param1);
end_time1 = clock;
run_time1 = etime(end_time1, start_time1);

%scatter plot
maxrow=max(spikes1(1,:));
for i=1:300
scatter(spikes1(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=301:400
scatter(spikes1(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end

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

iter            = 1500000;
s               = false;

start_time2 = clock;
spikes2 = model_full(s, iter, param2);
end_time2 = clock;
run_time2 = etime(end_time2, start_time2);

%scatter plot
maxrow=max(spikes2(1,:));
for i=1:300
scatter(spikes2(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=301:400
scatter(spikes2(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end

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

iter            = 1500000;
s               = false;

start_time3 = clock;
spikes3 = model_full(s, iter, param3);
end_time3 = clock;
run_time3 = etime(end_time3, start_time3);

%scatter plot
maxrow=max(spikes3(1,:));
for i=1:300
scatter(spikes3(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=301:400
scatter(spikes3(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end

%% Full model: Sychronized & small-size & random initialization

param4.ne       = 75;
param4.ni       = 25;
param4.p_ee     = 0.15;
param4.p_ie     = 0.5;
param4.p_ei     = 0.5;
param4.p_ii     = 0.4;
param4.s_ee     = 5;
param4.s_ie     = 2;
param4.s_ei     = 4.91;
param4.s_ii     = 4.91;
param4.tau_r    = 2.5;
param4.M        = 100;
param4.Mr       = 66;
param4.lambda_e = 1/7;
param4.lambda_i = 1/7; 
param4.tau_ee   = 2.3; 
param4.tau_ie   = 0.95; 
param4.tau_i    = 4.5;
iter            = 1000000;

% random inilialization
s = zeros(4,param4.ne+param4.ni);
s(1,:) = double(rand(1,param4.ne+param4.ni)>0.8);
s(2:3,:) = unidrnd(param4.M+param4.Mr+1,[2,param4.ne+param4.ni])- param4.M-1;

start_time4 = clock;
spikes4 = model_full(s, iter, param4);
end_time4 = clock;
run_time4 = etime(end_time4, start_time4);

%scatter plot
maxrow=max(spikes4(1,:));
for i=1:75
scatter(spikes4(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=76:100
scatter(spikes4(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end

