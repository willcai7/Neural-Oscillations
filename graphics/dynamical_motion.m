function [] = dynamical_motion(res,param,name,save)
n=length(res.V_e)/param.ne;
% ',param.type,'
if save==true
    filename=['output/',param.type,'/',name];
    out=VideoWriter(filename);
    out.FrameRate=10;
    open(out);
    for i=1:n
        subplot(2,2,1);
        histogram(res.V_e((i-1)*param.ne+1:i*param.ne),[-param.Mr:5:param.M]);
        mean=sum(res.V_e((i-1)*param.ne+1:i*param.ne))/param.ne;
        hold on
        histogram(mean*ones(1,20),[-param.Mr:0.1:param.M]);
        ylim([0 20]);
        hold off
        title('Distribution of membrane potential of E neurons');
        subplot(2,2,2);
        histogram(res.V_i((i-1)*param.ni+1:i*param.ni),[-param.Mr:5:param.M]);
        mean=sum(res.V_i((i-1)*param.ni+1:i*param.ni))/param.ni;
        hold on
        histogram(mean*ones(1,10),[-param.Mr:0.1:param.M]);
        ylim([0 10]);
        hold off
        title('Distribution of membrane potential of I neurons');
        
        subplot(2,2,3);
        bar([1,2],[sum(res.H_ee((i-1)*param.ne+1:i*param.ne)),sum(res.H_ie((i-1)*param.ni+1:i*param.ni))]);
        ylim([0 1000])
        title('Pending E spikes on E and I neurons');
        subplot(2,2,4);
        bar([1,2],[sum(res.H_ei((i-1)*param.ne+1:i*param.ne)),sum(res.H_ii((i-1)*param.ni+1:i*param.ni))]);
%         text(3,900,num2str(sum(s(3,1:param.ne))/sum(s(3,param.ne+1:param.ne+param.ni))));
%         text(3,800,num2str(sum(s(3,1:param.ne))));
        ylim([0 1000])
        title('Pending I spikes on E and I neurons');
        set(gcf,'Position',[10,10,2000,2000]);
        F=getframe(gcf);
        writeVideo(out,F);
    end
else
    for i=1:n
        subplot(2,2,1);
        histogram(res.V_e((i-1)*param.ne+1:i*param.ne),[-param.Mr:5:param.M]);
        mean=sum(res.V_e((i-1)*param.ne+1:i*param.ne))/param.ne;
        hold on
        histogram(mean*ones(1,20),[-param.Mr:0.1:param.M]);
        ylim([0 20]);
        hold off
        title('Distribution of membrane potential of E neurons');
        subplot(2,2,2);
        histogram(res.V_i((i-1)*param.ni+1:i*param.ni),[-param.Mr:5:param.M]);
        mean=sum(res.V_i((i-1)*param.ni+1:i*param.ni))/param.ni;
        hold on
        histogram(mean*ones(1,10),[-param.Mr:0.1:param.M]);
        ylim([0 10]);
        hold off
        title('Distribution of membrane potential of I neurons'); 
        subplot(2,2,3);
        bar([1,2],[sum(res.H_ee((i-1)*param.ne+1:i*param.ne)),sum(res.H_ie((i-1)*param.ni+1:i*param.ni))]);
        ylim([0 2000])
        title('Pending E spikes on E and I neurons');
        subplot(2,2,4);
        bar([1,2],[sum(res.H_ei((i-1)*param.ne+1:i*param.ne)),sum(res.H_ii((i-1)*param.ni+1:i*param.ni))]);
%         text(3,900,num2str(sum(s(3,1:param.ne))/sum(s(3,param.ne+1:param.ne+param.ni))));
%         text(3,800,num2str(sum(s(3,1:param.ne))));
        ylim([0 2000])
        title('Pending I spikes on E and I neurons');
        set(gcf,'Position',[10,10,2000,2000]);
        pause(0.1);
        
    end
end
end
        
        
