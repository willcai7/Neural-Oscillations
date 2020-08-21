# Neural-Oscillations

## File

* model:
  * model_full.m 增加变量判断是否ratio
    * Res. V_e， Res.V_i
    * Res.V_e_P, Res.V_e_P (mean<0)
    * Res.H_ee, H_ei, H_ie, H_ii
    * Res.spike
    * Res.N_GE, Res.N_GI
    * Res.t
  * model_reduced_network.m 
  * coarse_grained.m
  * P_generation_gaussian.m (V_e, V_i)
  * P_generation_histogram.m
  * firing_rate.m
* output:
  * reg:
  * syn:
  * hom:
* reference:
  * Notes
  * Papers
* graphics:
  * correlation.m
  * Rasterplot.m
  * line_graph.m (Raster & Projection)
  * dynamical_motion.m
  * line_graph_coarse.m 
* main.m
  * delete start_time



## Variable

* P



## Progress

* s_ee=25, s_ie=15, s_ei=25, s_ii= 25,
* gate =75 ,  
* p_generation, start from 0.5,

