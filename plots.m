%% Full model hom

firing_rate7 = firing_rate(res7, param7);
sd7 = spikedensity(res7, param7);
name7 = 'full-hom-noref';

figure
ax1 = axes('Position', [0.12, 0.1, 0.77, 0.15]);
axes(ax1);
correlation(res7, param7);
annotation('textbox',[0.18,0.305,0.3,0.0],'string','Conditioned on E at t=0','LineStyle','none','fontsize', 12);
annotation('textbox',[0.58,0.305,0.3,0.0],'string','Conditioned on I at t=0','LineStyle','none','fontsize', 12);
ax2 = axes('Position', [0.1, 0.38, 0.9, 0.3]);
axes(ax2);
spectrogram(sd7.e, param7);
ax3 = axes('Position', [0.1, 0.67, 0.77, 0.25]);
axes(ax3);
rasterplot(res7, param7);
annotation('textbox',[0.02,1,0.3,0.0],'string','Hom','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=30.86 I=69.69','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
%saveas(gcf ,['output/',name7,'.png']);
saveas(gcf ,['output/',name7,'.eps'], 'epsc');

%% Full model Reg

firing_rate8 = firing_rate(res8, param8);
sd8 = spikedensity(res8, param8);
name8 = 'full-reg-noref';

figure
ax1 = axes('Position', [0.12, 0.1, 0.77, 0.15]);
axes(ax1);
correlation(res8, param8);
annotation('textbox',[0.18,0.305,0.3,0.0],'string','Conditioned on E at t=0','LineStyle','none','fontsize', 12);
annotation('textbox',[0.58,0.305,0.3,0.0],'string','Conditioned on I at t=0','LineStyle','none','fontsize', 12);
ax2 = axes('Position', [0.1, 0.38, 0.9, 0.3]);
axes(ax2);
spectrogram(sd8.e, param8);
ax3 = axes('Position', [0.1, 0.67, 0.77, 0.25]);
axes(ax3);
rasterplot(res8, param8);
annotation('textbox',[0.02,1,0.3,0.0],'string','Reg','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=34.73 I=74.91','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
%saveas(gcf ,['output/',name8,'.png']);
saveas(gcf ,['output/',name8,'.eps'], 'epsc');

%% Full model Syn

firing_rate9 = firing_rate(res9, param9);
sd9 = spikedensity(res9, param9);
name9 = 'full-syn-noref';

figure
ax1 = axes('Position', [0.12, 0.1, 0.77, 0.15]);
axes(ax1);
correlation(res9, param9);
annotation('textbox',[0.18,0.305,0.3,0.0],'string','Conditioned on E at t=0','LineStyle','none','fontsize', 12);
annotation('textbox',[0.58,0.305,0.3,0.0],'string','Conditioned on I at t=0','LineStyle','none','fontsize', 12);
ax2 = axes('Position', [0.1, 0.38, 0.9, 0.3]);
axes(ax2);
spectrogram(sd9.e, param9);
ax3 = axes('Position', [0.1, 0.67, 0.77, 0.25]);
axes(ax3);
rasterplot(res9, param9);
annotation('textbox',[0.02,1,0.3,0.0],'string','Syn','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=39.87 I=83.24','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
%saveas(gcf ,['output/',name9,'.png']);
saveas(gcf ,['output/',name9,'.eps'],'epsc');

%% Reduced network Hom
firing_rate1 = firing_rate(two_res1, two_param1);
sd1 = spikedensity(two_res1, two_param1);
name1 = 'reduced-hom-noref';

figure
ax1 = axes('Position', [0.12, 0.1, 0.77, 0.15]);
axes(ax1);
correlation(two_res1, two_param1);
annotation('textbox',[0.18,0.305,0.3,0.0],'string','Conditioned on E at t=0','LineStyle','none','fontsize', 12);
annotation('textbox',[0.58,0.305,0.3,0.0],'string','Conditioned on I at t=0','LineStyle','none','fontsize', 12);
ax2 = axes('Position', [0.1, 0.38, 0.9, 0.3]);
axes(ax2);
spectrogram(sd1.e, two_param1);
ax3 = axes('Position', [0.1, 0.67, 0.77, 0.25]);
axes(ax3);
rasterplot(two_res1, two_param1);
annotation('textbox',[0.02,1,0.3,0.0],'string','Hom','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=35.57 I=72.79','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
%saveas(gcf ,['output/',name1,'.png']);
saveas(gcf ,['output/',name1,'.eps'], 'epsc');

%% Reduced network Reg
firing_rate2 = firing_rate(two_res2, two_param2);
sd2 = spikedensity(two_res2, two_param2);
name2 = 'reduced-reg-noref';

figure
ax1 = axes('Position', [0.12, 0.1, 0.77, 0.15]);
axes(ax1);
correlation(two_res2, two_param2);
annotation('textbox',[0.18,0.305,0.3,0.0],'string','Conditioned on E at t=0','LineStyle','none','fontsize', 12);
annotation('textbox',[0.58,0.305,0.3,0.0],'string','Conditioned on I at t=0','LineStyle','none','fontsize', 12);
ax2 = axes('Position', [0.1, 0.38, 0.9, 0.3]);
axes(ax2);
spectrogram(sd2.e, two_param2);
ax3 = axes('Position', [0.1, 0.67, 0.77, 0.25]);
axes(ax3);
rasterplot(two_res2, two_param2);
annotation('textbox',[0.02,1,0.3,0.0],'string','Reg','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=40.56 I=76.35','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
%saveas(gcf ,['output/',name2,'.png']);
saveas(gcf ,['output/',name2,'.eps'], 'epsc');

%% Reduced network Syn

firing_rate3 = firing_rate(two_res3, two_param3);
sd3 = spikedensity(two_res3, two_param3);
name3 = 'reduced-syn-noref';

figure
ax1 = axes('Position', [0.12, 0.1, 0.77, 0.15]);
axes(ax1);
correlation(two_res3, two_param3);
annotation('textbox',[0.18,0.305,0.3,0.0],'string','Conditioned on E at t=0','LineStyle','none','fontsize', 12);
annotation('textbox',[0.58,0.305,0.3,0.0],'string','Conditioned on I at t=0','LineStyle','none','fontsize', 12);
ax2 = axes('Position', [0.1, 0.38, 0.9, 0.3]);
axes(ax2);
spectrogram(sd3.e, two_param3);
ax3 = axes('Position', [0.1, 0.67, 0.77, 0.25]);
axes(ax3);
rasterplot(two_res3, two_param3);
annotation('textbox',[0.02,1,0.3,0.0],'string','Syn','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=45.47 I=82.06','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
% saveas(gcf ,['output/',name3,'.png']);
saveas(gcf ,['output/',name3,'.eps'], 'epsc');

%% Coarse grained Hom
firing_rate4 = firing_rate_coarse(res4, param4);
sd4 = spikedensity_coarse(res4, param4);
name4 = 'coarse-hom-noref';

figure
ax1 = axes('Position', [0.12, 0.1, 0.77, 0.15]);
axes(ax1);
correlation_coarse(res4, param4);
annotation('textbox',[0.18,0.305,0.3,0.0],'string','Conditioned on E at t=0','LineStyle','none','fontsize', 12);
annotation('textbox',[0.58,0.305,0.3,0.0],'string','Conditioned on I at t=0','LineStyle','none','fontsize', 12);
ax2 = axes('Position', [0.1, 0.38, 0.9, 0.3]);
axes(ax2);
spectrogram(sd4.e, param4);
ax3 = axes('Position', [0.1, 0.67, 0.77, 0.25]);
axes(ax3);
coarse_grained_rasterplot(res4, param4);
annotation('textbox',[0.02,1,0.3,0.0],'string','Hom','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=29.38 I=68.28','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
% saveas(gcf ,['output/',name4,'.png']);
saveas(gcf ,['output/',name4,'.eps'],'epsc');

%% Coarse grained Reg
firing_rate5 = firing_rate_coarse(res5, param5);
sd5 = spikedensity_coarse(res5, param5);
name5 = 'coarse-reg-noref';

figure
ax1 = axes('Position', [0.12, 0.1, 0.77, 0.15]);
axes(ax1);
correlation_coarse(res5, param5);
annotation('textbox',[0.18,0.305,0.3,0.0],'string','Conditioned on E at t=0','LineStyle','none','fontsize', 12);
annotation('textbox',[0.58,0.305,0.3,0.0],'string','Conditioned on I at t=0','LineStyle','none','fontsize', 12);
ax2 = axes('Position', [0.1, 0.38, 0.9, 0.3]);
axes(ax2);
spectrogram(sd5.e, param5);
ax3 = axes('Position', [0.1, 0.67, 0.77, 0.25]);
axes(ax3);
coarse_grained_rasterplot(res5, param5);
annotation('textbox',[0.02,1,0.3,0.0],'string','Reg','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=32.47 I=69.13','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
% saveas(gcf ,['output/',name5,'.png']);
saveas(gcf ,['output/',name5,'.eps'], 'epsc');

%% Coarse grained Syn
firing_rate6 = firing_rate_coarse(res6, param6);
sd6 = spikedensity_coarse(res6, param6);
name6 = 'coarse-syn-noref';

figure
ax1 = axes('Position', [0.12, 0.1, 0.77, 0.15]);
axes(ax1);
correlation_coarse(res6, param6);
annotation('textbox',[0.18,0.305,0.3,0.0],'string','Conditioned on E at t=0','LineStyle','none','fontsize', 12);
annotation('textbox',[0.58,0.305,0.3,0.0],'string','Conditioned on I at t=0','LineStyle','none','fontsize', 12);
ax2 = axes('Position', [0.1, 0.38, 0.9, 0.3]);
axes(ax2);
spectrogram(sd6.e, param6);
ax3 = axes('Position', [0.1, 0.67, 0.77, 0.25]);
axes(ax3);
coarse_grained_rasterplot(res6, param6);
annotation('textbox',[0.02,1,0.3,0.0],'string','Syn','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=41.61 I=79.48','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
% saveas(gcf ,['output/',name6,'.png']);
saveas(gcf ,['output/',name6,'.eps'], 'epsc');

%% Fig 1.5
name_fig1 = 'fig1';
sd9 = spikedensity(res9, param9);
figure
ax2 = axes('Position',[0.1,0.35, 0.8,0.6]);
axes(ax2);
line_graph(res9, param9,45);
ax1 = axes('Position', [0.1,0.15,0.7,0.18]);
axes(ax1);
cluster_dissection(sd9.e, param9);
set(gcf,'Position',[10, 10, 800, 600]);
saveas(gcf ,['output/',name_fig1],'epsc');
%saveas(gcf ,['output/',name_fig1,'.png']);

%% fIG 1.5.2
rasterplot(res9, param9);
set(gcf,'Position',[10, 10, 800, 200]);
saveas(gcf ,['output/','raster-syn'],'epsc');
%% Fig 7
name_fig7='fig7';

ax1 = axes('Position',[0.1,0.15, 0.8,0.32]);
axes(ax1);
rasterplot(two_res3, two_param3);
xticks([2000,2200, 2400, 2600, 2800, 3000]);
xlabel('Time(ms)');
ax2 = axes('Position',[0.1,0.61, 0.8,0.32]);
rasterplot(two_res31, two_param3);
axes(ax2);
annotation('textbox',[0.02,1,0.3,0.0],'string','Bar=70','LineStyle','none','fontsize', 14);
annotation('textbox',[0.02,0.55,0.3,0.0],'string','Bar=40','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=89.90 I=153.26','LineStyle','none','fontsize', 12);
annotation('textbox',[0.38,0.55,0.3,0.0],'string','Fr: E=45.47 I=82.06','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
saveas(gcf ,['output/',name_fig7,'.png']);
%saveas(gcf ,['output/',name_fig7,'.eps'],'epsc');


%% Fig 8
name_fig8='fig8';

ax1 = axes('Position',[0.1,0.15, 0.8,0.32]);
axes(ax1);
rasterplot(two_res3, two_param3);
xticks([2000,2200, 2400, 2600, 2800, 3000]);
xlabel('Time(ms)');
ax2 = axes('Position',[0.1,0.61, 0.8,0.32]);
rasterplot(two_res3_ref, two_param3);
axes(ax2);
annotation('textbox',[0.02,1,0.3,0.0],'string','Ref','LineStyle','none','fontsize', 14);
annotation('textbox',[0.02,0.55,0.3,0.0],'string','Non-ref','LineStyle','none','fontsize', 14);
annotation('textbox',[0.38,1,0.3,0.0],'string','Fr: E=64.94 I=104.89','LineStyle','none','fontsize', 12);
annotation('textbox',[0.38,0.55,0.3,0.0],'string','Fr: E=45.47 I=82.06','LineStyle','none','fontsize', 12);
set(gcf,'Position',[10, 10, 800, 400]);
%saveas(gcf ,['output/',name_fig8,'.png']);
saveas(gcf ,['output/',name_fig8,'.eps'], 'epsc');


%% Fig 7-A
load('data/res_full');
res = res9;
num_t = length(res.t);
H_ie = reshape(res.H_ie, 25, num_t);
H_ii = reshape(res.H_ii, 25, num_t);
H_ee = reshape(res.H_ee, 75, num_t);
H_ei = reshape(res.H_ei, 75, num_t);
H_ee = sum(H_ee);
H_ie = sum(H_ie);
H_ei = sum(H_ei);
H_ii = sum(H_ii);
H_i = H_ei + H_ii;
H_e = H_ie + H_ee;
N_GE = reshape(res.V_e, 75, num_t);
N_GI = reshape(res.V_i, 25, num_t);
N_GE = sum(N_GE > 45);
N_GI = sum(N_GI > 45);
H_i = H_i(end-1000:end);
H_e = H_e(end-1000:end);
N_GE = N_GE(end-1000:end);
N_GI = N_GI(end-1000: end);
%3D
subplot(3,3,1);
a=plot3(H_e, H_i, N_GE);
a.Color(4)=0.2;
xlabel('H_e');
ylabel('H_i');
zlabel('N_{GE}');
% 开启网格
grid on;
xlim([0,500]);
ylim([0,1500]);
zlim([0,75]);
% view 调角度
view([-40, 30]);

%N_GE vs N_GI
subplot(3,3,2);
b=plot(N_GI, N_GE);
% 调透明度
b.Color(4)=0.2;
xlabel('N_{GI}');
ylabel('N_{GE}');
ylim([0 75]);
subplot(3,3,3);
c=plot(H_i, N_GE);
% 调透明度
c.Color(4)=0.2;
xlabel('H_I');
ylabel('N_{GE}');
ylim([0 75]);
xlim([0 3000]);
% set(gcf,'Position',[10,10, 1200, 300]);

% Fig 7-B
load('data/res_coarse');
res = res6;

N_GE = res.rec(1, :);
N_GI = res.rec(2, :);
H_e = res.rec(3, :);
H_i = res.rec(4, :);
num_t = length(N_GE);
H_i = H_i(end-1000:end);
H_e = H_e(end-1000:end);
N_GE = N_GE(end-1000:end);
N_GI = N_GI(end-1000: end);

%3D
subplot(3,3,4);
a=plot3(H_e, H_i, N_GE);
a.Color(4)=0.2;
xlabel('H_e');
ylabel('H_i');
zlabel('N_{GE}');
grid on;
xlim([0,500]);
ylim([0, 1500]);
zlim([0,75]);
view([-40, 30]);

%N_GE vs N_GI
subplot(3,3,5);
b=plot(N_GI, N_GE);
% 调透明度
b.Color(4)=0.2;
xlabel('N_{GI}');
ylabel('N_{GE}');
ylim([0 75]);
subplot(3,3,6);

c=plot(H_i, N_GE);
% 调透明度
c.Color(4)=0.2;
xlabel('H_I');
ylabel('N_{GE}');
ylim([0 75]);
% set(gcf,'Position',[10,10, 1200, 300]);


% Fig 7-C
% 3D
X = load('data/X.txt');
Y = load('data/Y.txt');
Z = load('data/Z.txt');
val = load('data/val.txt');

% 3D
subplot(3,3,7);
index = val>10^(-5);
scatter3(Y(index)*24,Z(index)*24,X(index),1,log(val(index)),'MarkerFaceAlpha',.6,'MarkerEdgeAlpha',.6);
% Face,EdgeAlpha 是透明度
view([-40, 30]);
% view 调角度
xlabel('H_e');
ylabel('H_i');
zlabel('N_{GE}');
 xlim([0,500]);
 ylim([0,1500]);
 zlim([0,75]);

% N_GE vs N_GI
subplot(3,3,8);
distribution = load('data/N_GEvN_GI.txt');

imagesc(distribution);
set(gca,'YDir','normal');
xlabel('N_{GI}');
ylabel('N_{GE}');
% N_GE vs H_i
subplot(3,3,9);
distribution = load('data/N_GEvH_I.txt');

distribution_l = zeros(76, 126);
distribution_l(1:76, 1:101) = distribution;
imagesc(distribution_l);
xticks([1, 1000/24, 2000/24, 3000/24]);
xticklabels([0,1000,2000,3000]);
set(gca,'YDir','normal');
xlabel('H_I');
ylabel('N_{GE}');
set(gcf,'Position',[10,10, 1200, 1000]);
saveas(gcf, 'output/fig7-ABC.pdf');