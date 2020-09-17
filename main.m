%% Setting paths
addpath(genpath(pwd));

%% Full model: Hom
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
param1.type     = 'hom';
param1.fix = false;% to decide whether the pending spike ratio is fixed.
save     = true;
name1    ='n=400-t=1000-hom';
param1.time_delta = 1;
t = clock;
res1 = model_full(s, duration_time, param1);
runtime1 = etime(clock, t);

scatterplot(res1, param1,name1, save)
% firing_rate1 = firing_rate(res1, param1);
% correlation(res1, param1,name1, save)
% firing_rate1

%% Full model: Reg
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
param2.type      = 'reg';
param2.fix = false;
name2           ='n=400-t=1000-reg';
s               = false;
save            = true;
param2.time_delta = 1;
t = clock;
res2 = model_full(s, duration_time, param2);
run_time2 = etime(clock, t);

scatterplot(res2, param2,name2,save)
% firing_rate2 = firing_rate(res2, param2);
% correlation(res2, param2,name2,save)
% firing_rate2

%% Full model: Syn
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
param3.gate     = 70;
duration_time   = 1000;
param3.type     = 'syn';
param3.fix = false;
name3           ='n=400-t=1000-syn';
s               = false;
save            = true;
param3.time_delta = 1;
t=clock;
res3 = model_full(s, duration_time, param3);
run_time3 = etime(clock, t);

scatterplot(res3, param3, name3, save)
% firing_rate3 = firing_rate(res3, param3);
% correlation(res3, param3, name3, save)
% firing_rate3

%% Full model: Hom, small-size 

param4.ne       = 75;
param4.ni       = 25;
param4.p_ee     = 0.15;
param4.p_ie     = 0.5;
param4.p_ei     = 0.5;
param4.p_ii     = 0.4;
param4.s_ee     = 25;
param4.s_ie     = 10;
param4.s_ei     = 25;
param4.s_ii     = 25;
param4.tau_r    = 2.5;
param4.M        = 100;
param4.Mr       = 66;
param4.lambda_e = 1/7;
param4.lambda_i = 1/7;
param4.tau_ee   = 4;
param4.tau_ie   = 1.2;
param4.tau_i    = 4.5;
param4.gate      = 70;
duration_time   = 1000;
param4.type      ='hom';
param4.fix = true; 
param4.time_delta = 1;

name4 = 'n=100-t=1000-hom';
save=false;

% random inilialization
s = zeros(4,param4.ne+param4.ni);
s(2:3,:) = double(rand(2,param4.ne+param4.ni)>0.8);
s(1,:) = unidrnd(param4.M+param4.Mr+1,[1,param4.ne+param4.ni])- param4.Mr-1;


%  model_full_video(s, duration_time, param4);
t=clock;
res4 = model_full(s, duration_time, param4);
runtime4 = etime(clock,t);



scatterplot(res4, param4, name4,save);
% firing_rate4 = firing_rate(res4.spike, param4);
% correlation(res4, param4, name4,save)
% hist_h(res4,param4, name4,save)
% hist_v(res4,param4, name4,save)
% hist_t(res4,param4, name4,save)
% firing_rate4
%dynamical_motion(res4,param4, name4,save)

%% Full model: Reg, small-size 

param5.ne       = 75;
param5.ni       = 25;
param5.p_ee     = 0.15;
param5.p_ie     = 0.5;
param5.p_ei     = 0.5;
param5.p_ii     = 0.4;
param5.s_ee     = 25;
param5.s_ie     = 10;
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
param5.time_delta = 1;
save=false;
param5.type    ='reg';
param5.fix = false;
% random inilialization
s = zeros(4,param5.ne+param5.ni);
s(2:3,:) = double(rand(2,param5.ne+param5.ni)>0.8);
s(1,:) = unidrnd(param5.M+param5.Mr+1,[1,param5.ne+param5.ni])- param5.Mr-1;



%  model_full_video(s, duration_time, param5);
t = clock;
res5 = model_full(s, duration_time, param5);
runtime5 = etime(clock, t);

% 
% firing_rate5 = firing_rate(res5, param5);
% scatterplot(res5, param5,name5,save);
% correlation(res5, param5,name5,save);
% hist_h(res5,pram5,name5,save);
% hist_v(res5,pram5,name5,save);
% hist_t(res5,pram5,name5,save);
%firing_rate5
%dynamical_motion(res5,pram5,name5,save);

%% Full model: Syn, small-size 

param6.ne       = 75;
param6.ni       = 25;
param6.p_ee     = 0.15;
param6.p_ie     = 0.5;
param6.p_ei     = 0.5;
param6.p_ii     = 0.4;
param6.s_ee     = 25;
param6.s_ie     = 10;
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
param6.gate      = 70;
duration_time   = 1000;
param6.time_delta = 1;

name6 = 'n=100-t=1000-syn';
save=false;
param6.type       ='syn';
param6.fix = false;

%random inilialization
s = zeros(4,param6.ne+param6.ni);
s(2:3,:) = double(rand(2,param6.ne+param6.ni)>0.8);
s(1,:) = unidrnd(param6.M+param6.Mr+1,[1,param6.ne+param6.ni])- param6.Mr-1;



% model_full_video(s, duration_time, param6);
t = clock;
res6 = model_full(s, duration_time, param6);
runtime6 = etime(clock,t);


%firing_rate6 = firing_rate(res6, param6);
%scatterplot(res6,param6,name6,save)
%correlation(res6,param6,name6,save)
%hist_h(res6,param6,name6,save)
%hist_v(res6,param6,name6,save)
%hist_t(res6,param6,name6,save)
%firing_rate6
% dynamical_motion(res6,param6,name6,save)

%% Full model: Hom, small-size, noref

param7.ne       = 75;
param7.ni       = 25;
param7.p_ee     = 0.15;
param7.p_ie     = 0.5;
param7.p_ei     = 0.5;
param7.p_ii     = 0.4;
param7.s_ee     = 25;
param7.s_ie     = 10;
param7.s_ei     = 25;
param7.s_ii     = 25;
param7.tau_r    = 0;
param7.M        = 100;
param7.Mr       = 66;
param7.lambda_e = 1/7;
param7.lambda_i = 1/7;
param7.tau_ee   = 4;
param7.tau_ie   = 1.2;
param7.tau_i    = 4.5;
param7.gate      = 70;
duration_time   = 1000;
param7.type      ='hom';
param7.fix = false;
param7.time_delta = 1;
name7 = 'n=100-t=1000-hom-noref';
save=false;

% random inilialization
s = zeros(4,param7.ne+param7.ni);
s(2:3,:) = double(rand(2,param7.ne+param7.ni)>0.8);
s(1,:) = unidrnd(param7.M+param7.Mr+1,[1,param7.ne+param7.ni])- param7.Mr-1;

t=clock;
res7 = model_full(s, duration_time, param7);
runtime7 = etime(clock,t);



% scatterplot(res7, param7, name7,save);
% firing_rate7 = firing_rate(res7, param7);
% correlation(res7, param7, name7,save)
% hist_h(res7, param7, name7,save)
% hist_v(res7, param7, name7,savee)
% hist_t(res7, param7, name7,save)
% firing_rate7
% dynamical_motion(res7,param7,name7,save)

%% Full model: Reg, small-size, noref

param8.ne       = 75;
param8.ni       = 25;
param8.p_ee     = 0.15;
param8.p_ie     = 0.5;
param8.p_ei     = 0.5;
param8.p_ii     = 0.4;
param8.s_ee     = 25;
param8.s_ie     = 10;
param8.s_ei     = 25;
param8.s_ii     = 25;
param8.tau_r    = 0;
param8.M        = 100;
param8.Mr       = 66;
param8.lambda_e = 1/7;
param8.lambda_i = 1/7;
param8.tau_ee   = 2;
param8.tau_ie   = 1.2;
param8.tau_i    = 4.5;
param8.gate      = 70;
param8.time_delta = 1;
duration_time   = 1000;
name8 = 'n=100-t=1000-reg-noref';
save=false;
param8.type    ='reg';
param8.fix = false;
% random inilialization
s = zeros(4,param8.ne+param8.ni);
s(2:3,:) = double(rand(2,param8.ne+param8.ni)>0.8);
s(1,:) = unidrnd(param8.M+param8.Mr+1,[1,param8.ne+param8.ni])- param8.Mr-1;



%  model_full_video(s, duration_time, param8);
t = clock;
res8 = model_full(s, duration_time, param8);
runtime8 = etime(clock, t);

% 
% firing_rate8 = firing_rate(res8, param8);
% scatterplot(res8, param8,name8,save);
% correlation(res8, param8, name8, save);
% hist_h(res8, param8, name8, save);
% hist_v(res8, param8, name8, save);
% hist_t(res8, param8, name8, save);
%firing_rate8
% dynamical_motion(res8, param8, name8, save);
%% Full model: Syn, small-size, noref

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
param9.gate      = 70;
param9.time_delta = 1;
duration_time   = 1000;

name9 = 'n=100-t=1000-syn-noref';
save=false;
param9.type       ='syn';
param9.fix = false;

%random inilialization
s = zeros(4,param9.ne+param9.ni);
s(2:3,:) = double(rand(2,param9.ne+param9.ni)>0.8);
s(1,:) = unidrnd(param9.M+param9.Mr+1,[1,param9.ne+param9.ni])- param9.Mr-1;



% model_full_video(s, duration_time, param9);
t = clock;
res9 = model_full(s, duration_time, param9);
runtime9 = etime(clock,t);

%firing_rate9 = firing_rate(res9, param9);
%scatterplot(res9,param9,name9,save)
%correlation(res9,param9,name9,save)
%hist_h(res9,param9,name9,save)
%hist_v(res9,param9,name9,save)
%hist_t(res9,param9,name9,save)
%firing_rate9
% dynamical_motion(res9,param9,name9,save)
%% Coarse grained fixed probabiliy model:

c=0.2;
param10.ne=75;
param10.ni=25;

param10.P_BE_Ex=0.0067*ones(1,76)*c;
param10.P_BI_Ex=0.0104*ones(1,26)*c;
param10.P_GE_Ex=0.02*ones(1,76)*c;
param10.P_GI_Ex=0.00247*ones(1,26)*c;
param10.P_BE_E=0.029*ones(1,76)*c;
param10.P_BI_E=0.07*ones(1,26)*c;
param10.P_GE_E=ones(1,76)*c;
param10.P_GI_E=ones(1,26)*c;
param10.P_GE_I=ones(1,76)*c;
param10.P_GI_I=ones(1,26)*c;




param10.lambda_e = 1/7;
param10.lambda_i = 1/7;
param10.tau_ee   = 1.3;
param10.tau_ie   = 0.95;
param10.tau_i    = 4.5;
param10.S_e = 24;
param10.S_i = 48;
param10.a_ee=0.55;
param10.a_ie=0.45;
param10.a_ei=0.79;
param10.a_ii=0.21;
param10.pending_i_maximum=2000000;
param10.pending_e_maximum=1000000;
duration_time   = 1000;

%random initialization
s=ones(1,4);
res10=model_coarse_grained(s,duration_time,param10,P1, 0.2,0.15);
coarse_grained_plot(param10, res7, duration_time,'syn','111',false)
% line_graph(res7,time_delta,ne, ni, name)

%% Reduced network: Syn, small-size

param11.ne       = 75;
param11.ni       = 25;
param11.p_ee     = 0.15;
param11.p_ie     = 0.5;
param11.p_ei     = 0.5;
param11.p_ii     = 0.4;
param11.s_ee     = 25;
param11.s_ie     = 10;
param11.M        = 100;
param11.Mr       = 66;
param11.lambda_e = 1/7;
param11.lambda_i = 1/7;
param11.tau_ee   = 1.3;
param11.tau_ie   = 0.95;
param11.tau_i    = 4.5;
param11.method     ='truncate' % or 'extend' 

load('res7');
res=res6;%the struct in res7.mat is res6
q=[1,0.5,1.5,1,0.42,0.7,1.3];

name11 = 'n=100-t=1000-syn-noref';
save=false;
param11.type       ='syn';

s=false;

duration_time=1000;

P = P_generation_histogram(param11, res);
res11 = model_reduced_network_P(s,duration_time,param11, P,q);
scatterplot(res11,param11,name11,save);

%% Reduced network: Reg, small-size

param12.ne       = 75;
param12.ni       = 25;
param12.p_ee     = 0.15;
param12.p_ie     = 0.5;
param12.p_ei     = 0.5;
param12.p_ii     = 0.4;
param12.s_ee     = 25;
param12.s_ie     = 10;
param12.M        = 100;
param12.Mr       = 66;
param12.lambda_e = 1/7;
param12.lambda_i = 1/7;
param12.tau_ee   = 2;
param12.tau_ie   = 1.2;
param12.tau_i    = 4.5;
param12.method     ='truncate' % or 'extend' 

load('res7');
res=res6;%the struct in res7.mat is res6
q=[1,0.5,1.5,1,0.42,0.7,1.3];

name10 = 'n=100-t=1000-reg-noref';
save=false;
param12.type       ='reg';

s=false;

duration_time=1000;

P = P_generation_histogram(param12, res);
res12 = model_reduced_network_P(s,duration_time,param12, P,q);
scatterplot(res12,param12,name12,save);

%% Reduced network: Hom, small-size

param13.ne       = 75;
param13.ni       = 25;
param13.p_ee     = 0.15;
param13.p_ie     = 0.5;
param13.p_ei     = 0.5;
param13.p_ii     = 0.4;
param13.s_ee     = 25;
param13.s_ie     = 10;
param13.M        = 100;
param13.Mr       = 66;
param13.lambda_e = 1/7;
param13.lambda_i = 1/7;
param13.tau_ee   = 4;
param13.tau_ie   = 1.2;
param13.tau_i    = 4.5;
param13.method     ='truncate' % or 'extend' 

load('res7');
res=res6;
q=[1,0.5,1.5,1,0.42,0.7,1.3];
    
name13 = 'n=100-t=1000-hom-noref';
save=false;
param13.type       ='hom';

s=false;

duration_time=1000;

P = P_generation_histogram(param13, res);
res13 = model_reduced_network_P(s,duration_time,param13, P,q);
scatterplot(res13,param13,name13,save);

