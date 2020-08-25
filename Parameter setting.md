# Parameter setting

A few words to say at the first:

+ the basic parameter setting of **syn** is : 

  $\tau_{ee}=1.3, \tau_{ie}=0.95, \tau_{i}=4.5, a_{ee}=0.55, a_{ei}=0.79$

+ the basic parameter setting of **reg** is :

  $\tau_{ee}=2, \tau_{ie}=1.2, \tau_{i}=4.5, a_{ee}=0.6, a_{ei}=0.79$

+ the basic parameter setting of **hom** is :

  $\tau_{ee}=4, \tau_{ie}=1.2, \tau_{i}=4.5, a_{ee}=0.66, a_{ei}=0.79$ 

+ We should list the parameters in the **first paragraph** and then describe why we choose it in the **second paragraph** and the results like pros and cons in the **third paragraph**. 

+ there is a coefficient $\textbf{c}$ which is multiplied to probability $\textbf{p}$, and we use $(c_1,c_2,c_3,c_4,c_5,c_6,c_8)$ to denote the choice of $c$. The resulting probability is $(c_1p_1,c_2p_2,c_3p_3,c_4p_4,c_5p_5,c_6p_6,p_7,c_8p_8,p_9,p_{10},p_{11},p_{12})$ 



Parameters practiced:

+ 1. coarse grained unfixed (non-gaussian)

  + 1. $c=(0.5,0.5,1,1,0.42,0.7,2)$, **syn**

    + I compare the figure of get_thetrueP result with res7 unfixed result and choose a ratio to make the res7 probability close to that of get_thetrueP. Note that the effect of E pending spikes on I neuron is set to be **10** in get_thetrueP.  

    + pros: gamma oscillation can be seen 

    + cons: the time interval between volleys is not so even.

  + 2. $c=(1,0.5,1.5,1,0.42,0.7,2)$, **syn**

    + Last group of parameter is modified to get this group.  Only $c_1,c_3$ are increased which means that the external input is driving the E neurons faster. However the result is significant, oscillations and time intervals become much more regular than the last group. We can also diminish $c_8$ to increase the width of each volley, which in fact makes the inhibition slower.

    + pros: regular gamma oscillation and even time interval.

      

+ 2. reduced network model

  + 1. $c=(1,0.5,1,1,0.42,0.7,1.3)$

    + Based on the parameter 1.1, only $c_1$ is increased and $c_8$ is decreased. The reasons are similar to that of 1.2. In fact, only increasing $c_1$ to $1$ and keeping $c_8$ unchanged is also good. 1.2 has also been practiced but $c_3$ is kept unchanged at last keeping in mind that less modification from 1.1 is much reasonable.
    + pros: regular gamma oscillation can be seen.
    + cons: the width of volley is still a little bit large compared with full model. And sometimes there is a large gap between adjacent volley, which is twice as much wide as usual gap.

  + 2. $c=(1,0.5,1,1,0.42*0.6,0.7*0.6,1.3*0.6)$

    + Note that the cons of 2.1 is that the volley is a little bit wide. So I diminish the three probability related to pending spikes $c_5,c_6,c_8$ at a given ratio to narrow the volley.
    + pros: regular gamma oscillation can be seen with the width of volley narrower.
    + cons: sometimes there is a large gap between adjacent volley, which is twice as much wide as usual gap.
