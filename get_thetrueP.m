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
param6.tau_r    = 0;
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
% correlation(res6,param6.ne, param6.ni,name6)
% hist_h(res6, name6)
% hist_v(res6, name6)
% hist_t(res6, name6)
% line_graph(res6,3, param6.ne, param6.ni, name6);
%firing_rate6