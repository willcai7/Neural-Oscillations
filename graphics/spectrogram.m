function [spectrogram]=spectrogram(sd,param, name, save)

%unit of timewindow and bin is milisecond while unit of frequency is times/second.
tw=param.spectrogram_timewindow;
bin=param.sdbin;
fr=param.frequency_range;
duration = param.duration;
initial_index = ceil((duration-2000)/ bin);
N=tw/bin;
model = param.model;
kernel=(exp(-2*pi*i*bin/1000)*ones(1,N)).^(1:N)';
num_spec= length(sd) - N+1 - initial_index+1;
spectrogram=zeros(fr(2)-fr(1)+1,num_spec);
for j=1:num_spec
    for k=1:fr(2)-fr(1)+1
        spectrogram(k,j)=abs(bin/1000 * sd(initial_index+j -1: initial_index+j+N-2)*(kernel.^(k+fr(1)-1))...
            /sqrt(tw/1000))^2;
    end
end

%smoothing
norm(spectrogram,'fro')
spectrogram1=conv2(spectrogram,ones(1,16)/16, 'valid');
frs   = linspace(fr(1), fr(2), fr(2)-fr(1)+1);
times = 0: num_spec;
times = times *bin + duration - 2000;
imagesc(times, frs, spectrogram1);
set(gca,'YDir','normal');
xlabel('Time(ms)');
ylabel('Freq(Hz)');
hcb=colorbar;
ylabel(hcb,'(spikes/sec)^2/Hz');
colormap turbo;
caxis([0 800]);
set(gcf,'Position',[10,10,1000,200]);
title(name);
if save==true
saveas(gcf,['output\',model,'\spectrogram-',name,'.png']);
end




         
    
    