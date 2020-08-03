ne=300;ni=100;
pee=0.15;pie=0.5;pei=0.5;pii=0.4;
see=5;sie=2;sei=4.91;sii=4.91;
tau_r=2.5;
M=100;Mr=66;
lambda_e=1/7;lambda_i=1/7; 
%7000 spikes/sec means time constant is 1/7 ms.
tau_ee=4; tau_ie=1.2; tau_i=4.5;

c=zeros(4,ne+ni);
c(1,1:ne)=lambda_e; c(1,ne+1:ne+ni)=lambda_i;
c(2,1:ne)=tau_ee; c(2,ne+1:ne+ni)=tau_ie; c(3,:)=tau_i;
c(4,:)=tau_r;
%c is time constant matrix. The first row is lambda_e(i), the second row 
%correspond to H_e, the third row correspond to H_i, the fourth row
%correspond to tau_r.

s=zeros(4,ne+ni);
%s is state matrix. The first three rows indicate the triplet(V,H_e,H_i)for
%each neuron, the fourth row is 1 and 0 indicating whether a neuron is at refractory
%state(1 means at refractory).

m=zeros(4,ne+ni);
m(1,:)=c(1,:);
%m is mean matrix of the next random trial. The first row of m is the same as
%the first row of c, while the other three rows is obtained by c(2:4,:)./s(2:4,:)

spike=zeros(100,ne+ni);
%spike is the spike time train of each neuron. The first row of spike is spike count.

t=0;
%t is time.

for step=1:1500000
    m(2:4,:)=c(2:4,:)./s(2:4,:);
    a=exprnd(m);
    %exponential distribution random variable
    min_a=min(min(a));
    [x,y]=find(a==min_a);
    %the position of the minimum decides the next operation. 
    t=t+a(x,y);
    if x==1 %external input operates
        if s(4,y)==0
            s(1,y)=s(1,y)+1;
        end
    elseif x==2 %H_e operates
        s(x,y)=s(x,y)-1;
        if s(4,y)==0
            if y<=ne
                s(1,y)=s(1,y)+see;
            else
                s(1,y)=s(1,y)+sie;
            end
        end
    elseif x==3 %H_i operates
        s(x,y)=s(x,y)-1;
        if s(4,y)==0
            if y<=ne
                sv=(s(1,y)+Mr)*sei/(M+Mr);
                ssv=floor(sv);
                if sv-ssv-rand(1)>0
                    s(1,y)=s(1,y)-ssv-1;
                else
                    s(1,y)=s(1,y)-ssv;
                end
            else
                sv=(s(1,y)+Mr)*sii/(M+Mr);
                ssv=floor(sv);
                if sv-ssv-rand(1)>0
                    s(1,y)=s(1,y)-ssv-1;
                else
                    s(1,y)=s(1,y)-ssv;
                end
            end
        end
    else %recover from refractory
        s(4,y)=0;
    end
    if s(1,y)>=M %a neuron reaches threshold and spike
        s(1,y)=0;
        s(4,y)=1;
        if y<=ne %an excitatory spike
            %decide the postsynaptic neurons
            p=rand(1,ne+ni);
            p(1:ne)=-p(1:ne)+pee; p(ne+1:ne+ni)=-p(ne+1:ne+ni)+pie;
            p=sign(abs(p)+p);
            s(2,:)=s(2,:)+p;
        else %an inhibitory spike
            %decide the postsynaptic neurons
            p=rand(1,ne+ni);
            p(1:ne)=-p(1:ne)+pei; p(ne+1:ne+ni)=-p(ne+1:ne+ni)+pii;
            p=sign(abs(p)+p);
            s(3,:)=s(3,:)+p;
        end
        spike(1,y)=spike(1,y)+1; %write down the spike time
        spike(spike(1,y)+1,y)=t;
    end
    if mod(step,100000)==0 %these three lines show the progress and can be deleted
        step
    end
end

%scatter plot
maxrow=max(spike(1,:));
for i=1:300
scatter(i*ones(1,maxrow),spike(2:maxrow+1,i),'.','r');
hold on
end
for i=301:400
scatter(i*ones(1,maxrow),spike(2:maxrow+1,i),'.','b');
hold on
end



