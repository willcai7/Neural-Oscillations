#%% Module
import numpy as np
from scipy.sparse import *
import matplotlib.pyplot as plt
from tqdm import tqdm
from scipy.sparse.linalg import eigsh
from scipy.sparse.linalg import gmres
import seaborn as sns

#%% Load Data
P_E = np.loadtxt('P3_stat_noref_E.txt')
P_I = np.loadtxt('P3_stat_noref_I.txt')
states = np.loadtxt('status.txt')
P_E[1, 66] = 0.005
P_E[1, 63] = 0.01

#%%
max_state_a = np.array([60, 25, 50, 100])
min_state_a = np.array([0, 0, 0, 0])

effects = [np.array([1, 0, 0, 0]),
           np.array([0, 1, 0, 0]),
           np.array([-1, 0, 1, 0]),
           np.array([0, -1, 0, 2]),
           np.array([0, 0, 0, 0]),
           np.array([1, 0, -1, 0]),
           np.array([0, 1, -1, 0]),
           np.array([0, -1, -1, 2]),
           np.array([0, 0, -1, 0]),
           np.array([-1, 0, 0, -1]),
           np.array([-1, 0, 0, 0]),
           np.array([0, -1, 0, -1]),
           np.array([0, -1, 0, 0]),
           np.array([0, 0, 0, -1])]

def state2index(state):
    index = state[0]*26*51*101 + state[1]*51*101 + state[2]*101 + state[3]
    return int(index)

def index2state(index):
    state = np.zeros(4)
    state[0] = index // (26*51*101)
    state[1] = (index - state[0]*26*51*101) // (51*101)
    state[2] = (index - state[0]*26*51*101 - state[1]*51*101) // 101
    state[3] = index % 101
    return state.astype('int')

lamb  = 1 / 7
tau_ee = 1.4
tau_ie = 1.2
tau_i = 4.5
a_ee = 0.5
a_ie = 0.5
a_ei = 0.79
a_ii = 0.21


def p_generation(P_E_s, P_I_s, state):
    c = np.array([P_E_s[0] / lamb,
                  P_I_s[0] / lamb,
                  P_E_s[1] / lamb,
                  P_I_s[1] / lamb,
                  0,
                  P_E_s[2] * a_ee / tau_ee,
                  P_I_s[2] * a_ie / tau_ie,
                  P_E_s[3] * a_ee / tau_ee,
                  P_I_s[3] * a_ie / tau_ie,
                  0,
                  P_E_s[4] * a_ei / tau_i,
                  P_I_s[4] * a_ii / tau_i,
                  0
                  ])
    q = np.array([75 - state[0],
                  25 - state[1],
                  state[0],
                  state[1],
                  0,
                  (1 - state[0] / 75) * (state[2] - 0.5) * 24,
                  (1 - state[1] / 25) * (state[2] - 0.5) * 24,
                  state[0] / 75 * (state[2] - 0.5) * 24,
                  state[1] / 25 * (state[2] - 0.5) * 24,
                  0,
                  state[0] / 75 * (state[3] - 0.5) * 24,
                  state[1] / 25 * (state[3] - 0.5) * 24,
                  0])
    q = np.multiply(c, q)
    q[4] = 100 / lamb - q[0] - q[1] - q[2] - q[3]
    q[9] = a_ee * (state[2] - 0.5) * 24 / tau_ee + a_ie * (state[2] - 0.5) * 24 / tau_ie - q[5] - q[6] - q[7] - q[8]
    q[12] = (state[3] - 0.5) * 24 / tau_i - q[10] - q[11]
    q = np.maximum(q, 0)
    s = np.zeros(15)
    s[0] = q[0] + q[5] * 23/24
    s[1] = q[1] + q[6] * 23/24
    s[2] = q[2] + q[7] * 23/24
    s[3] = q[3] + q[8] * 23/24
    s[4] = q[4] + q[9] * 23/24 + q[12] * 23/24
    s[5] = q[5] * 1/24
    s[6] = q[6] * 1/24
    s[7] = q[8] * 1/24
    s[8] = q[9] * 1/24
    s[9] = q[10] * 1/24
    s[10] = q[10] * 23/24 + q[7] * 1/24
    s[11] = q[11] * 1/24
    s[12] = q[11] * 23/24
    s[13] = q[12] * 1/24
    return s


#%%

row = np.zeros(8169485 * 15)
col = np.zeros(8169485 * 15)
val = np.zeros(8169485 * 15)
num_total_states = 61 * 26 * 101 * 51
index1 = 0
for j in tqdm(range(num_total_states)):
    state = index2state(j)
    # print(state)
    P_E_s = P_E[:, state[0]]
    P_I_s = P_I[:, state[1]]
    q = p_generation(P_E_s, P_I_s, state)
    col_j = np.array([])
    row_j = np.array([])
    val_j = np.array([])
    for i in range(14):
        effect = effects[i]
        state_a = state + effect
        if all(state_a>= min_state_a) and all(state_a<= max_state_a):
            col_j = np.hstack([col_j, j])
            row_j = np.hstack([row_j, state2index(state_a)])
            val_j = np.hstack([val_j, q[i]])
    val_j = val_j / np.sum(val_j)
    size1 = np.size(val_j)
    col[index1: index1 + size1] = col_j
    row[index1: index1 + size1] = row_j
    val[index1: index1 + size1] = val_j
    index1 += size1

#%%
row = np.load('row.npy').astype('int')
col = np.load('col.npy').astype('int')
val = np.load('val.npy')

#%%
z= np.random.rand(8169486)
z = z/np.sum(z)

#%%
row = row.astype('int')
col = col.astype('int')
mat = csc_matrix((val, (row, col))) - 1.02*eye(8169486)
for i in tqdm(range(100)):
    z_new,_ = gmres(mat, z)
    z_new = z_new / np.sum(z_new)
    err = np.linalg.norm(z_new-z, 1)
    # z = np.maximum(z,0)
    # z = z/np.sum(z)
    print(err)
    if err<10**(-6):
        break
    z = z_new

#%%
np.savetxt('stationary_d.txt', z)

#%% H_e vs H_i
distribution = np.zeros([76, 26])
for i in range(num_total_states):
    p = z[i]
    state = index2state(i)
    distribution[state[0], state[1]] += p

#%%
sns.heatmap(distribution).invert_yaxis()
plt.xticks(rotation=0)
plt.xlabel('N_GI')
plt.ylabel('N_GE')


#%%
from mpl_toolkits.mplot3d import Axes3D

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
x = []
y = []
w = []
val = []
for i in range(61):
    for j in range(51):
        for k in range(101):
            val_ = 0
            for s in range(26):
                val_ += z[state2index([i,s,j,k])]
            x.append(i)
            y.append(j)
            w.append(k)
            val.append(val_)
x = np.array(x)
y = np.array(y)
w = np.array(w)
val = np.array(val)
#%%
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.scatter(y[val>10**(-5)]*25,w[val>10**(-5)]*25,x[val>10**(-5)], c=np.log(val[val>10**(-5)]), alpha=0.05)
ax.set_xlabel('$H_E$')
ax.set_ylabel('$H_I$')
ax.set_zlabel('$N_{GE}$')
plt.set_cmap('viridis')
ax.view_init(40, -140)

#%% N_GE vs N_GI
distribution = np.zeros([76, 26])
for i in range(num_total_states):
    p = z[i]
    state = index2state(i)
    distribution[state[0], state[1]] += p

#%%
sns.heatmap(distribution, cmap='viridis').invert_yaxis()
plt.xticks(rotation=0)
plt.xlabel('$N_{GE}$')
plt.ylabel('$N_{GI}$')

#%% N_GE vs H_i

distribution1 = np.zeros([76, 101])
for i in range(num_total_states):
    p = z[i]
    state = index2state(i)
    distribution1[state[0], state[3]] += p

#%%
sns.heatmap(distribution1, cmap='viridis').invert_yaxis()
plt.xticks(rotation=0)
plt.xlabel('$N_{GE}$')
plt.ylabel('$H_I$')