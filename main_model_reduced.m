% two kinds of reduced models for neural oscillations

%% Setting paths
addpath(genpath(pwd));

%% Common param

param.ne         = 75;
param.ni         = 25;
param.p_ee       = 0.15;
param.p_ie       = 0.5;
param.p_ei       = 0.5;
param.p_ii       = 0.4;
param.s_ee       = 25;
param.s_ie       = 10;
param.s_ei       = 25;
param.s_ii       = 25;
param.M          = 100;
param.Mr         = 66;
param.lambda_e   = 1/7;
param.lambda_i   = 1/7;

%% Reduced network: Hom, small-size

two_param1          = param;
two_param1.tau_ee   = 4;
two_param1.tau_ie   = 1.2;
two_param1.tau_i    = 4.5;
two_param1.model    = 'model_reduced_twos';
name1          = 'hom-reduced-n=100-t=3000 ';
save            = true;
two_param1.type     = 'syn';
s               = false;
two_param1.duration = 1000;

% cluster
two_param1.cluster_delta = 0.33;
two_param1.cluster_eps   = 8;

% SSI
two_param1. w = 7;

% spectrogram
two_param1.sdbin = 2.5;
two_param1.spectrogram_timewindow = 200;
two_param1.frequency_range = [40,80];

t = clock;
two_res1 = model_reduced_network(s,two_param1, P1_stat);
runtime1 = etime(clock,t);

% rasterplot(two_res1,two_param1,name1,save);
% firing_rate1 = firing_rate(two_res1, two_param1);
% SSI1 = spike_synchrony_index(two_res1, two_param1);
% correlation(two_res1, two_param1, name1, save);
% line_graph(two_res1, two_param1, name1, save, 40);
% two_sd1 = spikedensity(two_res1, two_param1);
% spectrogram(two_sd1.e, two_param1, name1, save);
% cluster_dissection(two_sd1.e, two_param1, name1, save);

%% Reduced network: Reg, small-size

two_param2.ne       = 75;
two_param2.ni       = 25;
two_param2.p_ee     = 0.15;
two_param2.p_ie     = 0.5;
two_param2.p_ei     = 0.5;
two_param2.p_ii     = 0.4;
two_param2.s_ee     = 25;
two_param2.s_ie     = 10;
two_param2.M        = 100;
two_param2.Mr       = 66;
two_param2.lambda_e = 1/7;
two_param2.lambda_i = 1/7;
two_param2.tau_ee   = 2;
two_param2.tau_ie   = 1.2;
two_param2.tau_i    = 4.5;
two_param2.model    = 'model_reduced_twos';

% cluster
two_param2.cluster_delta = 0.33;
two_param2.cluster_eps   = 8;

% SSI
two_param2. w = 7;

% spectrogram
two_param2.sdbin = 2.5;
two_param2.spectrogram_timewindow = 200;
two_param2.frequency_range = [40,80];
name2 = 'reg-reduced-n=100-t=3000';
save=true;
two_param2.type         = 'reg';  
s                   = false;
two_param2.duration     = 1000;

t = clock;
two_res2 = model_reduced_network(s,two_param2, P2_stat);
runtime2 = etime(clock,t);
% rasterplot(two_res2,two_param2,name2,save);
% firing_rate2 = firing_rate(two_res2, two_param2);
% correlation(two_res2, two_param2,name2,save);
% SSI2 = spike_synchrony_index(two_res2, two_param2);
% line_graph(two_res2, two_param2, name2, save, 40);
% two_sd2 = spikedensity(two_res2, two_param2);
% spectrogram(two_sd2.e, two_param2, name2, save);
% cluster_dissection(two_sd2.e, two_param2, name2, save);

%% Reduced network: Syn, small-size

two_param3.ne       = 75;
two_param3.ni       = 25;
two_param3.p_ee     = 0.15;
two_param3.p_ie     = 0.5;
two_param3.p_ei     = 0.5;
two_param3.p_ii     = 0.4;
two_param3.s_ee     = 25;
two_param3.s_ie     = 10;
two_param3.M        = 100;
two_param3.Mr       = 66;
two_param3.lambda_e = 1/7;
two_param3.lambda_i = 1/7;
two_param3.tau_ee   = 1.3;
two_param3.tau_ie   = 0.95;
two_param3.tau_i    = 4.5;
two_param3.model    = 'model_reduced_twos';


% cluster
two_param3.cluster_delta = 0.33;
two_param3.cluster_eps   = 8;

% SSI
two_param3. w = 7;

% spectrogram
two_param3.sdbin = 2.5;
two_param3.spectrogram_timewindow = 200;
two_param3.frequency_range = [10,80];
name3                      = 'syn-reduced-n=100-t=3000';
save                       = false;
two_param3.type            = 'syn';

s=false;
two_param3.duration = 1000;

%res3 = model_reduced_network(s,duration_time,param3, P,q);
t = clock;
two_res3 = model_reduced_network(s,two_param3, P3_stat_ref);
runtime3 = etime(clock,t);
% rasterplot(two_res3,two_param3,name3,save);
% firing_rate3 = firing_rate(two_res3, two_param3);
% correlation(two_res3, two_param3,name3,save);
% SSI3 = spike_synchrony_index(two_res3, two_param3);
% line_graph(two_res3, two_param3, name3, save, 40);
% two_sd3 = spikedensity(two_res3, two_param3);
% spectrogram(two_sd3.e, two_param3, name3, save);
% cluster_dissection(two_sd3.e, two_param3, name3, save);

%%
res = two_res3;
t = res.t;
subplot(6,1,1);
plot(t, res.ratio(1,:));
subplot(6,1,2);
plot(t, res.ratio(2,:));
subplot(6,1,3);
plot(t, res.ratio(3,:));
subplot(6,1,4);
plot(t, res.ratio(4,:));
subplot(6,1,5);
plot(t, res.ratio(5,:));
subplot(6,1,6);
plot(t, res.ratio(6,:));

%% Coarse grained fixed probabiliy model: Syn, small-size
param4.ne=75;
param4.ni=25;
param4.lambda_e = 1/7;
param4.lambda_i = 1/7;
param4.tau_ee   = 1.3;
param4.tau_ie   = 0.95;
param4.tau_i    = 4.5;
param4.S_ee = 11;
param4.S_ie = 13;
param4.S_e = 24;
param4.S_i = 48;
param4.a_ee=0.455;
param4.a_ie=0.545;
param4.a_ei=0.79;
param4.a_ii=0.21;
param4.pending_i_maximum=2000000;
param4.pending_e_maximum=1000000;
param4.model = 'model_reduced_coag';
param4.duration= 3000;
param4.cluster_delta = 0.33;
param4.cluster_eps   = 8;

% SSI
param4. w = 7;

% spectrogram
param4.sdbin = 2.5;
param4.spectrogram_timewindow = 200;
param4.frequency_range = [10,80];
%random initialization
s=ones(1,4);
q = ones(1,10);
save = true;
name = 'syn-reduced-n=100-t=3000';
res4 = model_coarse_grained(s,param4, P3_stat);
%coarse_grained_plot(res4,param4, name, save);
%sd4 = spikedensity_coarse(res4, param4);
%coarse_grained_rasterplot(res4, param4, save, name);
%cluster_dissection(sd4.e, param4, name, save);
spectrogram(sd4.e, param4,name, save);
% line_graph(res7,time_delta,ne, ni, name);

%% Coarse grained fixed probabiliy model: Reg, small-size

c=0.2;
param5.ne=75;
param5.ni=25;




param5.lambda_e = 1/7;
param5.lambda_i = 1/7;
param5.tau_ee   = 2;
param5.tau_ie   = 1.2;
param5.tau_i    = 4.5;
param5.S_e = 24;
param5.S_i = 48;
param5.a_ee=0.49;
param5.a_ie=0.51;
param5.a_ei=0.79;
param5.a_ii=0.21;
param5.pending_i_maximum=2000000;
param5.pending_e_maximum=1000000;
param5.duration   = 3000;
param5.model = 'model_reduced_coag';
name = 'reg-reduced-n=100-t=3000';
%random initialization

% spectrogram
param5. w = 7;
param5.sdbin = 2.5;
param5.spectrogram_timewindow = 200;
param5.frequency_range = [10,80];
param5.cluster_delta = 0.33;
param5.cluster_eps   = 8;
s=ones(1,4);
res5=model_coarse_grained(s,param5,P2_stat);
coarse_grained_plot(res5, param5, name, save);
%coarse_grained_rasterplot(res5, param5, save, name);
% line_graph(res7,time_delta,ne, ni, name)
sd5 = spikedensity_coarse(res5, param5);
spectrogram(sd5.e, param5,name, save);
cluster_dissection(sd5.e, param5, name, save);
%% Coarse grained fixed probabiliy model: Hom, small-size

c=0.2;
param6.ne=75;
param6.ni=25;

param6.lambda_e = 1/7;
param6.lambda_i = 1/7;
param6.tau_ee   = 4;
param6.tau_ie   = 1.2;
param6.tau_i    = 4.5;
param6.S_e = 24;
param6.S_i = 48;
param6.a_ee=0.63;
param6.a_ie=0.37;
param6.a_ei=0.79;
param6.a_ii=0.21;
param6.pending_i_maximum=2000000;
param6.pending_e_maximum=1000000;
param6.duration = 3000;
param6.model = 'model_reduced_coag';
name = 'hom-reduced-n=100-t=3000';
%random initialization
param6. w = 7;
param6.sdbin = 2.5;
param6.spectrogram_timewindow = 200;
param6.frequency_range = [10,80];
param6.cluster_delta = 0.33;
param6.cluster_eps   = 8;


s=ones(1,4);
res6=model_coarse_grained(s,param6,P1_stat);
%coarse_grained_plot(res6, param6, name, save)
coarse_grained_rasterplot(res6, param6, save, name);
sd6 = spikedensity_coarse(res6, param6);
spectrogram(sd6.e, param6,name, save);
cluster_dissection(sd6.e, param6, name, save);