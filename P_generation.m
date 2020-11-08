%% Setting paths
addpath(genpath(pwd));

%% Common Parameters

bar.e            = 40;
bar.i            = 40;
param.ne         = 75;
param.ni         = 25;
param.p_ee       = 0.15;
param.p_ie       = 0.5;
param.p_ei       = 0.5;
param.p_ii       = 0.4;
param.s_ee       = 20;
param.s_ie       = 8;
param.s_ei       = 20;
param.s_ii       = 20;
param.M          = 100;
param.Mr         = 66;
param.lambda_e   = 1/7;
param.lambda_i   = 1/7;

%% Full model: Hom, small-size, long time

param1            = param;
param1.tau_ee     = 4;
param1.tau_ie     = 1.2;
param1.tau_i      = 4.5;
param1.gate       = 40;
param1.duration   = 10000;
param1.type       = 'hom';
param1.fix        = false;
param1.time_delta = 0.2;

param1.rare_range_e        = 15;                                            % range definition of rare events of e neurons
param1.rare_range_i        = 5;                                             % range definition of rare events of i neurons
param1.simulation_times    = 6000;                                          % times of rare events simulation
param1.simulation_duration = 1;                                             % duration of each simulation
save                       = false;

% random inilialization
s        = false;

% ref
param1.tau_r          = 0;
t                     = clock;
%P_res1_noref          = model_full(s, param1);
runtime1              = etime(clock,t);
%rare_res1_noref       = rare_model_full(P_res1_noref,param1, bar);

%% Full model: Reg, small-size, noref, long time

param2            = param;
param2.tau_ee     = 1.7;
param2.tau_ie     = 1.2;
param2.tau_i      = 4.5;
param2.gate       = 40;
param2.time_delta = 0.2;
param2.duration   = 10000;
param2.rare_range_e         = 15;                                           % range definition of rare events of e neurons
param2.rare_range_i         = 5;                                            % range definition of rare events of i neurons
param2.simulation_times     = 6000;                                         % times of rare events simulation
param2.simulation_duration  = 1;                                            % duration of each simulation
name2           = 'n=100-t=1000-reg-noref';
save            = false;
param2.type     = 'reg';
param2.fix      = false;
s               = false;

param2.tau_r    = 0;
t               = clock;
%P_res2_noref    = model_full(s, param2);
runtime2        = etime(clock, t);
%rare_res2_noref = rare_model_full(P_res2_noref, param2, bar);


%%  Full model: Syn, small-size, noref, long time
param3            = param;
param3.tau_ee     = 1.4;
param3.tau_ie     = 1.2;
param3.tau_i      = 4.5;
param3.gate       = 40;
param3.duration   = 10000;
param3.time_delta = 0.2;

param3.rare_range_e         = 15;                                           % range definition of rare events of e neurons
param3.rare_range_i         = 5;                                            % range definition of rare events of i neurons
param3.simulation_times     = 6000;                                         % times of rare events simulation
param3.simulation_duration  = 1;                                            % duration of each simulation

param3.fix          = false;
name3               = 'n=100-t=1000-syn-noref';
save                = false;
param3.type         = 'syn';
%random inilialization
s                   = false;

% noref
param3.tau_r    = 0;
t               = clock;
%P_res3_noref    = model_full(s,  param3);
runtime3        = etime(clock,t);
%rare_res3_noref = rare_model_full(P_res3_noref,param3, bar);



%% Full model: Between Hom & Reg, small-size, long time

param4            = param;
param4.tau_ee     = 3;
param4.tau_ie     = 1.2;
param4.tau_i      = 4.5;
param4.gate       = 70;
param4.duration   = 10000;
param4.type       = 'hom';
param4.fix        = false;
param4.time_delta = 0.2;

param4.rare_range_e=15;                                                     % range definition of rare events of e neurons
param4.rare_range_i=5;                                                      % range definition of rare events of i neurons
param4.simulation_times=6000;                                               % times of rare events simulation
param4.simulation_duration=1;                                               % duration of each simulation

name4 = 'n=100-t=1000-hom-noref';
param4.method   = 'extend';
save        =false;

% random inilialization
s        = false;

% noref
% param1.tau_r    = 0;
% t               = clock;
% res1_noref      = model_full(s, duration_time, param1);
% runtime1        = etime(clock,t);
% rare_res1_noref = rare_model_full(res1_noref,param1);

% ref
param4.tau_r    = 2.5;
t               = clock;
%P_res4          = model_full(s, param4);
runtime4        = etime(clock,t);
%rare_res4       = rare_model_full(P_res4,param4, bar);

%% Full model: Between reg & syn, small-size, long time

param5            = param;
param5.tau_ee     = 1.65;
param5.tau_ie     = 1.075;
param5.tau_i      = 4.5;
param5.gate       = 70;
param5.duration   = 10000;
param5.type       = 'hom';
param5.fix        = false;
param5.time_delta = 0.2;
param5.rare_range_e=15;                                                     % range definition of rare events of e neurons
param5.rare_range_i=5;                                                      % range definition of rare events of i neurons
param5.simulation_times=6000;                                               % times of rare events simulation
param5.simulation_duration=1;                                               % duration of each simulation

name5 = 'n=100-t=1000-hom-noref';
param5.method   = 'extend';
save        =false;

% random inilialization
s        = false;

% noref
% param1.tau_r    = 0;
% t               = clock;
% res1_noref      = model_full(s, duration_time, param1);
% runtime1        = etime(clock,t);
% rare_res1_noref = rare_model_full(res1_noref,param1);

% ref
param5.tau_r    = 2.5;
t               = clock;
%P_res5            = model_full(s, param5);
runtime5        = etime(clock,t);
%rare_res5       = rare_model_full(P_res5,param5, bar);

%% Calculate the P
bar.e = 45;
bar.i = 45;
% Statistical method
%P1_stat_noref = P_generation_statistics(P_res1_noref, rare_res1_noref, param1, bar);
%P2_stat_noref = P_generation_statistics(P_res2_noref, rare_res2_noref, param2, bar);
%P3_stat_noref = P_generation_statistics(P_res3_noref, rare_res3_noref, param3, bar);

% P1_stat1 = P_generation_statistics(P_res1, rare_res1, param, bar);
% P2_stat1 = P_generation_statistics(P_res2, rare_res2, param, bar);
 P3_stat1 = P_generation_statistics(P_res3, rare_res3, param, bar);
% P4_stat = P_generation_statistics(P_res4, rare_res4, param, bar);
% P5_stat = P_generation_statistics(P_res5, rare_res5, param, bar);

%% P versus different tau_ee/tau_ie
ne = param.ne;
ni = param.ni;
xe = (1:1:(ne+1));
xi = (1:1:(ni+1));
subplot(5,2,1);
plot(xe, P1_stat.P_BE_Ex);
hold on
plot(xe, P2_stat.P_BE_Ex);
hold on
plot(xe, P3_stat.P_BE_Ex);
hold on
plot(xe, P4_stat.P_BE_Ex);
hold on
plot(xe, P5_stat.P_BE_Ex);
title('P^{BE}_{Ex}');
ylabel('Prob');
subplot(5,2,2);
plot(xi, P1_stat.P_BI_Ex);
hold on
plot(xi, P2_stat.P_BI_Ex);
hold on
plot(xi, P3_stat.P_BI_Ex);
hold on
plot(xi, P4_stat.P_BI_Ex);
hold on
plot(xi, P5_stat.P_BI_Ex);
title('P^{BI}_{Ex}');
ylabel('Prob');
le = legend('\tau_{ee},\tau_{ie}=(4,1.2)','\tau_{ee},\tau_{ie}=(2,1.2)', '\tau_{ee},\tau_{ie}=(1.3,0.95)', '\tau_{ee},\tau_{ie}=(3,1.2)','\tau_{ee},\tau_{ie}=(1.7,1.1)','location','northeast','orientation','horizontal');

subplot(5,2,3);
plot(xe, P1_stat.P_GE_Ex);
hold on
plot(xe, P2_stat.P_GE_Ex);
hold on
plot(xe, P3_stat.P_GE_Ex);
hold on
plot(xe, P4_stat.P_GE_Ex);
hold on
plot(xe, P5_stat.P_GE_Ex);
title('P^{GE}_{Ex}');
ylabel('Prob');
subplot(5,2,4);
plot(xi, P1_stat.P_GI_Ex);
hold on
plot(xi, P2_stat.P_GI_Ex);
hold on
plot(xi, P3_stat.P_GI_Ex);
hold on
plot(xi, P4_stat.P_GI_Ex);
hold on
plot(xi, P5_stat.P_GI_Ex);
title('P^{GI}_{Ex}');
ylabel('Prob');
subplot(5,2,5);
plot(xe, P1_stat.P_BE_E);
hold on
plot(xe, P2_stat.P_BE_E);
hold on
plot(xe, P3_stat.P_BE_E);
hold on
plot(xe, P4_stat.P_BE_E);
hold on
plot(xe, P5_stat.P_BE_E);
title('P^{BE}_{E}');
ylabel('Prob');
subplot(5,2,6);
plot(xi, P1_stat.P_BI_E);
hold on
plot(xi, P2_stat.P_BI_E);
hold on
plot(xi, P3_stat.P_BI_E);
hold on
plot(xi, P4_stat.P_BI_E);
hold on
plot(xi, P5_stat.P_BI_E);
title('P^{BI}_{E}');
ylabel('Prob');
subplot(5,2,7);
plot(xe, P1_stat.P_GE_E);
hold on
plot(xe, P2_stat.P_GE_E);
hold on
plot(xe, P3_stat.P_GE_E);
hold on
plot(xe, P4_stat.P_GE_E);
hold on
plot(xe, P5_stat.P_GE_E);
title('P^{GE}_{E}');
ylabel('Prob');
subplot(5,2,8);
plot(xi, P1_stat.P_GI_E);
hold on
plot(xi, P2_stat.P_GI_E);
hold on
plot(xi, P3_stat.P_GI_E);
hold on
plot(xi, P4_stat.P_GI_E);
hold on
plot(xi, P5_stat.P_GI_E);
title('P^{GI}_{E}');
ylabel('Prob');
subplot(5,2,9);
plot(xe, P1_stat.P_GE_I);
hold on
plot(xe, P2_stat.P_GE_I);
hold on
plot(xe, P3_stat.P_GE_I);
hold on
plot(xe, P4_stat.P_GE_I);
hold on
plot(xe, P5_stat.P_GE_I);
title('P^{GE}_{I}');
xlabel('N_{GE}');
ylabel('Prob');
subplot(5,2,10);
plot(xi, P1_stat.P_GI_I);
hold on
plot(xi, P2_stat.P_GI_I);
hold on
plot(xi, P3_stat.P_GI_I);
hold on
plot(xi, P4_stat.P_GI_I);
hold on
plot(xi, P5_stat.P_GI_I);
title('P^{GI}_{I}');
xlabel('N_{GI}');
ylabel('Prob');
newPosition = [1 1 0.2 0.2];
%le = legend('\tau_{ee},\tau_{ie}=(4,1.2)','\tau_{ee},\tau_{ie}=(2,1.2)', '\tau_{ee},\tau_{ie}=(1.3,0.95)', '\tau_{ee},\tau_{ie}=(3,1.2)','\tau_{ee},\tau_{ie}=(1.7,1.1)','location','northeast','orientation','horizontal');
% set(le,'Location','east');
fig = gcf;
set(gcf,'Position',[10,10,1000,800]);


%% Bar plot
res      = P_res3;
rare_res = rare_res3;
param    = param1;
ne = param.ne;
ni = param.ni;
xe = (1:1:(ne+1));
xi = (1:1:(ni+1));
P1_e = zeros(5,ne+1);
P2_e = P1_e;
P3_e = P1_e;
P4_e = P1_e;
P5_e = P1_e;
P1_i = zeros(5,ni+1);
P2_i = P1_i;
P3_i = P1_i;
P4_i = P1_i;
P5_i = P1_i;
for i = 0:4
    bar.e = 30+i*10;
    bar.i = bar.e;
    P1 = P_generation_statistics(res, rare_res, param, bar);
    P1_e(i+1,:) = P1.P_BE_Ex;
    P2_e(i+1,:) = P1.P_GE_Ex;
    P3_e(i+1,:) = P1.P_BE_E;
    P4_e(i+1,:) = P1.P_GE_E;
    P5_e(i+1,:) = P1.P_GE_I;
    
    P1_i(i+1,:) = P1.P_BI_Ex;
    P2_i(i+1,:) = P1.P_GI_Ex;
    P3_i(i+1,:) = P1.P_BI_E;
    P4_i(i+1,:) = P1.P_GI_E;
    P5_i(i+1,:) = P1.P_GI_I;
end

subplot(5,2,1);
plot(xe,P1_e);
title('P^{BE}_{Ex}');
ylabel('Prob');

subplot(5,2,2);
plot(xi,P1_i);
title('P^{BI}_{Ex}');
ylabel('Prob');

subplot(5,2,3);
plot(xe,P2_e);
title('P^{GE}_{Ex}');
ylabel('Prob');


subplot(5,2,4);
plot(xi,P2_i);
title('P^{GI}_{Ex}');
ylabel('Prob');


subplot(5,2,5);
plot(xe,P3_e);
title('P^{BE}_{E}');
ylabel('Prob');


subplot(5,2,6);
plot(xi,P3_i);
title('P^{BI}_{E}');
ylabel('Prob');




subplot(5,2,7);
plot(xe,P4_e);
title('P^{GE}_{E}');
ylabel('Prob');


subplot(5,2,8);
plot(xi,P4_i);
title('P^{GI}_{E}');
ylabel('Prob');


subplot(5,2,9);
plot(xe,P5_e);
title('P^{GE}_{I}');
ylabel('Prob');
xlabel('N_{GE}');
P = zeros(4,ni+1);

subplot(5,2,10);
plot(xi,P5_i);
title('P^{GI}_{I}');
ylabel('Prob');
xlabel('N_{GI}');

hl=legend('bar=30','bar=40','bar=50','bar=60','bar=70','orientation','horizontal');
set(gcf,'Position',[10,10,1000,800]);


