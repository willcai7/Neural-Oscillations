# Parameter setting

A few words to say at the first:

+ the basic parameter setting of **sync** is : 

  $\tau_{ee}=1.3, \tau_{ie}=0.95, \tau_{i}=4.5, a_{ee}=0.55, a_{ei}=0.79$

+ the basic parameter setting of **reg** is :

  $\tau_{ee}=2, \tau_{ie}=1.2, \tau_{i}=4.5, a_{ee}=0.6, a_{ei}=0.79$

+ the basic parameter setting of **hom** is :

  $\tau_{ee}=4, \tau_{ie}=1.2, \tau_{i}=4.5, a_{ee}=0.66, a_{ei}=0.79$ 

+ We should list the parameters in the **first paragraph** and then describe why we choose it in the **second paragraph** and the results like pros and cons in the **third paragraph**. 

+ there is a coefficient $\textbf{c}$ which is multiplied to probability $\textbf{p}$, and we use $(c_1,c_2,c_3,c_4,c_5,c_6,c_8)$ to denote the choice of $c$. The resulting probability is $(c_1p_1,c_2p_2,c_3p_3,c_4p_4,c_5p_5,c_6p_6,p_7,c_8p_8,p_9,p_{10},p_{11},p_{12})$ 



Parameters practiced:

+ coarse grained unfixed (non-gaussian)

  + $c=(0.5,0.5,1,1,0.42,0.7,2)$

    I compare the figure of get_thetrueP result with res7 unfixed result and choose a ratio to make the res7 probability close to that of get_thetrueP. Note that the effect of E pending spikes on I neuron is set to be **15** in get_thetrueP.  **9** has been tried but the result is not so good.

    pros: gamma oscillation can be seen 

    cons: the time interval between volleys is not so even

    

  

