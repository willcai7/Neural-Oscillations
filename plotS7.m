addpath(genpath(pwd));

%% Fig S7-A

load('data/400_neuron_data/trajectory_info_sample.txt');
N_GE = trajectory_info_sample(:,2);
N_GI = trajectory_info_sample(:,3);
H_e = trajectory_info_sample(:,4);
H_i = trajectory_info_sample(:,5);


H_i = H_i(end-1000:end);
H_e = H_e(end-1000:end);
N_GE = N_GE(end-1000:end);
N_GI = N_GI(end-1000: end);


%3D
h = subplot(1,3,1); 
po = get( h, 'Position' ); 
subplot( 'Position', [po(1)-0.05, 0.1640, 0.2134, 0.7610]);
a=plot3(H_e, H_i, N_GE);
a.Color(4)=0.2;
xlabel('H^E');
ylabel('H^I');
zlabel('N_{GE}');
% å¼?å�¯ç½�?�æ�??
grid on;
xticks([0, 0.5, 1]*10^4);
yticks([0 8000 16000 24000]);
zticks([0 15 30 45 60 75]*4);
xlim([0,10000]);
ylim([0,24000]);
zlim([0,300]);
% view è°ƒè§’å�??
view([-40, 30]);
set(gca,'fontsize',15,'fontname','Arial');


%N_GE vs N_GI
subplot(1,3,2);

b=plot(N_GI, N_GE);
% è°ƒé?�æ˜Žå�??
b.Color(4)=0.2;
xlabel('N_{GI}');
ylabel('N_{GE}');
ylim([0 300]);
xlim([0 100]);
xticks([0 5 10 15 20 25]*4);
yticks([0 15 30 45 60 75]*4);


set(gca,'fontsize',15,'fontname','Arial');

h=subplot(1,3,3);
po = get( h, 'Position' ); 
subplot( 'Position', [po(1)+0.03, 0.1640, 0.2134, 0.7610]);
c=plot(H_i, N_GE);
% è°ƒé?�æ˜Žå�??
c.Color(4)=0.2;
xlabel('H^I');
ylabel('N_{GE}');
ylim([0 75]*4);
xlim([0 24000]);
yticks([0 15 30 45 60 75]*4);
xticks([0 8000 16000 24000]);
xticklabels([0 8000 16000 24000]);
% set(gcf,'Position',[10,10, 1200, 300]);
set(gca,'fontsize',15,'fontname','Arial');
set(gcf,'Position',[10,10,1500,400]);

%% S7-B
data = load('data/400_neuron_data/trajectory_info_sample_largesize.txt');
data = data(:,2:5);

% subplot 1
data1 = data(:,[1,3,4]); %N_GE, H_E, H_I
h=subplot(1,3,1); 
po = get( h, 'Position' ); 
subplot( 'Position', [po(1)-0.05, 0.1640, 0.2134, 0.7610]);
X = zeros(301, 336/16, 1024/16);
Y = zeros(301, 336/16, 1024/16);
Z = zeros(301, 336/16, 1024/16);
val = zeros(301, 336/16, 1024/16);
for i = 1:301
    for j = 1:336/16
        for k = 1:1024/16
            X(i, j, k) = i;
            Y(i, j, k) = 96*4*(j-1);
            Z(i, j, k) = 96*4*(k-1);
        end
    end
end
for i = 1: size(data,1)
    if data1(i, 2) <= 333*24 && data1(i, 3) <= 999*24
        val(data1(i,1)+1, fix(data1(i,2)/384)+1, fix(data1(i,3)/384)+1) = ...
            val(data1(i,1)+1, fix(data1(i,2)/384)+1, fix(data1(i,3)/384)+1) + 1;
    end
end
val = val/sum(sum(sum(val)));
index = val>0;
colormap(jet);
scatter3(Y(index),Z(index),X(index),5,log10(val(index)),'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1);
% Face,EdgeAlpha æ˜¯é?�æ˜Žå�??
view([-40, 30]);
% view è°ƒè§’å�??
xlabel('H^E');
ylabel('H^I');
zlabel('N_{GE}');

xticks([0, 5000, 10000]);
yticks([0 8000 16000 24000]);
zticks([0 15 30 45 60 75]*4);
xlim([0,10000]);
ylim([0,24000]);
zlim([0,300]);

caxis([-5, -2.5]);
c= colorbar('Ticks',[-4.9999 -4 -3],'Ticklabels',[-5,-4,-3],'position',[po(1)-0.005+0.2134 0.1640 0.01 0.7610]);
annotation('textbox',[po(1)+0.2134-0.02 0.761+0.05 0.1 0.2],'String','log_{10}(P)','fontsize',15,'Edgecolor','none');
set(gca,'fontsize',15,'fontname','Arial');

% Subplot 2
h2=subplot(1,3,2);
po2 = get( h2, 'Position' ); 
data2 = data(:,[1,2]);
distribution = zeros(76, 26);
for i=1:size(data,1)
    distribution(fix(data2(i,1)/4)+1, fix(data2(i,2)/4)+1) = distribution(fix(data2(i,1)/4)+1, fix(data2(i,2)/4)+1)  +1;
end
distribution = distribution/sum(sum(distribution));
imagesc(distribution);
size(distribution)
xticks([1 5 10 15 20 25]);
xticklabels([0,5,10,15,20,25]*4);
yticks([1 15 30 45 60 75]);
yticklabels([0 15 30 45 60 75]*4);

set(gca,'YDir','normal');
xlabel('N_{GI}');
ylabel('N_{GE}');
caxis([0,6.5]*10^(-3));
colorbar('Ticks',[0 2 4 6]*10^-3,'position',[0.6302 0.1640 0.01 0.7610]);
set(gca,'fontsize',15,'fontname','Arial');
% 
% 
% 
% Subplot 3
h3 = subplot(1,3,3); 
po3 = get( h3, 'Position' ); 
data3 = data(:,[1,4]);
subplot( 'Position', [po3(1)+0.03, 0.1640, 0.2134, 0.7610]);
distribution = zeros(76, 125);
for i=1:size(data,1)
    if data3(i,2) <= 24000
        distribution(fix(data3(i,1)/4)+1, fix(data3(i,2)/192)+1) = distribution(fix(data3(i,1)/4)+1, fix(data3(i,2)/192)+1)  +1;
    end
end
distribution = distribution/sum(sum(distribution));

imagesc(distribution);
xticks([1, 42, 83, 125]);
xticklabels([0, 8000, 16000, 24000]);
yticks([1 15 30 45 60 75]);
yticklabels([0 15 30 45 60 75]*4);
set(gca,'YDir','normal');
xlabel('H^I');
ylabel('N_{GE}');
caxis([0,2.2]*10^(-3));
colorbar('Ticks',[0 1 2]*10^-3,'position',[0.911+0.03 0.1640 0.01 0.7610]);

set(gca,'fontsize',15,'fontname','Arial');
set(gcf,'Position',[10,10,1500,400]);

%% Fig 7-E 3-D LLe & Local PCA
tra=load('data/400_neuron_data/trajectory_info_sample_largesize.txt');
tra=tra(:,2:5)';
res_lle=load('data/400_neuron_data/trajectory_info_sample.txt');
res_lle=res_lle';
% % lle2d=lle(res_lle,20,2);
% lle3d=lle(res_lle,20,3);
 lle3d(3,:)=-lle3d(3,:);
tra=tra(:,1:20000);

% 
% [x3,y3,z3,val3]=kde(lle3d,0.1,100);
% [x2,y2,z2,val2]=kde(lle2d,0.1,100);

h1=subplot(1,3,1);
po1=get(h1, 'Position');
subplot( 'Position', [po1(1)-0.05, 0.1640, 0.2134, 0.7610]);

colormap(jet);
% 
% dim=localpca(tra,100);
scatter3(tra(3,:),tra(4,:),tra(1,:),5,dim,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);

view([-40, 30]);
xlabel('H^E');
ylabel('H^I');
zlabel('N_{GE}');

xticks([0, 0.5, 1]*10^4);
yticks([0 8000 16000 24000]);
zticks([0 15 30 45 60 75]*4);
xlim([0,10000]);
ylim([0,24000]);
zlim([0,300]);

caxis([1.4 3]);
c= colorbar('Ticks',[1.6 2 2.4 2.8 ],'position',[po1(1)-0.005+0.2134 0.1640 0.01 0.7610]);
annotation('textbox',[po1(1)+0.2134-0.015 0.761+0.05 0.1 0.2],'String','Dim','fontsize',15,'Edgecolor','none');
set(gca,'fontsize',15,'fontname','Arial');







h3 = subplot(1,3,3); 
po3 = get( h3, 'Position' ); 
subplot( 'Position', [po3(1)+0.03, 0.1640, 0.2134, 0.7610]);

% a=plot3(lle3d(1,1500:3000),lle3d(2,1500:3000),lle3d(3,1500:3000));
 a=plot3(lle3d(1,1:1500),lle3d(2,1:1500),lle3d(3,1:1500));
a.Color(4)=0.2;
max_point=max(lle3d')+0.5;
min_point=min(lle3d')-0.5;
xlim([min_point(1),max_point(1)]);
ylim([min_point(2),max_point(2)]);
zlim([min_point(3),max_point(3)]);
xlabel('LLE1');
ylabel('LLE2');
zlabel('LLE3');
% xticks([-1 1 3 5]);
% yticks([-4 -2 0 2]);
% zticks([-3 -1 1 3 5]);
grid on;
view([-60, 5]);
set(gca,'fontsize',15,'fontname','Arial');

% a=plot(lle2d(1,1500:3000),-lle2d(2,1500:3000));
% a.Color(4)=0.2;
% max_point=max(lle2d')+0.5;
% min_point=min(lle2d')-0.5;
% xlim([min_point(1),max_point(1)]);
% ylim([-max_point(2),-min_point(2)]);
% xlabel('LLE1');
% ylabel('LLE2');
% xticks([-1,1,3,5]);
% yticks([-2,0,2,4]);
% set(gca,'fontsize',15,'fontname','Arial');
set(gcf,'Position',[10,10,1500,400]);