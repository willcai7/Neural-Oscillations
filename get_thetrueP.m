%% Setting paths
addpath(genpath(pwd));
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
param7.method   = 'extend';
save=false;
%%
% random inilialization
s = zeros(4,param7.ne+param7.ni);
s(2:3,:) = double(rand(2,param7.ne+param7.ni)>0.8);
s(1,:) = unidrnd(param7.M+param7.Mr+1,[1,param7.ne+param7.ni])- param7.Mr-1;

t=clock;
res7 = model_full(s, duration_time, param7);
runtime7 = etime(clock,t);



scatterplot(res7, param7, name7,save);
% firing_rate7 = firing_rate(res7, param7);
% correlation(res7, param7, name7,save)
% hist_h(res7, param7, name7,save)
% hist_v(res7, param7, name7,savee)
% hist_t(res7, param7, name7,save)
% firing_rate7

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
duration_time   = 60000;
name8 = 'n=100-t=1000-reg-noref';
save=false;
param8.type    ='reg';
param8.fix     = false;
param8.method = 'extend';
%%
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
scatterplot(res8, param8,name8,save);
% correlation(res8, param8, name8, save);
% hist_h(res8, param8, name8, save);
% hist_v(res8, param8, name8, save);
% hist_t(res8, param8, name8, save);
%firing_rate8
%% Full model: syn, small-size, noref
addpath(genpath(pwd));
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
param9.gate     = 70;
duration_time   = 5000;
param9.time_delta = 1;
param9.fix = false;
name9 = 'n=100-t=1000-syn-noref';
save=false;
param9.type     = 'syn';
param9.method   = 'extend';
%%
%random inilialization
s = zeros(4,param9.ne+param9.ni);
s(2:3,:) = double(rand(2,param9.ne+param9.ni)>0.8);
s(1,:) = unidrnd(param9.M+param9.Mr+1,[1,param9.ne+param9.ni])- param9.Mr-1;



t = clock;
res9 = model_full(s, duration_time, param9);
runtime9 = etime(clock,t);
%% Rare events simulation
param9.simulation_times=150;
rare_res9=rare_model_full(res9,param9);



%% Calculate the P

res = res9;
V_e = res.V_e;
V_i = res.V_i;
N_GI = res.N_GI;
N_GE = res.N_GE;

V_e = [V_e,rare_res9.V_e];
V_i = [V_i,rare_res9.V_i];
N_GI = [N_GI,rare_res9.N_GI];
N_GE = [N_GE,rare_res9.N_GE];





P1.P_BE_Ex = zeros(1, 76);
P1.P_GE_Ex = zeros(1, 76);
P1.P_BE_E  = zeros(1, 76);
P1.P_GE_E  = ones(1, 76);
P1.P_GE_I  = ones(1, 76);
P1.P_BI_Ex = zeros(1, 26);
P1.P_GI_Ex = zeros(1, 26);
P1.P_BI_E  = zeros(1, 26);
P1.P_GI_E  = zeros(1, 26);
P1.P_GI_I  = ones(1, 26);


max_N_GE = max(N_GE);
max_N_GI = max(N_GI);
check_times = length(N_GE);
V_e = reshape(V_e, 75, check_times);
V_i = reshape(V_i, 25 ,check_times);

for i =1:max_N_GE+1
V_e_temp = V_e(:, N_GE==(i-1));
V_e_temp = reshape(V_e_temp, 1, 75*sum(N_GE==(i-1)));
PDF_e_temp = histogram(V_e_temp,[-66:1:101],'normalization','probability');
PDF_e_temp = PDF_e_temp.Values;
close;
P1.P_BE_Ex(i) = PDF_e_temp(76+66)/sum(PDF_e_temp(1: (76+66)));
P1.P_GE_Ex(i) = PDF_e_temp(166)/sum(PDF_e_temp(143: 167));
P1.P_BE_E(i) = sum(PDF_e_temp((142-24):142))/sum(PDF_e_temp(1:142));
end

for i =1:max_N_GI+1
V_i_temp = V_i(:, N_GI==(i-1));
V_i_temp = reshape(V_i_temp, 1, 25*sum(N_GI==(i-1)));
PDF_i_temp = histogram(V_i_temp,[-66:1:101],'normalization','probability');
PDF_i_temp = PDF_i_temp.Values;
close;

P1.P_BI_Ex(i) = PDF_i_temp(76+66)/sum(PDF_i_temp(1: (76+66)));
P1.P_GI_Ex(i) = PDF_i_temp(166)/sum(PDF_i_temp(143: 167));
P1.P_BI_E(i) = sum(PDF_i_temp((142-9):142))/sum(PDF_i_temp(1:142));
P1.P_GI_E(i) = sum(PDF_i_temp((167-9):167))/sum(PDF_i_temp(143:167));

end
%% Calculate the P: Hom

res = res7;
V_e = res.V_e;
V_i = res.V_i;
N_GI = res.N_GI;
N_GE = res.N_GE;

P1.P_BE_Ex = zeros(1, 76);
P1.P_GE_Ex = zeros(1, 76);
P1.P_BE_E  = zeros(1, 76);
P1.P_GE_E  = ones(1, 76);
P1.P_GE_I  = ones(1, 76);
P1.P_BI_Ex = zeros(1, 26);
P1.P_GI_Ex = zeros(1, 26);
P1.P_BI_E  = zeros(1, 26);
P1.P_GI_E  = zeros(1, 26);
P1.P_GI_I  = ones(1, 26);


max_N_GE = max(N_GE);
max_N_GI = max(N_GI);
check_times = length(N_GE);
V_e = reshape(V_e, 75, check_times);
V_i = reshape(V_i, 25 ,check_times);

for i =1:max_N_GE+1
V_e_temp = V_e(:, N_GE==(i-1));
V_e_temp = reshape(V_e_temp, 1, 75*sum(N_GE==(i-1)));
PDF_e_temp = histogram(V_e_temp,[-66:1:101],'normalization','probability');
PDF_e_temp = PDF_e_temp.Values;
close;
P1.P_BE_Ex(i) = PDF_e_temp(76+66)/sum(PDF_e_temp(1: (76+66)));
P1.P_GE_Ex(i) = PDF_e_temp(166)/sum(PDF_e_temp(143: 167));
P1.P_BE_E(i) = sum(PDF_e_temp((142-24):142))/sum(PDF_e_temp(1:142));
end

for i =1:max_N_GI+1
V_i_temp = V_i(:, N_GI==(i-1));
V_i_temp = reshape(V_i_temp, 1, 25*sum(N_GI==(i-1)));
PDF_i_temp = histogram(V_i_temp,[-66:1:101],'normalization','probability');
PDF_i_temp = PDF_i_temp.Values;
close;

P1.P_BI_Ex(i) = PDF_i_temp(76+66)/sum(PDF_i_temp(1: (76+66)));
P1.P_GI_Ex(i) = PDF_i_temp(166)/sum(PDF_i_temp(143: 167));
P1.P_BI_E(i) = sum(PDF_i_temp((142-9):142))/sum(PDF_i_temp(1:142));
P1.P_GI_E(i) = sum(PDF_i_temp((167-9):167))/sum(PDF_i_temp(143:167));

end

P7 = P1;

%% Calculate the P: Reg

res = res8;
V_e = res.V_e;
V_i = res.V_i;
N_GI = res.N_GI;
N_GE = res.N_GE;

P1.P_BE_Ex = zeros(1, 76);
P1.P_GE_Ex = zeros(1, 76);
P1.P_BE_E  = zeros(1, 76);
P1.P_GE_E  = ones(1, 76);
P1.P_GE_I  = ones(1, 76);
P1.P_BI_Ex = zeros(1, 26);
P1.P_GI_Ex = zeros(1, 26);
P1.P_BI_E  = zeros(1, 26);
P1.P_GI_E  = zeros(1, 26);
P1.P_GI_I  = ones(1, 26);


max_N_GE = max(N_GE);
max_N_GI = max(N_GI);
check_times = length(N_GE);
V_e = reshape(V_e, 75, check_times);
V_i = reshape(V_i, 25 ,check_times);

for i =1:max_N_GE+1
V_e_temp = V_e(:, N_GE==(i-1));
V_e_temp = reshape(V_e_temp, 1, 75*sum(N_GE==(i-1)));
PDF_e_temp = histogram(V_e_temp,[-66:1:101],'normalization','probability');
PDF_e_temp = PDF_e_temp.Values;
close;
P1.P_BE_Ex(i) = PDF_e_temp(76+66)/sum(PDF_e_temp(1: (76+66)));
P1.P_GE_Ex(i) = PDF_e_temp(166)/sum(PDF_e_temp(143: 167));
P1.P_BE_E(i) = sum(PDF_e_temp((142-24):142))/sum(PDF_e_temp(1:142));
end

for i =1:max_N_GI+1
V_i_temp = V_i(:, N_GI==(i-1));
V_i_temp = reshape(V_i_temp, 1, 25*sum(N_GI==(i-1)));
PDF_i_temp = histogram(V_i_temp,[-66:1:101],'normalization','probability');
PDF_i_temp = PDF_i_temp.Values;
close;

P1.P_BI_Ex(i) = PDF_i_temp(76+66)/sum(PDF_i_temp(1: (76+66)));
P1.P_GI_Ex(i) = PDF_i_temp(166)/sum(PDF_i_temp(143: 167));
P1.P_BI_E(i) = sum(PDF_i_temp((142-9):142))/sum(PDF_i_temp(1:142));
P1.P_GI_E(i) = sum(PDF_i_temp((167-9):167))/sum(PDF_i_temp(143:167));

end
P8=P1;

%% Calculate the P: Syn

res = res9;
V_e = res.V_e;
V_i = res.V_i;
N_GI = res.N_GI;
N_GE = res.N_GE;

P1.P_BE_Ex = zeros(1, 76);
P1.P_GE_Ex = zeros(1, 76);
P1.P_BE_E  = zeros(1, 76);
P1.P_GE_E  = ones(1, 76);
P1.P_GE_I  = ones(1, 76);
P1.P_BI_Ex = zeros(1, 26);
P1.P_GI_Ex = zeros(1, 26);
P1.P_BI_E  = zeros(1, 26);
P1.P_GI_E  = zeros(1, 26);
P1.P_GI_I  = ones(1, 26);


max_N_GE = max(N_GE);
max_N_GI = max(N_GI);
check_times = length(N_GE);
V_e = reshape(V_e, 75, check_times);
V_i = reshape(V_i, 25 ,check_times);

for i =1:max_N_GE+1
V_e_temp = V_e(:, N_GE==(i-1));
V_e_temp = reshape(V_e_temp, 1, 75*sum(N_GE==(i-1)));
PDF_e_temp = histogram(V_e_temp,[-66:1:101],'normalization','probability');
PDF_e_temp = PDF_e_temp.Values;
close;
P1.P_BE_Ex(i) = PDF_e_temp(76+66)/sum(PDF_e_temp(1: (76+66)));
P1.P_GE_Ex(i) = PDF_e_temp(166)/sum(PDF_e_temp(143: 167));
P1.P_BE_E(i) = sum(PDF_e_temp((142-24):142))/sum(PDF_e_temp(1:142));
end

for i =1:max_N_GI+1
V_i_temp = V_i(:, N_GI==(i-1));
V_i_temp = reshape(V_i_temp, 1, 25*sum(N_GI==(i-1)));
PDF_i_temp = histogram(V_i_temp,[-66:1:101],'normalization','probability');
PDF_i_temp = PDF_i_temp.Values;
close;

P1.P_BI_Ex(i) = PDF_i_temp(76+66)/sum(PDF_i_temp(1: (76+66)));
P1.P_GI_Ex(i) = PDF_i_temp(166)/sum(PDF_i_temp(143: 167));
P1.P_BI_E(i) = sum(PDF_i_temp((142-9):142))/sum(PDF_i_temp(1:142));
P1.P_GI_E(i) = sum(PDF_i_temp((167-9):167))/sum(PDF_i_temp(143:167));

end
P9=P1;

%% P7
res = res8;
bar = 0;
V_e = res.V_e;
V_i = res.V_i;
check_times = length(res.t);
V_e_m = reshape(V_e, 75, check_times);
V_i_m = reshape(V_i, 25, check_times);
V_e_p = V_e_m(:, sum(V_e_m)/75 > bar);
V_i_p = V_i_m(:, sum(V_i_m)/25 > bar);
V_e_p = V_e_p - sum(V_e_p)/75;
V_i_p = V_i_p - sum(V_i_p)/25;
res.V_e_P = reshape(V_e_p, 1,75* length(V_e_p));
res.V_i_P = reshape(V_i_p, 1,25* length(V_i_p));

P7_t = P_generation_histogram_fixedband(param7, res);
P7_t2 = P_generation_histogram(param7, res);
%compare_P(P1,P7_t2)

%% P8
res = res8;
bar = 0;
V_e = res.V_e;
V_i = res.V_i;
check_times = length(res.t);
V_e_m = reshape(V_e, 75, check_times);
V_i_m = reshape(V_i, 25, check_times);
V_e_p = V_e_m(:, sum(V_e_m)/75 > bar);
V_i_p = V_i_m(:, sum(V_i_m)/25 > bar);
V_e_p = V_e_p - sum(V_e_p)/75;
V_i_p = V_i_p - sum(V_i_p)/25;
res.V_e_P = reshape(V_e_p, 1,75* length(V_e_p));
res.V_i_P = reshape(V_i_p, 1,25* length(V_i_p));

P8_t = P_generation_histogram_fixedband(param8, res);
P8_t2 = P_generation_histogram(param8, res);
%compare_P(P1,P9_t2)

%% P9
res = res9;
bar = 0;
V_e = res.V_e;
V_i = res.V_i;
check_times = length(res.t);
V_e_m = reshape(V_e, 75, check_times);
V_i_m = reshape(V_i, 25, check_times);
V_e_p = V_e_m(:, sum(V_e_m)/75 > bar);
V_i_p = V_i_m(:, sum(V_i_m)/25 > 50);
V_e_p = V_e_p - sum(V_e_p)/75;
V_i_p = V_i_p - sum(V_i_p)/25;
res.V_e_P = reshape(V_e_p, 1,75* length(V_e_p));
res.V_i_P = reshape(V_i_p, 1,25* length(V_i_p));

P9_t = P_generation_histogram_fixedband(param9, res);
P9_t2 = P_generation_histogram(param9, res);
%compare_P(P1,P9_t,'111')
%%
histogram(res.V_e_P, [-66:1:100],'normalization', 'probability');
hold on;

histogram(res.V_i_P, [-66:1:100],'normalization', 'probability');




%%
i=24;
V_e = reshape(V_e, 75, check_times);
V_e_temp = V_e(:, N_GE==(i-1));
V_e_temp = reshape(V_e_temp, 1, 75*sum(N_GE==(i-1)));
PDF_e_temp = histogram(V_e_temp,[-66:1:101],'normalization','probability');

%%
i= 4;
V_i = reshape(V_i, 25 ,check_times);
V_i_temp = V_i(:, N_GI==(i-1));
V_i_temp = reshape(V_i_temp, 1, 25*sum(N_GI==(i-1)));
PDF_i_temp = histogram(V_i_temp,[-66:1:101],'normalization','probability');

%% Video hom
res = res7;
V_e = res.V_e;
V_i = res.V_i;
N_GI = res.N_GI;
N_GE = res.N_GE;
filename='output/hom-60000-v';
out=VideoWriter(filename);
out.FrameRate=10;
open(out);
max_N_GE = max(N_GE);
max_N_GI = max(N_GI);
check_times = length(N_GE);
V_e = reshape(V_e, 75, check_times);
V_i = reshape(V_i, 25 ,check_times);

 for i=1:max(N_GE+1)
     i
        subplot(1,2,1);
        V_e_temp = V_e(:, N_GE==(i-1));
        V_e_temp = reshape(V_e_temp, 1, 75*sum(N_GE==(i-1)));
        histogram(V_e_temp,[-66:1:101],'normalization','probability');
        ylim([0,0.04]);
        title('Distribution of membrane potential of E neurons');
        subplot(1,2,2);
        V_i_temp = V_i(:, N_GI==(i-1));
        V_i_temp = reshape(V_i_temp, 1, 25*sum(N_GI==(i-1)));
        histogram(V_i_temp,[-66:1:101],'normalization','probability', 'FaceColor','r');
        title('Distribution of membrane potential of I neurons');
        ylim([0,0.04]);
        set(gcf,'Position',[10,10,2000,2000]);
        sgtitle(['Hom N=',num2str(i)]);
        F=getframe(gcf);
        writeVideo(out,F);
 end
close(out);

%% Video reg
res = res8;
V_e = res.V_e;
V_i = res.V_i;
N_GI = res.N_GI;
N_GE = res.N_GE;
filename='output/reg-60000-v';
out=VideoWriter(filename);
out.FrameRate=10;
open(out);
max_N_GE = max(N_GE);
max_N_GI = max(N_GI);
check_times = length(N_GE);
V_e = reshape(V_e, 75, check_times);
V_i = reshape(V_i, 25 ,check_times);

 for i=1:max(N_GE+1)
     i
        subplot(1,2,1);
        V_e_temp = V_e(:, N_GE==(i-1));
        V_e_temp = reshape(V_e_temp, 1, 75*sum(N_GE==(i-1)));
        histogram(V_e_temp,[-66:1:101],'normalization','probability');
        ylim([0,0.04]);
        title('Distribution of membrane potential of E neurons');
        subplot(1,2,2);
        V_i_temp = V_i(:, N_GI==(i-1));
        V_i_temp = reshape(V_i_temp, 1, 25*sum(N_GI==(i-1)));
        histogram(V_i_temp,[-66:1:101],'normalization','probability', 'FaceColor','r');
        title('Distribution of membrane potential of I neurons');
        ylim([0,0.04]);
        set(gcf,'Position',[10,10,2000,2000]);
        sgtitle(['Reg N=',num2str(i)]);
        F=getframe(gcf);
        writeVideo(out,F);
 end
close(out);

%% Video syn
res = res9;
V_e = res.V_e;
V_i = res.V_i;
N_GI = res.N_GI;
N_GE = res.N_GE;
filename='output/syn-60000-v';
out=VideoWriter(filename);
out.FrameRate=10;
open(out);
max_N_GE = max(N_GE);
max_N_GI = max(N_GI);
check_times = length(N_GE);
V_e = reshape(V_e, 75, check_times);
V_i = reshape(V_i, 25 ,check_times);
V_e_ = res.V_e;
V_i_ = res.V_i;
check_times = length(res.t);
V_e_m = reshape(V_e_, 75, check_times);
V_i_m = reshape(V_i_, 25, check_times);
bar_=0;
V_e_p = V_e_m(:, sum(V_e_m)/75 > bar_);
V_i_p = V_i_m(:, sum(V_i_m)/25 > bar_);
V_e_p = V_e_p - sum(V_e_p)/75;
V_i_p = V_i_p - sum(V_i_p)/25;
res.V_e_P = reshape(V_e_p, 1,75* length(V_e_p));
res.V_i_P = reshape(V_i_p, 1,25* length(V_i_p));
PDF_e = histogram(res.V_e_P, (-66:1:101),'normalization','probability');
PDF_e=PDF_e.Values;
PDF_i = histogram(res.V_i_P, (-66:1:101),'normalization','probability');
PDF_i=PDF_i.Values;

 for i=1:max(N_GE+1)
     i
     j=166;
    probablity=0;
    if i==1
        lim=0.5/75;
    else
        lim=(i-1)/75;
    end
    while probablity <lim && j>1
        if j+25>166
            probablity = sum(PDF_e(j:166));
        else
            probablity = sum(PDF_e(j:j+25));
        end
        j=j-1;
    end
    if i==1
        lim=0.5/25;
    else
        lim=(i-1)/25;
    end
    probablity=0;
    k=166;
    while probablity <lim && k>1
        if k+25>166
            probablity = sum(PDF_e(k:166));
        else
            probablity = sum(PDF_e(k:k+25));
        end
        k=k-1;
    end
    
    
        subplot(1,2,1);
        V_e_temp = V_e(:, N_GE==(i-1));
        V_e_temp = reshape(V_e_temp, 1, 75*sum(N_GE==(i-1)));
        histogram(V_e_temp,[-66:1:101],'normalization','probability');

        hold on
      bar([-66:1:100]+75-j+66,PDF_e, 'FaceColor', 'y','FaceAlpha',0.5);
        hold off
        ylim([0,0.04]);
        xlim([-50,200]);
        title('Distribution of membrane potential of E neurons');
        subplot(1,2,2);
        V_i_temp = V_i(:, N_GI==(i-1));
        V_i_temp = reshape(V_i_temp, 1, 25*sum(N_GI==(i-1)));
        histogram(V_i_temp,[-66:1:101],'normalization','probability', 'FaceColor','r');
        hold on
        bar([-66:1:100]+75-k+66,PDF_i, 'FaceColor', 'y', 'FaceAlpha',0.5);
        hold off
        ylim([0,0.04]);
         xlim([-50,200]);
        title('Distribution of membrane potential of I neurons');
        set(gcf,'Position',[10,10,2000,2000]);
        sgtitle(['Syn N=',num2str(i)]);
        F=getframe(gcf);
        writeVideo(out,F);
 end
close(out);

%% Curve P

P = P9.P_BE_Ex;
P_c.P_BE_Ex = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1)) ;
P = P(1:index);
P_c.P_BE_Ex(1:index) = P_fit(x,P);

P = P9.P_BI_Ex;
P_c.P_BI_Ex = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1)) ;
P = P(1:index);
P_c.P_BI_Ex(1:index) = P_fit(x,P);

P = P9.P_GE_Ex;
P_c.P_GE_Ex = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1)) ;
P = P(1:index);
P_c.P_GE_Ex(1:index) = P_fit(x,P);

P = P9.P_GI_Ex;
P_c.P_GI_Ex = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1));
P = P(1:index);
P_c.P_GI_Ex(1:index) = P_fit(x,P);

P = P9.P_BE_E;
P_c.P_BE_E = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1));
P = P(1:index);
P_c.P_BE_E(1:index) = P_fit(x,P);

P = P9.P_BI_E;
P_c.P_BI_E = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1));
P = P(1:index);
P_c.P_BI_E(1:index) = P_fit(x,P);

P = P9.P_GE_E;
P_c.P_GE_E = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1));
P = P(1:index);
P_c.P_GE_E(1:index) = P_fit(x,P);

P = P9.P_GI_E;
P_c.P_GI_E = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1));
P = P(1:index);
P_c.P_GI_E(1:index) = P_fit(x,P);

P = P9.P_GE_I;
P_c.P_GE_I = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1));
P = P(1:index);
P_c.P_GE_I(1:index) = P_fit(x,P);

P = P9.P_GI_I;
P_c.P_GI_I = zeros(size(P));
index = sum(P>0);
x = 1:index;
P(isnan(P))=mean(P(P>0 &P<=1)) ;
P = P(1:index);
P_c.P_GI_I(1:index) = P_fit(x,P);

















