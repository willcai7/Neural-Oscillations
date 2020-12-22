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
param1.duration  = 3000;

% cluster
param1.cluster_delta = 0.33;
param1.cluster_eps   = 8;

% SSI
param1. w = 1;

% spectrogram
param1.sdbin = 2.5;
param1.spectrogram_timewindow = 200;
param1.frequency_range = [40,80];

%About 300 ms
s               = false;
param1.model    = 'model_full';
param1.type     = 'syn';
param1.fix      = false;                                                        % to decide whether the pending spike ratio is fixed.
save            = true;
name1           ='hom-n=400-t=3000';
param1.time_delta = 1;
t = clock;
res1 = model_full(s, duration_time, param1);
runtime1 = etime(clock, t);

% rasterplot(res1, param1, name1, save);
% firing_rate1 = firing_rate(res1, param1);
% SSI1 = spike_synchrony_index(res1, param1);
% correlation(res1, param1, name1, save);
% line_graph(res1, param1, name1, save, 40);
% sd1 = spikedensity(res1, param1);
% spectrogram(sd1.e, param1, name1, save);
% cluster_dissection(sd1.e, param1, name1, save);

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
param2.duration  = 3000;
param2.model    = 'model_full';
param2.type      = 'reg';
param2.fix = false;
name2           ='reg-n=400-t=3000';
s               = false;
save            = true;
param2.time_delta = 1;
t = clock;
res2 = model_full(s, duration_time, param2);
runtime2 = etime(clock, t);
% cluster
param2.cluster_delta = 0.33;
param2.cluster_eps   = 8;

% SSI
param2. w = 1;

% spectrogram
param2.sdbin = 2.5;
param2.spectrogram_timewindow = 200;
param2.frequency_range = [40,80];

% rasterplot(res2, param2,name2,save);
% firing_rate2 = firing_rate(res2, param2);
% correlation(res2, param2,name2,save);
% SSI2 = spike_synchrony_index(res2, param2);
% line_graph(res2, param2, name2, save, 40);
% sd2 = spikedensity(res2, param2);
% spectrogram(sd2.e, param2, name2, save);
% cluster_dissection(sd2.e, param2, name2, save);

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
param3.duration  = 3000;
param3.type     = 'syn';
param3.model    = 'model_full';
param3.fix = false;
name3           ='syn-n=400-t=3000';
s               = false;
save            = true;
param3.time_delta = 1;
t=clock;
% cluster
param3.cluster_delta = 0.33;
param3.cluster_eps   = 8;

% SSI
param3. w = 1;

% spectrogram
param3.sdbin = 2.5;
param3.spectrogram_timewindow = 200;
param3.frequency_range = [40,80];
res3 = model_full(s, duration_time, param3);
runtime3 = etime(clock, t);

% rasterplot(res3, param3, name3, save);
% firing_rate3 = firing_rate(res3, param3);
% correlation(res3, param3,name3,save);
% SSI3 = spike_synchrony_index(res3, param3);
% line_graph(res3, param3, name3, save, 40);
% sd3 = spikedensity(res3, param3);
% spectrogram(sd3.e, param3, name3, save);
% cluster_dissection(sd3.e, param3, name3, save);

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
param4.gate     = 70;
param4.duration = 1000;
param4.type     = 'hom';
param4.model    = 'model_full';
param4.fix = false; 
param4.time_delta = 1;

name4 = 'hom-n=100-t=3000';
save=true;

% cluster
param4.cluster_delta = 0.33;
param4.cluster_eps   = 8;

% SSI
param4. w = 1;

% spectrogram
param4.sdbin = 2.5;
param4.spectrogram_timewindow = 200;
param4.frequency_range = [10,80];

% random inilialization
s = zeros(4,param4.ne+param4.ni);
s(2:3,:) = double(rand(2,param4.ne+param4.ni)>0.8);
s(1,:) = unidrnd(param4.M+param4.Mr+1,[1,param4.ne+param4.ni])- param4.Mr-1;


%  model_full_video(s, duration_time, param4);
t=clock;
%res4 = model_full(s, param4);
runtime4 = etime(clock,t);


% rasterplot(res4, param4, name4, save);
% firing_rate4 = firing_rate(res4, param4);
% correlation(res4, param4,name4,save);
% SSI4 = spike_synchrony_index(res4, param4);
% line_graph(res4, param4, name4, save, 40);
% sd4 = spikedensity(res4, param4);
% spectrogram(sd4.e, param4, name4, save);
% cluster_dissection(sd4.e, param4, name4, save);

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
param5.gate     = 70;
param5.duration = 3000;
name5 = 'reg-n=100-t=3000';
param5.time_delta = 1;
param5.model    = 'model_full';
save=true;
param5.type    ='reg';
param5.fix = false;
% cluster
param5.cluster_delta = 0.33;
param5.cluster_eps   = 8;

% SSI
param5. w = 1;

% spectrogram
param5.sdbin = 2.5;
param5.spectrogram_timewindow = 200;
param5.frequency_range = [10,80];

% random inilialization
s = zeros(4,param5.ne+param5.ni);
s(2:3,:) = double(rand(2,param5.ne+param5.ni)>0.8);
s(1,:) = unidrnd(param5.M+param5.Mr+1,[1,param5.ne+param5.ni]) - param5.Mr - 1;



% model_full_video(s, duration_time, param5);
t = clock;
res5 = model_full(s,  param5);
runtime5 = etime(clock, t);

% rasterplot(res5, param5, name5, save)
% firing_rate5 = firing_rate(res5, param5);
% correlation(res5, param5,name5,save);
SSI5 = spike_synchrony_index(res5, param5);
disp(num2str(SSI5));
% line_graph(res5, param5, name5, save, 40);
% sd5 = spikedensity(res5, param5);
% spectrogram(sd5.e, param5, name5, save);
% cluster_dissection(sd5.e, param5, name5, save);


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
param6.duration   = 3000;
param6.model    = 'model_full';
param6.time_delta = 1;

name6 = 'syn-n=100-t=3000';
save=true;
param6.type       ='syn';
param6.fix = false;

% cluster
param6.cluster_delta = 0.33;
param6.cluster_eps   = 8;

% SSI
param6. w = 1;

% spectrogram
param6.sdbin = 2.5;
param6.spectrogram_timewindow = 200;
param6.frequency_range = [10,80];

%random inilialization
s = zeros(4,param6.ne+param6.ni);
s(2:3,:) = double(rand(2,param6.ne+param6.ni)>0.8);
s(1,:) = unidrnd(param6.M+param6.Mr+1,[1,param6.ne+param6.ni])- param6.Mr-1;



% model_full_video(s, duration_time, param6);
t = clock;
%res6 = model_full(s,  param6);
runtime6 = etime(clock,t);


% rasterplot(res6, param6, name6, save);
% firing_rate6 = firing_rate(res6, param6);
% correlation(res6, param6,name6,save);
% SSI6 = spike_synchrony_index(res6, param6);
% line_graph(res6, param6, name6, save, 40);
% sd6 = spikedensity(res6, param6);
% spectrogram(sd6.e, param6, name6, save);
% cluster_dissection(sd6.e, param6, name6, save);

%% Full model: Hom, small-size, noref

param7.ne       = 75;
param7.ni       = 25;
param7.p_ee     = 0.15;
param7.p_ie     = 0.5;
param7.p_ei     = 0.5;
param7.p_ii     = 0.4;
param7.s_ee     = 20;
param7.s_ie     = 8;
param7.s_ei     = 20;
param7.s_ii     = 20;
param7.tau_r    = 0;
param7.M        = 100;
param7.Mr       = 66;
param7.lambda_e = 1/7;
param7.lambda_i = 1/7;
param7.tau_ee   = 4;
param7.tau_ie   = 1.2;
param7.tau_i    = 4.5;
param7.gate      = 70;
param7.duration  = 3200;
param7.type      ='hom';
param7.model    = 'model_full';
param7.fix = false;
param7.time_delta = 1;

% random inilialization
s = zeros(4,param7.ne+param7.ni);
s(2:3,:) = double(rand(2,param7.ne+param7.ni)>0.8);
s(1,:) = unidrnd(param7.M+param7.Mr+1,[1,param7.ne+param7.ni])- param7.Mr-1;

t=clock;
%res7 = model_full(s, param7);
runtime7 = etime(clock,t);

% spectrogram
param7.w = 1;
param7.sdbin = 2.5;
param7.spectrogram_timewindow = 200;
param7.frequency_range = [10,80];

%% Full model: Reg, small-size, noref

param8.ne       = 75;
param8.ni       = 25;
param8.p_ee     = 0.15;
param8.p_ie     = 0.5;
param8.p_ei     = 0.5;
param8.p_ii     = 0.4;
param8.s_ee     = 20;
param8.s_ie     = 8;
param8.s_ei     = 20;
param8.s_ii     = 20;
param8.tau_r    = 0;
param8.M        = 100;
param8.Mr       = 66;
param8.lambda_e = 1/7;
param8.lambda_i = 1/7;
param8.tau_ee   = 1.7;
param8.tau_ie   = 1.2;
param8.tau_i    = 4.5;
param8.gate      = 70;
param8.time_delta = 1;
param8.duration   = 3200;
param8.model    = 'model_full';
param8.type    ='reg';
param8.fix = false;
% random inilialization
s = zeros(4,param8.ne+param8.ni);
s(2:3,:) = double(rand(2,param8.ne+param8.ni)>0.8);
s(1,:) = unidrnd(param8.M+param8.Mr+1,[1,param8.ne+param8.ni])- param8.Mr-1;

% spectrogram
param8.w = 1;
param8.sdbin = 2.5;
param8.spectrogram_timewindow = 200;
param8.frequency_range = [10,80];

%  model_full_video(s, duration_time, param8);
t = clock;
%res8 = model_full(s, param8);
runtime8 = etime(clock, t);

%% Full model: Syn, small-size, noref

param9.ne       = 75;
param9.ni       = 25;
param9.p_ee     = 0.15;
param9.p_ie     = 0.5;
param9.p_ei     = 0.5;
param9.p_ii     = 0.4;
param9.s_ee     = 20;
param9.s_ie     = 8;
param9.s_ei     = 20;
param9.s_ii     = 20;
param9.tau_r    = 0;
param9.M        = 100;
param9.Mr       = 66;
param9.lambda_e = 1/7;
param9.lambda_i = 1/7;
param9.tau_ee   = 1.4;
param9.tau_ie   = 1.2;
param9.tau_i    = 4.5;
param9.gate      = 70;
param9.time_delta = 1;
param9.duration   = 3200;
param9.model      = 'model_full';
param9.type       ='syn';
param9.fix = false;

%random inilialization
s = false;

% spectrogram
param9.w = 1;
param9.sdbin = 2.5;
param9.spectrogram_timewindow = 200;
param9.frequency_range = [10,80];
param9.cluster_delta = 0.15;
param9.cluster_eps   = 8;

% model_full_video(s, duration_time, param9);
t = clock;
%res9 = model_full(s, param9);
runtime9 = etime(clock,t);

%% Plot

save = 1;
name7 = 'hom-noref-n=100-t=3000';
name8 = 'reg-noref-n=100-t=3000';
name9 = 'syn-noref-n=100-t=3000';

% Nonref, small-size, hom
firing_rate7 = firing_rate(res7, param7);
SSI7 = spike_synchrony_index(res7, param7);
rasterplot(res7, param7, name7, save);
correlation(res7, param7, name7,save);
line_graph(res7, param7, name7, save, 40);
sd7 = spikedensity(res7, param7);
spectrogram(sd7.e, param7, name7, save);

% Nonref, small-size, reg
firing_rate8 = firing_rate(res8, param8);
SSI8 = spike_synchrony_index(res8, param8);
rasterplot(res8, param8, name8, save);
correlation(res8, param8, name8, save);
line_graph(res8, param8, name8, save, 40);
sd8 = spikedensity(res8, param8);
spectrogram(sd8.e, param8, name8, save);

% Nonref, small-size, syn
firing_rate9 = firing_rate(res9, param9);
SSI9 = spike_synchrony_index(res9, param9);
rasterplot(res9, param9, name9, save);
correlation(res9, param9, name9,save);
line_graph(res9, param9, name9, save, 40);
sd9 = spikedensity(res9, param9);
spectrogram(sd9.e, param9, name9, save);
cluster_dissection(sd9.e, param9,name9, save);


