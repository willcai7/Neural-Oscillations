addpath(genpath(pwd));

%% Fig S7-A

load('data/400_neuron_data/trajectory_info_sample.txt');
N_GE = trajectory_info_sample(:,2);
N_GI = trajectory_info_sample(:,3);
H_e = trajectory_info_sample(:,4);
H_i = trajectory_info_sample(:,5);

Win = length(N_GE) - 100;
H_i = H_i(end-Win:end);
H_e = H_e(end-Win:end);
N_GE = N_GE(end-Win:end);
N_GI = N_GI(end-Win: end);


%3D
figure('Name','TrajIllus','Units',"normalized","OuterPosition",[0 0 .37 1])
a=plot3(N_GE, H_i, H_e,'b');
a.Color(4)=0.2;
zlabel('H^E');
ylabel('H^I');
xlabel('N_{GE}');
% Ã¥Â¼?Ã¥ï¿½Â¯Ã§Â½â?Ã¦Â??
grid on;
zticks([0, 0.5, 1]*10^4);
yticks([0 8000 16000 24000]);
xticks([0 15 30 45 60 75]*4);
zlim([0,10000]);
ylim([0,24000]);
xlim([0,150]);
% view Ã¨Â°ÆÃ¨Â§âÃ¥Â??
view([-40, 30]);
set(gca,'fontsize',15,'fontname','Arial');

hold on
ShowSize = 50;
for tInd = 100:length(N_GE) - ShowSize
    Win = tInd:tInd+ShowSize-1;
    a1 = plot3(N_GE(Win), H_i(Win), H_e(Win), 'r','LineWidth',3);
    pause(.2)
    delete(a1)
end

