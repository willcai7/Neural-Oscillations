function [] = line_graph(res,param,name,save, bar)
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

subplot(2,1,1);
index = time> param.duration -1000;
plot(time(index), H_ee(index), 'r');
hold on
plot(time(index), H_ie(index), 'b');
title(name);
hold on
plot(time(index), H_ei(index),'Color','black');
hold on
plot(time(index), H_ii(index), 'g');
xlim([param.duration-1000,param.duration+100]);
ylim([0 1000]);
legend('H_{EE}','H_{IE}','H_{EI}','H_{II}');
subplot(2,1,2);
if param.model == 'model_reduced_twos'
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
xlim([param.duration-1000, param.duration+100]);
ylim([0 1]);
legend('N_{GE}/N_{E}','N_{GI}/N_I');
xlabel('Time(ms)');
set(gcf,'Position',[10,10,1000,400]);
if save==true
saveas(gcf,['output\',model,'\graphline-',name,'.png']);
end
end

