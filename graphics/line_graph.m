function [] = line_graph(res,param,name,save)
time_delta = param.time_delta;
ne = param.ne;
ni = param.ni;
type = param.type;
num = length(res.H_ee);
time = linspace(1,num* time_delta, num);
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
if save==true
saveas(gcf,['output\',type,'\graphline-',name,'.png']);
end
end

