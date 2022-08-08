allfiles={...
  @config_task5_K40_N4_dirichlet_hdg}
  %@config_task5_K40_N4_absorbing_hdg};

for iter=allfiles'
  CalcSetup(iter{:})
end
