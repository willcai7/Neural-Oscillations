% two kinds of reduced models for neural oscillations

%% Setting paths
addpath(genpath(pwd));


%% Reduced network: Syn, small-size

param1.ne       = 75;
param1.ni       = 25;
param1.p_ee     = 0.15;
param1.p_ie     = 0.5;
param1.p_ei     = 0.5;
param1.p_ii     = 0.4;
param1.s_ee     = 25;
param1.s_ie     = 10;
param1.M        = 100;
param1.Mr       = 66;
param1.lambda_e = 1/7;
param1.lambda_i = 1/7;
param1.tau_ee   = 1.3;
param1.tau_ie   = 0.95;
param1.tau_i    = 4.5;
param1.model    = 'model_reduced_twos';

q               =[1,0.5,1.5,1,0.42,0.7,1.3];

name1          = 'syn-noref-n=100-t=1000';
save            = false;
param1.type     = 'syn';
s               = false;
duration_time   = 1000;

res1 = model_reduced_network(s,duration_time,param1, P,q);
scatterplot(res1,param1,name1,save);

%% Reduced network: Reg, small-size

param2.ne       = 75;
param2.ni       = 25;
param2.p_ee     = 0.15;
param2.p_ie     = 0.5;
param2.p_ei     = 0.5;
param2.p_ii     = 0.4;
param2.s_ee     = 25;
param2.s_ie     = 10;
param2.M        = 100;
param2.Mr       = 66;
param2.lambda_e = 1/7;
param2.lambda_i = 1/7;
param2.tau_ee   = 2;
param2.tau_ie   = 1.2;
param2.tau_i    = 4.5;
param2.model    = 'model_reduced_twos';

q=[1,0.5,1.5,1,0.42,0.7,1.3];

name2 = 'reg-noref-n=100-t=1000';
save=false;
param2.type       ='reg';

s=false;

duration_time=1000;

res2 = model_reduced_network(s,duration_time,param2, P,q);
scatterplot(res2,param2,name2,save);

%% Reduced network: Hom, small-size

param3.ne       = 75;
param3.ni       = 25;
param3.p_ee     = 0.15;
param3.p_ie     = 0.5;
param3.p_ei     = 0.5;
param3.p_ii     = 0.4;
param3.s_ee     = 25;
param3.s_ie     = 10;
param3.M        = 100;
param3.Mr       = 66;
param3.lambda_e = 1/7;
param3.lambda_i = 1/7;
param3.tau_ee   = 4;
param3.tau_ie   = 1.2;
param3.tau_i    = 4.5;
param3.model    = 'model_reduced_twos';

q=[1,0.5,1.5,1,0.42,0.7,1.3];
    
name3 = 'hom-noref-n=100-t=1000';
save  = false;
param3.type       ='hom';

s=false;
duration_time=1000;

res3 = model_reduced_network(s,duration_time,param3, P,q);
scatterplot(res13,param3,name3,save);

%% Coarse grained fixed probabiliy model: Syn, small-size

c=0.2;
param4.ne=75;
param4.ni=25;

param4.P_BE_Ex=0.0067*ones(1,76)*c;
param4.P_BI_Ex=0.0104*ones(1,26)*c;
param4.P_GE_Ex=0.02*ones(1,76)*c;
param4.P_GI_Ex=0.00247*ones(1,26)*c;
param4.P_BE_E=0.029*ones(1,76)*c;
param4.P_BI_E=0.07*ones(1,26)*c;
param4.P_BE_E=ones(1,76)*c;
param4.P_GI_E=ones(1,26)*c;
param4.P_GE_I=ones(1,76)*c;
param4.P_GI_I=ones(1,26)*c;




param4.lambda_e = 1/7;
param4.lambda_i = 1/7;
param4.tau_ee   = 1.3;
param4.tau_ie   = 0.95;
param4.tau_i    = 4.5;
param4.S_e = 24;
param4.S_i = 48;
param4.a_ee=0.55;
param4.a_ie=0.45;
param4.a_ei=0.79;
param4.a_ii=0.21;
param4.pending_i_maximum=2000000;
param4.pending_e_maximum=1000000;
duration_time   = 1000;

%random initialization
s=ones(1,4);
res4=model_coarse_grained(s,duration_time,param4,P1, 0.2,0.15);
coarse_grained_plot(param4, res4, duration_time,'syn','111',false)
% line_graph(res7,time_delta,ne, ni, name)

%% Coarse grained fixed probabiliy model: Reg, small-size

c=0.2;
param5.ne=75;
param5.ni=25;

param5.P_BE_Ex=0.0067*ones(1,76)*c;
param5.P_BI_Ex=0.0104*ones(1,26)*c;
param5.P_GE_Ex=0.02*ones(1,76)*c;
param5.P_GI_Ex=0.00247*ones(1,26)*c;
param5.P_BE_E=0.029*ones(1,76)*c;
param5.P_BI_E=0.07*ones(1,26)*c;
param5.P_BE_E=ones(1,76)*c;
param5.P_GI_E=ones(1,26)*c;
param5.P_GE_I=ones(1,76)*c;
param5.P_GI_I=ones(1,26)*c;




param5.lambda_e = 1/7;
param5.lambda_i = 1/7;
param5.tau_ee   = 1.3;
param5.tau_ie   = 0.95;
param5.tau_i    = 4.5;
param5.S_e = 24;
param5.S_i = 48;
param5.a_ee=0.55;
param5.a_ie=0.45;
param5.a_ei=0.79;
param5.a_ii=0.21;
param5.pending_i_maximum=2000000;
param5.pending_e_maximum=1000000;
duration_time   = 1000;

%random initialization
s=ones(1,4);
res5=model_coarse_grained(s,duration_time,param5,P1, 0.2,0.15);
coarse_grained_plot(param5, res5, duration_time,'syn','111',false)
% line_graph(res7,time_delta,ne, ni, name)

%% Coarse grained fixed probabiliy model: Hom, small-size

c=0.2;
param6.ne=75;
param6.ni=25;

param6.P_BE_Ex=0.0067*ones(1,76)*c;
param6.P_BI_Ex=0.0104*ones(1,26)*c;
param6.P_GE_Ex=0.02*ones(1,76)*c;
param6.P_GI_Ex=0.00247*ones(1,26)*c;
param6.P_BE_E=0.029*ones(1,76)*c;
param6.P_BI_E=0.07*ones(1,26)*c;
param6.P_BE_E=ones(1,76)*c;
param6.P_GI_E=ones(1,26)*c;
param6.P_GE_I=ones(1,76)*c;
param6.P_GI_I=ones(1,26)*c;



param6.lambda_e = 1/7;
param6.lambda_i = 1/7;
param6.tau_ee   = 1.3;
param6.tau_ie   = 0.95;
param6.tau_i    = 4.5;
param6.S_e = 24;
param6.S_i = 48;
param6.a_ee=0.55;
param6.a_ie=0.45;
param6.a_ei=0.79;
param6.a_ii=0.21;
param6.pending_i_maximum=2000000;
param6.pending_e_maximum=1000000;
duration_time   = 1000;

%random initialization
s=ones(1,4);
res6=model_coarse_grained(s,duration_time,param6,P1, 0.2,0.15);
coarse_grained_plot(param6, res6, duration_time,'syn','111',false)
% line_graph(res6,time_delta,ne, ni, name)
