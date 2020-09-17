%This is a function to detect and simulate rare events.
%We pick the rare events in the res of normal full model, then do specific
%simulations for rare events.
function [rare_res] = rare_model_full(normal_res,param)
rare_res.V_e = [];
rare_res.V_i = [];
rare_res.H_ee = [];
rare_res.H_ei = [];
rare_res.H_ie = [];
rare_res.H_ii = [];
rare_res.N_GE = [];
rare_res.N_GI = [];


res=normal_res;
V_e = res.V_e;
V_i = res.V_i;
N_GI = res.N_GI;
N_GE = res.N_GE;
H_ee = res.H_ee;
H_ei = res.H_ei;
H_ie = res.H_ie;
H_ii = res.H_ii;




max_N_GE = max(N_GE);
max_N_GI = max(N_GI);
check_times = length(N_GE);
V_e = reshape(V_e, 75, check_times);
V_i = reshape(V_i, 25 ,check_times);
H_ee = reshape(H_ee, 75, check_times);
H_ei = reshape(H_ei, 75, check_times);
H_ie = reshape(H_ie, 25, check_times);
H_ii = reshape(H_ii, 25, check_times);


%If the N_GE is in the range [max_N_GE-5,max_N_GE] and on the rising period
%or N_GI is in the range [max_N_GI-2,max_N_GI] and on the rising period,
%we call it rare events.

ind1=N_GE>=max_N_GE-5; %range
ind2=N_GE>[N_GE(2:check_times),N_GE(check_times)]; %rising
index=logical(ind1.*ind2);
rare_V_e = V_e(:, index);
rare_V_i = V_i(:, index);
rare_H_ee = H_ee(:, index);
rare_H_ei = H_ei(:, index);
rare_H_ie = H_ie(:, index);
rare_H_ii = H_ii(:, index);

ind1=N_GE>=max_N_GI-2; %range
ind2=N_GE>[N_GI(2:check_times),N_GI(check_times)]; %rising
index=logical(ind1.*ind2);
rare_V_e = [rare_V_e,V_e(:, index)];
rare_V_i = [rare_V_i,V_i(:, index)];
rare_H_ee = [rare_H_ee,H_ee(:, index)];
rare_H_ei = [rare_H_ei,H_ei(:, index)];
rare_H_ie = [rare_H_ie,H_ie(:, index)];
rare_H_ii = [rare_H_ii,H_ii(:, index)];


row_size=size(rare_V_e);
row_size=row_size(1);

%randomly pick some initial states from 'rare'.
pick_index=ceil(rand(1,param.simulation_times)*row_size);
s=zeros(4,param.ne+param.ni);

for i=1:param.simulation_times
    
    s(1,:)=[rare_V_e(:,pick_index(i))',rare_V_i(:,pick_index(i))'];
    s(2,:)=[rare_H_ee(:,pick_index(i))',rare_H_ie(:,pick_index(i))'];
    s(3,:)=[rare_H_ei(:,pick_index(i))',rare_H_ii(:,pick_index(i))'];
    short_simulation_res = model_full(s,5,param);
    rare_res.V_e = [rare_res.V_e,short_simulation_res.V_e];
    rare_res.V_i = [rare_res.V_i,short_simulation_res.V_i];
    rare_res.N_GE = [rare_res.N_GE,short_simulation_res.N_GE];
    rare_res.N_GI = [rare_res.N_GI,short_simulation_res.N_GI];
end

end







