function SSI = spike_synchrony_index_coarse(res, param)
w = param.w;
ne = param.ne;
ni = param.ni;
spike = res.spike;
spike = spike(1, 2:end);
spike = spike(spike>0);
SSI = [];
num1 = size(spike, 2);
for j = 1:num1
        n_t = spike(j);
        num_s = sum( abs(spike - n_t)<w/2);
        SSI = [SSI num_s];
end
SSI = mean(SSI)/(ne);
end

