function [sd] = spikedensity_coarse(res,param)
ne = param.ne;
ni = param.ni;
spike = res.spike;
bin=param.sdbin;
duration_time = param.duration;
t=duration_time/bin;
sd.e=zeros(1,t);
sd.i=zeros(1,t);

for j=2:spike(1,1)+1
    index = ceil(spike(1,j)/bin);
    sd.e(index) = sd.e(index) +1;
end

for j=2:spike(2,1)+1
    index = ceil(spike(2,j)/bin);
    sd.i(index) = sd.i(index) +1;
end


sd.e=sd.e/((ne)*bin/1000);
sd.i=sd.i/((ni)*bin/1000);