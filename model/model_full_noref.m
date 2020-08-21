function [res] = model_full_noref(s,duration_time,param)
%==========================================================================
% model_full is a function to simulate the full model from paper
% 'How well do reduced models capture the dynamics in models of interacting
% neurons?' written by Yao Li.

% In the folder reference, there is a simple note about this full model.

% Here the input param is a struct that contains
% * param.M, param.Mr:
% *     Numbers of potential state.
% * param.lambda_e, param.lambda_i:
% *     Parameters for the external drive's Poisson kicks.
% * param.tau_ee,param.tau_ie, param.tau_i, param.tau_r:
% *     Parameters for the exponential distributed delay time of each kind of spikes.
% * param.ni, param.ne:
% *     Numbers of E,I neurons.
% * param.s_ee, param.s_ei, param.s_ie, param.s_ii:
% *     Parameters for the spike effects.
% * param.p_ee, param.p_ei, param.p_ie, param.p_ii:
% *     The probability about the synaptic neurons.

% The input s is the initial status matrix. If s is false, we will set it
% as a zero matrix.

% THe output res is a struct:
% * res.spikes:
% *     The output spike is a matrix where each columns represent the spike times
% *     of a neuron.The first row is the total num of its spikes.
% * res.delta_t:
% *     The time intervals between events.
% * res.H_**:
% *     Some samples of a kind of pending spikes.
% * res.V_*:
% *     Some samples of membrane potentials.
%==========================================================================
c                                 = zeros(4,param.ne + param.ni);
c(1,1:param.ne)                   = param.lambda_e;
c(1,param.ne+1:param.ne+param.ni) = param.lambda_i;
c(2,1:param.ne)                   = param.tau_ee;
c(2,param.ne+1:param.ne+param.ni) = param.tau_ie;
c(3,:)                            = param.tau_i;
%c is time constant matrix. The first row is lambda_e(i), the second row
%correspond to H_e, the third row correspond to H_i, the fourth row
%correspond to tau_r.

if s == false
    s=zeros(3,param.ne+param.ni);
end
%s is state matrix. The first three rows indicate the triplet(V,H_e,H_i)for
%each neuron, the fourth row is 1 and 0 indicating whether a neuron is at refractory
%state(1 means at refractory).

m=zeros(3,param.ne+param.ni);
m(1,:)=c(1,:);
%m is mean matrix of the next random trial. The first row of m is the same as
%the first row of c, while the other three rows is obtained by c(2:4,:)./s(2:4,:)

res.spike=zeros(2000,param.ne+param.ni);
%spike is the spike time train of each neuron. The first row of spike is spike count.

t=0;
i=1;
res.V_e = 0;
res.V_i = 0;
res.V_e_P = 0;
res.V_i_P = 0;
res.H_ie = 0;
res.H_ii = 0;
res.H_ee = 0;
res.H_ei = 0;
res.N_GE = 0;
res.N_GI = 0;
time_check = 3;
time_delta = 0;
res.var = 0;
% 
% out=VideoWriter('output\Dynamical-motion-noref.avi');
% out.FrameRate=10;
% open(out);



while t<= duration_time
    %disp(["iteration: ", step]);
    m(2:3,:)=c(2:3,:)./s(2:3,:);
    a=exprnd(m);
    %exponential distribution random variable
    min_a=min(min(a));
    [x,y]=find(a==min_a);
    %the position of the minimum decides the next operation.
    t=t+a(x,y);
%     if floor(t/2)-floor((t-a(x,y))/2)==1
%         subplot(2,2,1);
%         histogram(s(1,1:param.ne),[-param.Mr:5:param.M]);
%         mean1=sum(s(1,1:param.ne))/param.ne;
%         %         hold on
%         %         histogram(mean*ones(1,20),[-param.Mr:0.1:param.M]);
%         ylim([0 20]);
%         title('Distribution of membrane potential of I neurons');
%         subplot(2,2,2);
%         histogram(s(1,param.ne+1:param.ne+param.ni),[-param.Mr:5:param.M]);
%         mean1=sum(s(1,param.ne+1:param.ne+param.ni))/param.ni;
%                 hold on
%                 histogram(mean1*ones(1,10),[-param.Mr:0.1:param.M]);
%         ylim([0 10]);
%         title('Distribution of membrane potential of I neurons');
%         subplot(2,2,3);
%         bar([1,2],[sum(s(2,1:param.ne)),sum(s(2,param.ne+1:param.ne+param.ni))]);
%         text(3,400,num2str(sum(s(2,1:param.ne))/sum(s(2,param.ne+1:param.ne+param.ni))));
%         text(3,300,num2str(sum(s(2,1:param.ne))));
%         ylim([0 400])
%         title('Pending E spikes on E and I neurons');
%         subplot(2,2,4)
%         bar([1,2],[sum(s(3,1:param.ne)),sum(s(3,param.ne+1:param.ne+param.ni))]);
%         text(3,900,num2str(sum(s(3,1:param.ne))/sum(s(3,param.ne+1:param.ne+param.ni))));
%         text(3,800,num2str(sum(s(3,1:param.ne))));
%         ylim([0 1000])
%         title('Pending I spikes on E and I neurons');
%         pause(0.01)
% 
%                 set(gcf,'Position',[10,10,2000,2000]);
%                 F=getframe(gcf);
%                 writeVideo(out,F);
%                 close;
%     end
    res.delta_t(i)=a(x,y);
    i=i+1;
    if x==1 %external input operates
            s(1,y)=s(1,y)+1;
    elseif x==2 %H_e operates
        s(x,y)=s(x,y)-1;
            if y<= param.ne
                s(1,y)=s(1,y)+param.s_ee;
            else
                s(1,y)=s(1,y)+param.s_ie;
            end
    else %H_i operates
        s(x,y)=s(x,y)-1;
            if y<=param.ne
                sv=(s(1,y)+param.Mr)*param.s_ei/(param.M+param.Mr);
                ssv=floor(sv);
                if sv-ssv-rand(1)>0
                    s(1,y)=s(1,y)-ssv-1;
                else
                    s(1,y)=s(1,y)-ssv;
                end
            else
                sv=(s(1,y)+param.Mr)*param.s_ii/(param.M+param.Mr);
                ssv=floor(sv);
                if sv-ssv-rand(1)>0
                    s(1,y)=s(1,y)-ssv-1;
                else
                    s(1,y)=s(1,y)-ssv;
                end
        end
    end
    if s(1,y)>=param.M %a neuron reaches threshold and spike
        s(1,y)=0;
        if y<=param.ne %an excitatory spike
            %decide the postsynaptic neurons
            p=rand(1,param.ne+param.ni);
            p(1:param.ne)=-p(1:param.ne)+param.p_ee; p(param.ne+1:param.ne+param.ni)=-p(param.ne+1:param.ne+param.ni)+param.p_ie;
            p=sign(abs(p)+p);
            s(2,:)=s(2,:)+p;
        else %an inhibitory spike
            %decide the postsynaptic neurons
            p=rand(1,param.ne+param.ni);
            p(1:param.ne)=-p(1:param.ne)+param.p_ei; p(param.ne+1:param.ne+param.ni)=-p(param.ne+1:param.ne+param.ni)+param.p_ii;
            p=sign(abs(p)+p);
            s(3,:)=s(3,:)+p;
        end
        res.spike(1,y)=res.spike(1,y)+1; %write down the spike time
        res.spike(res.spike(1,y)+1,y)=t;
    end
    
    time_delta = time_delta + a(x,y);
    if time_delta >= time_check
        res.V_e = [res.V_e s(1,1:param.ne)];
        res.V_i = [res.V_i s(1,param.ne+1:param.ne+param.ni)];
        V_e_P = s(1,1:param.ne) - mean(s(1,1:param.ne));
        res.var = [res.var var(s(1,1:param.ne))];
        V_i_P = s(1,param.ne+1:param.ne+param.ni) - mean(s(1,param.ne+1:param.ne+param.ni));
        res.V_e_P = [res.V_e_P V_e_P];
        res.V_i_P = [res.V_i_P V_i_P];
        res.H_ee = [res.H_ee s(2,1:param.ne)*ones(param.ne,1)];
        res.H_ei = [res.H_ei s(3,1:param.ne)*ones(param.ne,1)];
        res.H_ie = [res.H_ie s(2,param.ne+1:param.ne+param.ni)*ones(param.ni,1)];
        res.H_ii = [res.H_ii s(3,param.ne+1:param.ne+param.ni)*ones(param.ni,1)];
        time_delta = 0;
        res.N_GE = [res.N_GE (s(1, 1:param.ne)>100-22.5)*ones(param.ne,1)];
        res.N_GI = [res.N_GI (s(1,param.ne+1:param.ne+param.ni)>100-22.5)*ones(param.ni,1)];
    end
end
end


