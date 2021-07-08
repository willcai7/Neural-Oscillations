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
  * P_generation_statistics.m
  * P_generation_histogram.m
  * rare_model_full.m
  * firing_rate.m
* output:
  * model_full:  Results of full model.
  * model_reduced_twos: Results of two state reduced model.
  * model_reduced_coag: Results of coarse grained model.
* reference:
  * Notes
  * Papers
* graphics:
  * correlation.m
  * scatterplot.m
  * line_graph.m (Raster & Projection)
  * dynamical_motion.m
  * coarse_grained_plot.m 
* main.m
  * main_model_full.m
  * main_model_reduced.m
  * P_generation.m



