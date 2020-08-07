function [] = correlation(spike,ne,ni,name)
% A function to compute and show correlation.
timewindow_upper=985; %note that timewindow_upper <= duration_time-15
timewindow_lower=785; %note that timewindow_lower >= 15

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
ylim([0 0.3]);
title('E spikes conditioned on E at t=0');
subplot(1,4,2);
bar(x,corr_ie,1,'b');
ylim([0 0.3]);
title('I spikes conditioned on E at t=0');
subplot(1,4,3);
bar(x,corr_ei,1,'b');
ylim([0 0.3]);
title('E spikes conditioned on I at t=0');
subplot(1,4,4);
bar(x,corr_ii,1,'b');
ylim([0 0.3]);
title('I spikes conditioned on I at t=0');
set(gcf,'Position',[10,10,2000,150]);
saveas(gcf,['output\',name,'.png']);

end

            
