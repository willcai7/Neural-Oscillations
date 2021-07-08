from scipy.sparse import *
import numpy as np
import pandas as pd
from tqdm import tqdm
from scipy.sparse.linalg import gmres


data = pd.read_csv('P_matrix.txt', sep=' ', header=None)
data = data.to_numpy()
col = data[:, 0]
row = data[:, 1]
val = data[:, 2]
col = col.astype('int')
row = row.astype('int')
from tqdm import tqdm
index = 0
for i in tqdm(range(np.size(val))):
    if col[i] != col[index]:
        total_p = np.sum(val[index:i])
        if total_p != 1:
            val[index:i] = val[index:i]/total_p
        index = i

z= np.random.rand(5577153)
z = z/np.sum(z)
mat = csc_matrix((val, (row, col))) - 1.05*eye(5577153)
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


