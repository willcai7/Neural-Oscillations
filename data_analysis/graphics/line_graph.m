function [] = line_graph(res,param)
bar=param.bar;
ne = param.ne;
ni = param.ni;
model = param.model;
num = length(res.t);
time = res.t;
H_ee = reshape(res.H_ee, ne, num);
H_ie = reshape(res.H_ie, ni, num);
H_ei = reshape(res.H_ei, ne, num);
H_ii = reshape(res.H_ii, ni, num);
H_ee = sum(H_ee);
H_ie = sum(H_ie);
H_ei = sum(H_ei);
H_ii = sum(H_ii);
subplot(3,1,1);
index = time> 1000 & time<3000;
plot(time(index), H_ie(index), 'b');
hold on
plot(time(index), H_ee(index), 'r');
xlim([1000, 3000]);
ylim([0 600]);
yticks([150,300,450]);
%ylabel('Number of pending spikes');
xticks([]);
legend('H_{IE}','H_{EE}','Location','northeastoutside','Position',[0.82,0.84,0.12,0.12],'fontsize',9);
set(gca,'Position',[0.1, 0.78, 0.7, 0.18],'fontsize',11);
subplot(3,1,2);
plot(time(index), H_ei(index),'Color','black');
hold on
plot(time(index), H_ii(index), 'g');
xlim([1000, 3000]);
ylim([0 2000]);
%ylabel('Number of pending spikes');
yticks([500,1000,1500]);
xticks([]);
legend('H_{EI}','H_{II}','Location','northeastoutside','Position',[0.82,0.63,0.12,0.12],'fontsize',9);
set(gca,'Position',[0.1, 0.57, 0.7, 0.18],'fontsize',11);
subplot(3,1,3);
if strcmp(model, 'model_full') == 0
N_GE = res.N_GE;
N_GI = res.N_GI;
else
V_e = res.V_e;
V_i = res.V_i;
V_e = reshape(V_e, ne, num);
V_i = reshape(V_i, ni, num);
N_GE = sum(V_e>bar);
N_GI = sum(V_i>bar);
end
N_GE = N_GE/ne;
N_GI = N_GI/ni;

plot(time(index), N_GE(index),'r');
hold on
plot(time(index), N_GI(index),'b');
xlim([1000, 3000]);
ylim([0 1]);
yticks([0.25, 0.5, 0.75]);
%ylabel('Ratio of gate neurons');
xticks([]);
legend('N_{GE}/N_{E}','N_{GI}/N_I', 'Location','northeastoutside','Position',[0.82,0.42,0.15,0.12],'fontsize',9);
%xlabel('ms');
set(gca,'Position',[0.1, 0.36, 0.7, 0.18],'fontsize',11);
hold off

end

