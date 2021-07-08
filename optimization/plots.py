#%%
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

val = np.loadtxt('stationary_d.txt')
states = np.load('t_states.npy')

#%%
num_val = np.size(val)
index = np.random.choice(num_val, 10000)
n_ge = states[:, 0]
n_gi = states[:, 1]
h_e = states[:, 2]
h_i = states[:, 3]

#%% H_e vs H_i
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.cm as cm

color = val[index]
color = np.maximum(10**(-20), color)
color[color>10] = 10
color = color/sum(color)
# color = color/np.sum(color)*10000
# color = np.log(color)
# color = color - np.min(color)
fig = plt.figure()
# ax = fig.add_subplot(111, projection='3d')
#ax.scatter(n_ge[index],h_i[index],h_e[index], s=1, c= color)
plt.scatter(n_ge[index],n_gi[index], s=1, c= color)
plt.show()

#%% n_ge vs n_gi
import  seaborn as sns

n_ge_p = n_ge[index]
n_gi_p = n_gi[index]
color = val[index]
distr = np.zeros([75, 25])
for i in range(num_val):
    distr[n_ge[i], n_gi[i]] += val[i]

sns.heatmap(distr)

#%% H_e vs H_i
import  seaborn as sns

n_ge_p = n_ge[index]
n_gi_p = n_gi[index]
color = val[index]
distr = np.zeros([3001, 25])
for i in range(num_val):
    distr[h_i[i], n_gi[i]] += val[i]
#distr[distr>0.0004] = 0.0004
sns.heatmap(distr)

#%%
import seaborn as sns
data = np.loadtxt('full_model_status.txt')
data = data.astype('int')
n_ge = data[:, 0]
n_gi = data[:, 1]
num_val = np.size(data, 0)
distr = np.zeros([76, 26])
for i in range(num_val):
    distr[n_ge[i], n_gi[i]] += 1
distr = distr/np.sum(np.sum(distr))
sns.heatmap(distr).invert_yaxis()
plt.xticks(rotation=0)
plt.xlabel('N_GI')
plt.ylabel('N_GE')
plt.title('Simulation results')

#%%
import seaborn as sns
h_e = data[:, 2]
h_i = data[:, 3]
num_val = np.size(data, 0)
distr = np.zeros([3000, 1500])
for i in range(num_val):
    distr[h_i[i], h_e[i]] += 1
sns.heatmap(distr).invert_yaxis()
plt.xticks(rotation=0)
plt.xlabel('H_e')
plt.ylabel('H_i')
plt.title('Simulation results')

#%%
import seaborn as sns
data = np.loadtxt('cg_model_status.txt')
data = data.astype('int')
n_ge = data[:, 0]
n_gi = data[:, 1]
num_val = np.size(data, 0)
distr = np.zeros([76, 26])
for i in range(num_val):
    distr[n_ge[i], n_gi[i]] += 1
distr = distr/np.sum(np.sum(distr))
sns.heatmap(distr).invert_yaxis()
plt.xticks(rotation=0)
plt.xlabel('N_GI')
plt.ylabel('N_GE')
plt.title('Simulation results')

#%%
import seaborn as sns
data = np.loadtxt('scg2_model_status.txt')
data = data.astype('int')
n_ge = data[:, 0]
n_gi = data[:, 1]
num_val = np.size(data, 0)
distr = np.zeros([76, 26])
for i in range(num_val):
    distr[n_ge[i], n_gi[i]] += 1
distr = distr/np.sum(np.sum(distr))
sns.heatmap(distr).invert_yaxis()
plt.xticks(rotation=0)
plt.xlabel('N_GI')
plt.ylabel('N_GE')
plt.title('Simulation results')