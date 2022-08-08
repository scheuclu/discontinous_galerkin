allfiles={...
  @config_task4_K40_N4_absorbing_hdg.m
  @config_task4_K40_N4_absorbing_lf.m
  @config_task4_K40_N4_dirichlet_hdg.m
  @config_task4_K40_N4_dirichlet_lf.m
  @config_task5_K40_N4_absorbing_hdg.m
  @config_task5_K40_N4_dirichlet_hdg.m};

for iter=allfiles'
  CalcSetup(iter{:})
end

