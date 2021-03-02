function [] = correlation(res,param)
% A function to compute and show correlation.
ne = param.ne;
ni = param.ni;
model = param.model;
spike = res.spike;
timewindow_upper=485; %note that timewindow_upper <= duration_time-15
timewindow_lower=285; %note that timewindow_lower >= 15

corr_ee=zeros(1,30); %conditioned on e at t=0, count the e spikes nearby.
corr_ie=zeros(1,30); %conditioned on e at t=0, count the i spikes nearby.
corr_ei=zeros(1,30); %conditioned on i at t=0, count the e spikes nearby.
corr_ii=zeros(1,30); %conditioned on i at t=0, count the i spikes nearby.

%we count all the spikes during the time window.
num_e=0; %number of e spikes during a given time window.
num_i=0; %number of i spikes during a given time window.

count=zeros(1,30); 

for i=1:ne
    for j=2:spike(1,i)+1
        if spike(j,i)>timewindow_lower && spike(j,i)<timewindow_upper
            num_e=num_e+1;
            for k=1:ne
                count=zeros(1,30);
                for l=2:spike(1,k)+1
                    if spike(l,k)>spike(j,i)-15 && spike(l,k)<spike(j,i)+15
                    %If there is a spike of kth neuron that fall into the
                    %1-ms time bin of the jth spike of ith neuron, the
                    %position of that time bin in 'count' will be 1.
                    count(floor(spike(l,k)-spike(j,i))+16)=1; 
                    end
                end
                corr_ee=corr_ee+count;
            end
            for k=ne+1:ne+ni
                count=zeros(1,30);
                for l=2:spike(1,k)+1
                    if spike(l,k)>spike(j,i)-15 && spike(l,k)<spike(j,i)+15
                    count(floor(spike(l,k)-spike(j,i))+16)=1;
                    end
                end
                corr_ie=corr_ie+count;
            end
        end
    end
end

for i=ne+1:ne+ni
    for j=2:spike(1,i)+1
        if spike(j,i)>timewindow_lower && spike(j,i)<timewindow_upper
            num_i=num_i+1;
            for k=1:ne
                count=zeros(1,30);
                for l=2:spike(1,k)+1
                    if spike(l,k)>spike(j,i)-15 && spike(l,k)<spike(j,i)+15
                    count(floor(spike(l,k)-spike(j,i))+16)=1;
                    end
                end
                corr_ei=corr_ei+count;
            end
            for k=ne+1:ne+ni
                count=zeros(1,30);
                for l=2:spike(1,k)+1
                    if spike(l,k)>spike(j,i)-15 && spike(l,k)<spike(j,i)+15
                    count(floor(spike(l,k)-spike(j,i))+16)=1;
                    end
                end
                corr_ii=corr_ii+count; 
            end
        end
    end
end

corr_ee=corr_ee/(num_e*ne);
corr_ie=corr_ie/(num_e*ni);
corr_ei=corr_ei/(num_i*ne);
corr_ii=corr_ii/(num_i*ni);
x=(-14.5:14.5);
subplot(1,4,1);
bar(x,corr_ee,1,'b');
ylim([0 0.4]);
xlabel('Time(ms)','fontsize',11);
set(gca,'ytick',[0 0.2 0.4 0.6], 'Position', [0.1, 0.12, 0.1725, 0.11],'fontsize',11)
% set(gca,'ytick',[])
% set(gca,'xtick',[])
%title('E spikes conditioned on E at t=0');
text(-13,0.3,'E');
subplot(1,4,2);
bar(x,corr_ie,1,'b');
ylim([0 0.4]);

set(gca,'ytick',[], 'Position', [0.30, 0.12, 0.17, 0.11],'fontsize',11)
text(-13,0.3,'I');
%xlabel('Time(ms)','fontsize',11);
% set(gca,'xtick',[])
%title('I spikes conditioned on E at t=0');
subplot(1,4,3);
bar(x,corr_ei,1,'b');
ylim([0 0.4]);
xlabel('Time(ms)','fontsize',11);
text(-13,0.3,'E');
set(gca,'ytick',[],'Position', [0.50, 0.12, 0.17, 0.11],'fontsize',11)
% set(gca,'xtick',[])
%title('E spikes conditioned on I at t=0');
subplot(1,4,4);
bar(x,corr_ii,1,'b');
ylim([0 0.4]);
%xlabel('Time(ms)','fontsize',11);
text(-13,0.3,'I');
set(gca,'ytick',[],'Position', [0.70, 0.12, 0.17, 0.11],'fontsize',11)
hold off;
end

            
