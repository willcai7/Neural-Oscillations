function [] = line_graph(res,time_delta,ne, ni, name)
num = length(res.H_ee);
time = linspace(1,num*3, num);
subplot(3,1,1);
plot(time, res.H_ee,'r');
hold on
plot(time, res.H_ie,'b');
xlim([0,num*time_delta+100]);
legend('H_{ee}','H_{ie}');
title(name);
hold on
subplot(3,1,2);
plot(time, res.H_ei,'r');
hold on
plot(time, res.H_ii, 'b');
xlim([0,num*time_delta+100]);
legend('H_{ei}','H_{ii}');
hold on
subplot(3,1,3);
plot(time, res.N_GE/ ne,'r');
hold on
plot(time, res.N_GI/ ni,'b');
xlim([0,num*time_delta+100]);
legend('N_{GE}/N_{E}','N_{GI}/N_I');
xlabel('t/ms');
set(gcf,'Position',[10,10,1000,600]);
saveas(gcf,['output\graphline-',name,'.png']);
end


%% Coarse grained fixed probabiliy model:

c=0.6;
param7.ne=75;
param7.ni=25;

param7.p1=0.0067*c;%p_ex^be
param7.p2=0.0104*c;%p_ex^bi
param7.p3=0.02*c;%p_ex^ge
param7.p4=0.0247*c;%p_ex^gi
param7.p5=0.29*c;%p_e^be
param7.p6=0.07*c;%p_e^bi
param7.p7=1;%p_e^ge
param7.p8=1;%p_e^gi
param7.p9=1;%p_i^ge
param7.p10=1;%p_i^gi

param7.lambda_e = 1/7;
param7.lambda_i = 1/7; 
param7.tau_ee   = 1.3; 
param7.tau_ie   = 0.95; 
param7.tau_i    = 4.5;
param7.S_e = 24;
param7.S_i = 48;
param7.a_ee=0.66;
param7.a_ie=0.34;
param7.a_ei=0.79;
param7.a_ii=0.21;
param7.pending_i_maximum=20000;
param7.pending_e_maximum=10000;
duration_time   = 1000;

%random initialization
s=ones(1,4);
res7=coarse_grained(s,duration_time,param);

line_graph(res7,time_delta,ne, ni, name)

