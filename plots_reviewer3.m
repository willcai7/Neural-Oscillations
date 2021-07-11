%% Initialization
path ='./figures/reviewer3/';
addpath(genpath(pwd));

%% Plot 1
% figure 5-B but with the same P
% tau_ees

delta = (4/1.4)^(1/11);
tau_ees = 0:1:11;
tau_ees = 1.4 *(delta.^tau_ees);
res_fulls = {10, 12};
res_rns = {10, 12};
res_cgs = {10, 12};
SSI_fulls = zeros(10, 12);
SSI_cgs = zeros(10, 12);
SSI_rns = zeros(10, 12);

% Full model's SSIs
param.ne       = 75;
param.ni       = 25;
param.p_ee     = 0.15;
param.p_ie     = 0.5;
param.p_ei     = 0.5;
param.p_ii     = 0.4;
param.s_ee     = 20;
param.s_ie     = 8;
param.s_ei     = 20;
param.s_ii     = 20;
param.ns_ee    = 1;
param.ns_ie    = 1;
param.ns_ei    = 1;
param.ns_ii    = 1;
param.tau_ri   = 0;
param.tau_re   = 0;
param.M        = 100;
param.Mr       = 66;
param.lambda_e = 7000;
param.lambda_i = 7000;
param.tau_ee   = 1.4;
param.tau_ie   = 1.2;
param.tau_ei    = 4.5;
param.tau_ii    = 4.5;
param.duration = 3;
param.LeakE = 20;
param.LeakI = 16.7;
param.factor_Leak = inf;
param.delta_time = 0.1;
param.w = 4;

for i =1:12
    for j =1:10
    param.tau_ee = tau_ees(i);
    res_fulls{j,i} = model_L(param);
    SSI_fulls(j,i) = spike_synchrony_index(res_fulls{j,i},param);
    end
end

% P_generation
param.duration = 20;
param.tau_ee = 2.5;
res_P = model_L(param);
bar.e = 50;
bar.i = 50;
P = P_generation_statistics(res_P, param, bar);

param1 = param;
param1.duration = 3;
for i=1:12
    for j=1:10
    param1.tau_ee = tau_ees(i);
    res_rns{j,i} = model_LRNL(param1, P);
    SSI_rns(j,i) = spike_synchrony_index(res_rns{j,i}, param1);
    end
end

ratio1 = zeros(12,2);
ratio2 = zeros(12,2);

for i=1:12
    res = res_rns{1,i};
    HE = res.HE;
    HI = res.HI;
    tHEE = sum(HE(:,1:75),2);
    tHE = sum(HE,2);
    tHEI = sum(HI(:,1:75),2);
    tHI = sum(HI,2);
    rE = tHEE./tHE;
    rI = tHEI./tHI;
    rE = rE(~isnan(rE));
    rI = rI(~isnan(rI));
    ratio1(i,1) = mean(rE);
    ratio1(i,2) = mean(rI);
    ratio2(i,1) = sum(tHEE)/sum(tHE);
    ratio2(i,2) = sum(tHEI)/sum(tHI);
end

param2 = param1;
param2.lambda_e = 1/7;
param2.lambda_i = 1/7;
param2.tau_i = 4.5;
param2.S_e = 24;
param2.S_i = 48;
param2.duration = 3000;
param2.pending_i_maximum = 200000;
param2.pending_e_maximum = 100000;
s = ones(1,4);
for i=1:12
    for j=1:10
    param2.a_ee = ratio2(i,1);
    param2.a_ie = 1- param2.a_ee;
    param2.a_ei = 0.79;
    param2.a_ii = 0.21;
    param2.tau_ee = tau_ees(i);
    res_cgs{j,i} = model_coarse_grained(s, param2, P);
    SSI_cgs(j,i) = spike_synchrony_index_coarse(res_cgs{j,i}, param2);
    end
end

mean_SSI_fulls = mean(SSI_fulls, 1);
mean_SSI_rns = mean(SSI_rns, 1);
mean_SSI_cgs = mean(SSI_cgs, 1);
var_SSI_fulls = var(SSI_fulls, 1);
var_SSI_rns = var(SSI_rns, 1);
var_SSI_cgs = var(SSI_cgs, 1);
std_SSI_fulls = sqrt(var_SSI_fulls);
std_SSI_rns = sqrt(var_SSI_rns);
std_SSI_cgs = sqrt(var_SSI_cgs);
%%
h=figure;
h1 = errorbar(tau_ees, mean_SSI_fulls, std_SSI_fulls/sqrt(10));
hold on;
h2 = errorbar(tau_ees, mean_SSI_rns, std_SSI_rns/sqrt(10));
hold on;
h3 = errorbar(tau_ees, mean_SSI_cgs, std_SSI_cgs/sqrt(10));
xticks([1,2,3,4]);
xlim([1.2,4.1]);
yticks([0.1,0.2, 0.3, 0.4, 0.5, 0.6, 0.7]);
ylim([0.09,0.71]);
xlabel('\tau^{EE}');
ylabel('spike synchrony index');
legend('full model', 'reduced network model', 'coarse grained model');
set(gca,'fontsize',15,'fontname','Arial');
set(gcf,'Position',[10,10,800,600]);
set(h, 'Papersize',[8.5,6.5]);
print(h,[path,'fig1.pdf'], '-dpdf');
%% Plot 2
param.ne       = 75;
param.ni       = 25;
param.p_ee     = 0.15;
param.p_ie     = 0.5;
param.p_ei     = 0.5;
param.p_ii     = 0.4;
param.s_ee     = 20;
param.s_ie     = 8;
param.s_ei     = 20;
param.s_ii     = 20;
param.ns_ee    = 1;
param.ns_ie    = 1;
param.ns_ei    = 1;
param.ns_ii    = 1;
param.tau_ri   = 0;
param.tau_re   = 0;
param.M        = 100;
param.Mr       = 66;
param.lambda_e = 7000;
param.lambda_i = 7000;
param.tau_ee   = 1.4;
param.tau_ie   = 1.2;
param.tau_ei    = 4.5;
param.tau_ii    = 4.5;
param.duration = 3;
param.LeakE = 20;
param.LeakI = 16.7;
param.factor_Leak = inf;
param.delta_time = 0.1;
param.w = 4;
param4 = param;
param4.duration = 10;
param4.tau_ee = 2.5;

bar.e = 45;
bar.i = 45;
P2 = {1,10};
NGE = zeros(1,76);
NGI = zeros(1,26);
for i=1:10
    res_P = model_L(param4);
    NGE_t = sum(res_P.VE>bar.e, 2);
    NGI_t = sum(res_P.VI>bar.i, 2);
    edges_e = 0:1:76;
    edges_i = 0:1:26;
    NGE = NGE + histcounts(NGE_t, edges_e);
    NGI = NGI + histcounts(NGI_t, edges_i);
    P2{i} = P_generation_statistics(res_P, param4, bar);
end

NGE = NGE/sum(NGE);
NGI = NGI/sum(NGI);

names = fieldnames(P2{1});
data = {1,10};
for i = 1:10
    a = P2{1}.(names{i});
    data_temp = zeros(10, size(a,2));
    for j = 1:10
        data_temp(j,:) = P2{j}.(names{i});
    end
    data{i} = data_temp;
end
%%
h=figure;
names1 = {'P_{BE}^{Ex}', 'P_{GE}^{Ex}', 'P_{BE}^E', 'P_{GE}^E', 'P_{GE}^I',...
    'P_{BI}^{Ex}','P_{GI}^{Ex}', 'P_{BI}^E', 'P_{GI}^E', 'P_{GI}^I'};
for i = 1:10
    data_temp = data{i};
    if i <= 5
        j = 2*i-1;
    else
        j = 2*i-10;
    end
    subplot(5,2,j);
    mean1 = mean(data_temp, 1);
    var1 = var(data_temp, 1);
    std1 = sqrt(var1);
    yyaxis right
    if i<=5
    sss=area(0:1:size(mean1,2)-1,NGE,'edgecolor','none');
    else
    sss=area(0:1:size(mean1,2)-1,NGI,'edgecolor','none');
    end
    sss.FaceAlpha = 0.2;
    yyaxis left
    x = 0:1:size(mean1,2)-1;
    y = mean1;
    CI = zeros(size(mean1,2),2);
    CI(:,1) = y - std1/sqrt(10);
    CI(:,2) = y + std1/sqrt(10);
    x_plot = [x,fliplr(x)];
    y_plot = [CI(:,1)', flipud(CI(:,2))'];
    hold on;
    plot(x,y);
    fill(x_plot, y_plot,1,'facecolor','blue','edgecolor','none','facealpha',0.4);
    hold off;
    xlabel(names1{i});
    if i<=5
        xlim([0,75]);
    else
        xlim([0,25]);
    end
    ylim([min(mean1-2*std1/sqrt(10)), max(mean1 + 2*std1/sqrt(10))]);
    set(gca,'fontsize',12,'fontname','Arial');
end
sgtitle('Transition Probabilities');
set(gcf,'Position',[10,10,1200,1200]);
set(h, 'Papersize',[12.5,12.5]);
print(h,[path,'fig2.pdf'], '-dpdf');
%% Plot 3
bar_values = [35, 40 ,45 ,50, 55];
P3 = {10,5};
res3 = {1,5};
param1 = param;
param1.duration = 20;
param1.tau_ee = 1.4;
res_P = model_L(param1);
NGE = zeros(5,76);
param1.duration = 3;
for i=1:5
    bar.e = bar_values(i);
    bar.i = bar_values(i);
    P3{1,i} = P_generation_statistics(res_P, param1, bar);
    res3{i} = model_LRNL(param1, P3{i});
    NGE_t = sum(res3{i}.VE>bar.e, 2);
    edges_e = 0:1:76;
    NGE(i,:) = NGE(i,:) + histcounts(NGE_t, edges_e);
end
param1.duration =20;
for j=2:10
    res_P = model_L(param1);
for i=1:5
    bar.e = bar_values(i);
    bar.i = bar_values(i);
    P3{j,i} = P_generation_statistics(res_P, param1, bar);
    NGE_t = sum(res_P.VE>bar.e, 2);
    edges_e = 0:1:76;
    NGE(i,:) = NGE(i,:) + histcounts(NGE_t, edges_e);
end
end

%%
h=figure;
for i=1:5
    subplot(5,2, 2*i-1);
    rasterplot(res3{i}, param1);
    param1.duration = 3;
    fr = firing_rate(res3{i},param1);
    box on;
    title(['Bar=',num2str(bar_values(i)),'        Fr: E=',num2str(fr.e,4), ' I=',num2str(fr.i,4)]);
    set(gca,'fontsize',12,'fontname','Arial');
    subplot(5,2, 2*i);
    P_temp = zeros(10,76);
    for j=1:10
        P_temp(j,:) = P3{j,i}.P_BE_E;
    end
    mean1 = mean(P_temp,1);
    se = sqrt(var(P_temp,1))/sqrt(10);
    x = 0:1:size(P_temp,2)-1;
    y = mean1;
    CI = zeros(76,2);
    CI(:,1) = y-se;
    CI(:,2) = y+se;
    x_plot = [x,fliplr(x)];
    y_plot = [CI(:,1)', flipud(CI(:,2))'];
    yyaxis left;
    hold on;
    plot(x,y);
    fill(x_plot, y_plot,1,'facecolor','blue','edgecolor','none','facealpha',0.4);
    hold off;
    yyaxis right;
    NGE(i,:) = NGE(i,:)/sum(NGE(i,:));
    sss=area(0:1:75,NGE(i,:),'edgecolor','none');
    sss.FaceAlpha = 0.2;
    xlim([0,75]);
    set(gca,'fontsize',12,'fontname','Arial');
end
subplot(5,2,9);
xlabel('ms');
subplot(5,2,10);
xlabel('P_{BE}^E');
set(gcf,'Position',[10,10,1200,1000]);
set(h, 'Papersize',[12.5,10.5]);
print(h,[path,'fig3.pdf'], '-dpdf');
%% Plot 4
delta = (4/1.4)^(1/11);
tau_ees = 0:1:11;
tau_ees = 1.4 *(delta.^tau_ees);
res_fulls = {10, 12};
res_rns = {10, 12};
res_cgs = {10, 12};
P4 = {1, 12};
fre_fulls = zeros(10, 12);
fre_cgs = zeros(10, 12);
fre_rns = zeros(10, 12);
fri_fulls = zeros(10, 12);
fri_cgs = zeros(10, 12);
fri_rns = zeros(10, 12);

param.ne       = 75;
param.ni       = 25;
param.p_ee     = 0.15;
param.p_ie     = 0.5;
param.p_ei     = 0.5;
param.p_ii     = 0.4;
param.s_ee     = 20;
param.s_ie     = 8;
param.s_ei     = 20;
param.s_ii     = 20;
param.ns_ee    = 1;
param.ns_ie    = 1;
param.ns_ei    = 1;
param.ns_ii    = 1;
param.tau_ri   = 0;
param.tau_re   = 0;
param.M        = 100;
param.Mr       = 66;
param.lambda_e = 7000;
param.lambda_i = 7000;
param.tau_ee   = 1.4;
param.tau_ie   = 1.2;
param.tau_ei    = 4.5;
param.tau_ii    = 4.5;
param.duration = 10;
param.LeakE = 20;
param.LeakI = 16.7;
param.factor_Leak = inf;
param.delta_time = 0.1;
param.w = 4;

for i =1:12
    for j =1:10
    param.tau_ee = tau_ees(i);
    res_fulls{j,i} = model_L(param);
    fr= firing_rate(res_fulls{j,i},param);
    fre_fulls(j,i) = fr.e;
    fri_fulls(j,i) = fr.i;
    end
end
%%
param1 = param;
param1.duration = 3;
bar.e = 45;
bar.i = 45;
for i=1:12
    P4{i} = P_generation_statistics(res_fulls{1,i}, param, bar);
    for j=1:10
    param1.tau_ee = tau_ees(i);
    res_rns{j,i} = model_LRNL(param1, P4{i});
    fr= firing_rate(res_rns{j,i}, param1);
    fre_rns(j,i) = fr.e;
    fri_rns(j,i) = fr.i;
    end
end


for i=1:12
    res = res_rns{1,i};
    HE = res.HE;
    HI = res.HI;
    tHEE = sum(HE(:,1:75),2);
    tHE = sum(HE,2);
    tHEI = sum(HI(:,1:75),2);
    tHI = sum(HI,2);
    rE = tHEE./tHE;
    rI = tHEI./tHI;
    rE = rE(~isnan(rE));
    rI = rI(~isnan(rI));
    ratio1(i,1) = mean(rE);
    ratio1(i,2) = mean(rI);
    ratio2(i,1) = sum(tHEE)/sum(tHE);
    ratio2(i,2) = sum(tHEI)/sum(tHI);
end
%%
param2 = param1;
param2.lambda_e = 1/7;
param2.lambda_i = 1/7;
param2.tau_i = 4.5;
param2.S_e = 24;
param2.S_i = 48;
param2.duration = 3000;
param2.pending_i_maximum = 200000;
param2.pending_e_maximum = 100000;
s = ones(1,4);
for i=1:12
    for j=1:10
    disp([num2str(i),' ', num2str(j)]);
    param2.a_ee = ratio2(i,1)-0.02;
    param2.a_ie = 1- param2.a_ee;
    param2.a_ei = 0.79;
    param2.a_ii = 0.21;
    param2.tau_ee = tau_ees(i);
    res_cgs{j,i} = model_coarse_grained(s, param2, P4{i});
    fr = firing_rate_coarse(res_cgs{j,i}, param2);
    fre_cgs(j,i) = fr.e;
    fri_cgs(j,i) = fr.i;
    end
end

mean_fre_fulls = mean(fre_fulls, 1);
mean_fre_rns = mean(fre_rns, 1);
mean_fre_cgs = mean(fre_cgs, 1);
var_fre_fulls = var(fre_fulls, 1);
var_fre_rns = var(fre_rns, 1);
var_fre_cgs = var(fre_cgs, 1);
std_fre_fulls = sqrt(var_fre_fulls);
std_fre_rns = sqrt(var_fre_rns);
std_fre_cgs = sqrt(var_fre_cgs);

mean_fri_fulls = mean(fri_fulls, 1);
mean_fri_rns = mean(fri_rns, 1);
mean_fri_cgs = mean(fri_cgs, 1);
var_fri_fulls = var(fri_fulls, 1);
var_fri_rns = var(fri_rns, 1);
var_fri_cgs = var(fri_cgs, 1);
std_fri_fulls = sqrt(var_fri_fulls);
std_fri_rns = sqrt(var_fri_rns);
std_fri_cgs = sqrt(var_fri_cgs);

z1 = reshape(fri(1,:,:),10,13);
z2 = reshape(fri(2,:,:), 10,13);
z3 = reshape(fri(3,:,:),10,13);
mean_fri_fulls1 = mean(z1, 1);
mean_fri_rns1 = mean(z2, 1);
mean_fri_cgs1 = mean(z3, 1);
var_fri_fulls1 = var(z1, 1);
var_fri_rns1 = var(z2, 1);
var_fri_cgs1 = var(z3, 1);
std_fri_fulls1 = sqrt(var_fri_fulls1);
std_fri_rns1 = sqrt(var_fri_rns1);
std_fri_cgs1 = sqrt(var_fri_cgs1);

z1 = reshape(fre(1,:,:),10,13);
z2 = reshape(fre(2,:,:), 10,13);
z3 = reshape(fre(3,:,:),10,13);
mean_fre_fulls1 = mean(z1, 1);
mean_fre_rns1 = mean(z2, 1);
mean_fre_cgs1 = mean(z3, 1);
var_fre_fulls1 = var(z1, 1);
var_fre_rns1 = var(z2, 1);
var_fre_cgs1 = var(z3, 1);
std_fre_fulls1 = sqrt(var_fre_fulls1);
std_fre_rns1 = sqrt(var_fre_rns1);
std_fre_cgs1 = sqrt(var_fre_cgs1);
%%
h=figure;
subplot(2,2,1);
h1 = errorbar(tau_ees, mean_fre_fulls, std_fre_fulls/sqrt(10));
hold on;
h2 = errorbar(tau_ees, mean_fre_rns, std_fre_rns/sqrt(10));
hold on;
h3 = errorbar(tau_ees, mean_fre_cgs, std_fre_cgs/sqrt(10));
xticks([1,2,3,4]);
xlim([1.2,4.1]);
% yticks([0.1,0.2, 0.3, 0.4, 0.5, 0.6, 0.7]);
% ylim([0.09,0.71]);
xlabel('\tau^{EE}');
ylabel('E-firing rate');
set(gca,'fontsize',15,'fontname','Arial');

subplot(2,2,2);
h4 = errorbar(tau_ees, mean_fri_fulls, std_fri_fulls/sqrt(10));
hold on;
h5 = errorbar(tau_ees, mean_fri_rns, std_fri_rns/sqrt(10));
hold on;
h6 = errorbar(tau_ees, mean_fri_cgs, std_fri_cgs/sqrt(10));
xticks([1,2,3,4]);
xlim([1.2,4.1]);
% yticks([0.1,0.2, 0.3, 0.4, 0.5, 0.6, 0.7]);
% ylim([0.09,0.71]);
xlabel('\tau^{EE}');
ylabel('I-firing rate');
legend('full model', 'reduced network model', 'coarse grained model');
set(gca,'fontsize',15,'fontname','Arial');

subplot(2,2,3);
h1 = errorbar(lambdas, mean_fre_fulls1, std_fre_fulls1/sqrt(10));
hold on;
h2 = errorbar(lambdas, mean_fre_rns1, std_fre_rns1/sqrt(10));
hold on;
h3 = errorbar(lambdas, mean_fre_cgs1, std_fre_cgs1/sqrt(10));
% xticks([1,2,3,4]);
% xlim([1.2,4.1]);
% yticks([0.1,0.2, 0.3, 0.4, 0.5, 0.6, 0.7]);
% ylim([0.09,0.71]);
xlabel('1/\lambda (ms/spike)');
ylabel('E-firing rate');
set(gca,'fontsize',15,'fontname','Arial');

subplot(2,2,4);
h4 = errorbar(lambdas, mean_fri_fulls1, std_fri_fulls1/sqrt(10));
hold on;
h5 = errorbar(lambdas, mean_fri_rns1, std_fri_rns1/sqrt(10));
hold on;
h6 = errorbar(lambdas, mean_fri_cgs1, std_fri_cgs1/sqrt(10));
% xticks([1,2,3,4]);
% xlim([1.2,4.1]);
% yticks([0.1,0.2, 0.3, 0.4, 0.5, 0.6, 0.7]);
% ylim([0.09,0.71]);
xlabel('1/\lambda (ms/spike)');
ylabel('I-firing rate');
legend('full model', 'reduced network model', 'coarse grained model');
set(gca,'fontsize',15,'fontname','Arial');

set(gcf,'Position',[10,10,1200,1200]);
set(h, 'Papersize',[12.5,12.5]);
print(h,[path,'fig4.pdf'], '-dpdf');
%% Plot 5
% CG vs Full, trajectory
% 0-0.5, 0.5-1, 1-3
param.ne       = 75;
param.ni       = 25;
param.p_ee     = 0.15;
param.p_ie     = 0.5;
param.p_ei     = 0.5;
param.p_ii     = 0.4;
param.s_ee     = 20;
param.s_ie     = 8;
param.s_ei     = 20;
param.s_ii     = 20;
param.ns_ee    = 1;
param.ns_ie    = 1;
param.ns_ei    = 1;
param.ns_ii    = 1;
param.tau_ri   = 0;
param.tau_re   = 0;
param.M        = 100;
param.Mr       = 66;
param.lambda_e = 7000;
param.lambda_i = 7000;
param.tau_ee   = 1.4;
param.tau_ie   = 1.2;
param.tau_ei    = 4.5;
param.tau_ii    = 4.5;
param.duration = 3;
param.LeakE = 20;
param.LeakI = 16.7;
param.factor_Leak = inf;
param.delta_time = 0.1;
param.w = 4;

res_full5 = model_L(param);

param2 = param;
param2.lambda_e = 1/7;
param2.lambda_i = 1/7;
param2.tau_i = 4.5;
param2.S_e = 24;
param2.S_i = 48;
param2.duration = 3000;
param2.pending_i_maximum = 2000000;
param2.pending_e_maximum = 2000000;
s = ones(1,4);
param2.a_ee = 0.5;
param2.a_ie = 0.5;
param2.a_ei = 0.79;
param2.a_ii = 0.21;
res_cg5 = model_coarse_grained(s, param2, P4{1});
%%
HE_full = sum(res_full5.HE,2);
HI_full = sum(res_full5.HI,2);
NGE_full = sum(res_full5.VE>50,2);
t_full = res_full5.time;
HE_cg = res_cg5.rec(3,:);
HI_cg = res_cg5.rec(4,:);
NGE_cg =res_cg5.rec(1,:);
t_cg =res_cg5.rec(5,:)/1000;
h=figure;
subplot(2,3,1);
index = t_full<0.5;
a1=plot3(HE_full(index), HI_full(index), NGE_full(index));
xlim([0,500]);
ylim([0,1500]);
zlim([0,75]);
xlabel('H^E');
ylabel('H^I');
zlabel('N_{GE}');
a1.Color(4) = 0.2;
grid on;
set(gca,'fontsize',12,'fontname','Arial');
subplot(2,3,2);
index = t_full>=0.5 & t_full<1;
a2=plot3(HE_full(index), HI_full(index), NGE_full(index));
xlim([0,500]);
ylim([0,1500]);
zlim([0,75]);
xlabel('H^E');
ylabel('H^I');
zlabel('N_{GE}');
a2.Color(4) = 0.2;
grid on;
set(gca,'fontsize',12,'fontname','Arial');
subplot(2,3,3);
index = t_full>=1 & t_full<3;
a3=plot3(HE_full(index), HI_full(index), NGE_full(index));
xlim([0,500]);
ylim([0,1500]);
zlim([0,75]);
xlabel('H^E');
ylabel('H^I');
zlabel('N_{GE}');
a3.Color(4) = 0.2;
grid on;
set(gca,'fontsize',12,'fontname','Arial');
subplot(2,3,4);
index = t_cg<0.5;
a4=plot3(HE_cg(index), HI_cg(index), NGE_cg(index));
a4.Color(4) = 0.2;
xlim([0,500]);
ylim([0,1500]);
zlim([0,75]);
xlabel('H^E');
ylabel('H^I');
zlabel('N_{GE}');
grid on;
set(gca,'fontsize',12,'fontname','Arial');
subplot(2,3,5);
index = t_cg>=0.5 &t_cg<1;
a5=plot3(HE_cg(index), HI_cg(index), NGE_cg(index));
a5.Color(4) = 0.2;
xlim([0,500]);
ylim([0,1500]);
zlim([0,75]);
xlabel('H^E');
ylabel('H^I');
zlabel('N_{GE}');
grid on;
set(gca,'fontsize',12,'fontname','Arial');
subplot(2,3,6);
index = t_cg>=1 &t_cg<3;
a6=plot3(HE_cg(index), HI_cg(index), NGE_cg(index));
a6.Color(4) = 0.2;
xlim([0,500]);
ylim([0,1500]);
zlim([0,75]);
xlabel('H^E');
ylabel('H^I');
zlabel('N_{GE}');
grid on;
set(gca,'fontsize',12,'fontname','Arial');
set(gcf,'Position',[10,10,1200,600]);
set(h, 'Papersize',[12.5,6.5]);
print(h,[path,'fig5.pdf'], '-dpdf');
%% Plot 6
% Convergence of Entropy
param.ne       = 75;
param.ni       = 25;
param.p_ee     = 0.15;
param.p_ie     = 0.5;
param.p_ei     = 0.5;
param.p_ii     = 0.4;
param.s_ee     = 20;
param.s_ie     = 8;
param.s_ei     = 20;
param.s_ii     = 20;
param.ns_ee    = 1;
param.ns_ie    = 1;
param.ns_ei    = 1;
param.ns_ii    = 1;
param.tau_ri   = 0;
param.tau_re   = 0;
param.M        = 100;
param.Mr       = 66;
param.lambda_e = 7000;
param.lambda_i = 7000;
param.tau_ee   = 1.4;
param.tau_ie   = 1.2;
param.tau_ei    = 4.5;
param.tau_ii    = 4.5;
param.duration = 20;
param.LeakE = 10;
param.LeakI = 16.7;
param.factor_Leak = inf;
param.delta_time = 0.1;
param.w = 4;

bar1 = 45;
res_full = model_L(param);
size_tr = size(res_full.time,1);
tr = zeros(4,size_tr);
VE = res_full.VE;
VI = res_full.VI;
HE = res_full.HE;
HI = res_full.HI;
tr(1,:) = sum(VE>bar1, 2);
tr(2,:) = sum(VI>bar1, 2);
tr(3,:) = sum(HE, 2);
tr(4,:) = sum(HI, 2);
%%

num_bins = 30;
val = entropy_dis(tr,[25,25,25,25]);
val1 = reshape(val,25*25*25*25,1);
x = 0:10^(-6):4.5*10^(-3);
delta = 4.5*10^(-3)/10^(-6);
delta = delta^(1/num_bins);
edges = 1:1:30;
edges = 10^(-6)*delta.^edges;
edges1 = zeros(1,31);
edges1(2:31) = edges;
sss = edges1(2)-(edges1(3)-edges1(2))/delta;
edges1(1) = sss;
y = -x.*log(x);
val1(val1==0) = val1(val1==0) + sss;
x(1) = sss;

h=figure;
yyaxis left;
plot(x,y);
ylim([min(y), max(y)]);
xlabel('P');
ylabel('-Plog(P)');
yyaxis right;
a=histogram(val1,edges1,'facealpha',0.5,'EdgeColor','none','Normalization','probability');
ylabel('Percentage');
xlim([0,4.5*10^(-3)]);
set(gca,'YScale','log');
set(gca,'XScale','log');
xticks([10^(-6), 10^(-5), 10^(-4), 10^(-3)]);
xticklabels( {'0', '10^{-5}', '10^{-4}', '10^{-3}'});
set(gcf,'Position',[10,10,800,600]);
set(gca,'fontsize',12,'fontname','Arial');
set(h, 'Papersize',[8.5,6.5]);
print(h,[path,'fig6.pdf'], '-dpdf');

%% Plot 7
% Firing rate versus lambda
lambdas = 1:1:13;
lambdas = lambdas* 0.02;
lambdas = lambdas + 0.15-lambdas(7);

lambdas_full = 1./lambdas * 1000;
param.ne       = 75;
param.ni       = 25;
param.p_ee     = 0.15;
param.p_ie     = 0.5;
param.p_ei     = 0.5;
param.p_ii     = 0.4;
param.s_ee     = 20;
param.s_ie     = 8;
param.s_ei     = 20;
param.s_ii     = 20;
param.ns_ee    = 1;
param.ns_ie    = 1;
param.ns_ei    = 1;
param.ns_ii    = 1;
param.tau_ri   = 0;
param.tau_re   = 0;
param.M        = 100;
param.Mr       = 66;
param.lambda_e = 7000;
param.lambda_i = 7000;
param.tau_ee   = 1.4;
param.tau_ie   = 1.2;
param.tau_ei    = 4.5;
param.tau_ii    = 4.5;
param.duration = 3;
param.LeakE = 20;
param.LeakI = 16.7;
param.factor_Leak = inf;
param.delta_time = 0.1;
param.w = 4;

param.duration = 20;
res_fulls7 = {1,13};
res_fulls = {10,13};
res_cgs = {10,13};
res_rns = {10,13};
for i =1:13
    disp(num2str(i));
    param.lambda_e = lambdas_full(i);
    param.lambda_i = lambdas_full(i);
    res_fulls7{1,i} = model_L(param);
end
%%
P = {1,13};
bar.e = 45;
bar.i = 45;
param1 = param;
param1.duration = 3;
fre = zeros(3,10,13);
fri = zeros(3,10,13);
param.duration = 3;
ratio2  =zeros(13,2);
for i =1:13
%     P{i} = P_generation_statistics(res_fulls7{1,i}, param, bar);
    param1.lambda_e = lambdas_full(i);
    param1.lambda_i = lambdas_full(i);
    param.lambda_e = lambdas_full(i);
    param.lambda_i = lambdas_full(i);
    for j =1:10
    disp([num2str(i),' ', num2str(j)]);
    %res_fulls{j,i} = model_L(param);
%     res_rns{j,i} = model_LRNL(param1,P{i});
    fr1 = firing_rate(res_fulls{j,i},param);
    fre(1,j,i) = fr1.e;
    fri(1,j,i) = fr1.i;
%     fr2 = firing_rate(res_rns{j,i}, param1);
%     fre(2,j,i) = fr2.e;
%     fri(2,j,i) = fr2.i;
    end
end

for i=1:13
    res = res_rns{1,i};
    HE = res.HE;
    HI = res.HI;
    tHEE = sum(HE(:,1:75),2);
    tHE = sum(HE,2);
    tHEI = sum(HI(:,1:75),2);
    tHI = sum(HI,2);
    ratio2(i,1) = sum(tHEE)/sum(tHE);
    ratio2(i,2) = sum(tHEI)/sum(tHI);
end
%%
param2 = param1;
param2.lambda_e = 1/7;
param2.lambda_i = 1/7;
param2.tau_i = 4.5;
param2.S_e = 24;
param2.S_i = 48;
param2.duration = 3000;
param2.pending_i_maximum = 200000;
param2.pending_e_maximum = 100000;
s = ones(1,4);
for i=1:13
    param2.lambda_e = lambdas(i);
    param2.lambda_i = lambdas(i);
    for j=1:10
            disp([num2str(i),' ', num2str(j)]);
    param2.a_ee = ratio2(i,1)-0.02;
    param2.a_ie = 1- param2.a_ee;
    param2.a_ei = 0.79;
    param2.a_ii = 0.21;
    res_cgs{j,i} = model_coarse_grained(s, param2, P{i});
    fr3 = firing_rate_coarse(res_cgs{j,i}, param2);
    fre(3,j,i) =fr3.e;
    fri(3,j,i) =fr3.i;
    end
end
z1 = reshape(fri(1,:,:),10,13);
z2 = reshape(fri(2,:,:), 10,13);
z3 = reshape(fri(3,:,:),10,13);
mean_fri_fulls = mean(z1, 1);
mean_fri_rns = mean(z2, 1);
mean_fri_cgs = mean(z3, 1);
var_fri_fulls = var(z1, 1);
var_fri_rns = var(z2, 1);
var_fri_cgs = var(z3, 1);
std_fri_fulls = sqrt(var_fri_fulls);
std_fri_rns = sqrt(var_fri_rns);
std_fri_cgs = sqrt(var_fri_cgs);

z1 = reshape(fre(1,:,:),10,13);
z2 = reshape(fre(2,:,:), 10,13);
z3 = reshape(fre(3,:,:),10,13);
mean_fre_fulls = mean(z1, 1);
mean_fre_rns = mean(z2, 1);
mean_fre_cgs = mean(z3, 1);
var_fre_fulls = var(z1, 1);
var_fre_rns = var(z2, 1);
var_fre_cgs = var(z3, 1);
std_fre_fulls = sqrt(var_fre_fulls);
std_fre_rns = sqrt(var_fre_rns);
std_fre_cgs = sqrt(var_fre_cgs);
%%
h=figure;
subplot(1,2,1);
h1 = errorbar(lambdas, mean_fre_fulls, std_fre_fulls/sqrt(10));
hold on;
h2 = errorbar(lambdas, mean_fre_rns, std_fre_rns/sqrt(10));
hold on;
h3 = errorbar(lambdas, mean_fre_cgs, std_fre_cgs/sqrt(10));
% xticks([1,2,3,4]);
% xlim([1.2,4.1]);
% yticks([0.1,0.2, 0.3, 0.4, 0.5, 0.6, 0.7]);
% ylim([0.09,0.71]);
xlabel('1/\lambda (ms/spike)');
ylabel('E-firing rate');
set(gca,'fontsize',15,'fontname','Arial');

subplot(1,2,2);
h4 = errorbar(lambdas, mean_fri_fulls, std_fri_fulls/sqrt(10));
hold on;
h5 = errorbar(lambdas, mean_fri_rns, std_fri_rns/sqrt(10));
hold on;
h6 = errorbar(lambdas, mean_fri_cgs, std_fri_cgs/sqrt(10));
% xticks([1,2,3,4]);
% xlim([1.2,4.1]);
% yticks([0.1,0.2, 0.3, 0.4, 0.5, 0.6, 0.7]);
% ylim([0.09,0.71]);
xlabel('1/\lambda (ms/spike)');
ylabel('I-firing rate');
legend('full model', 'reduced network model', 'coarse grained model');
set(gca,'fontsize',15,'fontname','Arial');

set(gcf,'Position',[10,10,1200,600]);
set(h, 'Papersize',[12.5,6.5]);
print(h,[path,'fig7.pdf'], '-dpdf');