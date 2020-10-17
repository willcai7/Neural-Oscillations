function [coordinate]=cluster_dissection(sd,param,name, save)
%This function dissects the sd into volleys given eps and delta.
ne = param.ne;
eps=param.cluster_eps;
delta=param.cluster_delta;
bin=param.sdbin;
model = param.model;
duration = param.duration;
initial_index= ceil((duration - 2000)/bin);
sd1 = sd(1,initial_index:end);
kernel=ones(1,eps);
phi=conv(sd1 * ne* bin/1000,kernel,'valid');
time = length(phi);
times = 0:(length(phi)-1);
times = times * bin  + duration - 2000;
mu = mean(phi);
i=0;
coordinate =[];
while i<time
    i=i+1;
    if phi(i)>=(1+delta)*mu
        k=i;
        j=i;
        while k>=1&&phi(k)>=mu
            k=k-1;
        end
        while j<=time&&phi(j)>=mu
            j=j+1;
        end
        if j-k-1>eps/2
            coordinate=[coordinate,[k+1;j-1]];
        end
        i=j;
    end
end
i=1;
coordinate
if isempty(coordinate) ==0
while i<length(coordinate(1,:))
    while coordinate(1,i+1)-coordinate(2,i)<=eps/2
        coordinate(2,i)=coordinate(2,i+1);
        if i+2<=length(coordinate(1,:))
            coordinate=[coordinate(:,1:i),coordinate(:,i+2:length(coordinate(1,:)))];
        else
            coordinate=coordinate(:,1:i);
            break;
        end
    end
    i=i+1;
end

background=zeros(1,time);
for i=1:length(coordinate(1,:))
    background(coordinate(1,i):coordinate(2,i))=1;
end
background=600*background;

bar(times,background,'y');
hold on
end
bar(times, phi, 'b','FaceAlpha',0.7);
hold on
plot(times,mu*ones(1,time),'k');
hold on
plot(times,mu*(1+delta)*ones(1,time),'k');
xlabel('Time(ms)');
set(gcf,'Position',[10,10,1000,200]);
ylim([0, 400]);
title(name);
if save==true
saveas(gcf,['output\',model,'\cluster-',name,'.png']);
end


end







