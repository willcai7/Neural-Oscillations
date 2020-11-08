function []=cluster_dissection(sd,param)
%This function dissects the sd into volleys given eps and delta.
ne = param.ne;
eps=param.cluster_eps;
delta=param.cluster_delta;
bin=param.sdbin;
duration = param.duration;
initial_index= ceil((1000)/bin);
end_index = ceil((3000+20)/bin);
sd1 = sd(1,initial_index:end_index);
kernel=ones(1,eps);
phi=conv(sd1 * ne* bin/1000,kernel,'valid');
length(phi);
time = length(phi);
times = 0:(length(phi)-1);
times = times * bin  + 1000;
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
background=200*background;
end
bar(times,background,'y');
hold on;
bar(times, phi, 'b');
hold on;
plot(times,mu*ones(1,time),'k');
hold on;
plot(times,mu*(1+delta)*ones(1,time),'k');
xlabel('Time(ms)');
ylim([0, 200]);
yticks([50, 100, 150]);
xticks([1000,1400, 1800,2200,2600,3000]);
set(gca,'fontsize',11);
hold off;

end







