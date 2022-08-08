allfiles={...
  @config_task3_K5_N1_LF_tend6
  @config_task3_K10_N1_LF_tend6
  @config_task3_K20_N1_LF_tend6
  @config_task3_K40_N1_LF_tend6
  @config_task3_K80_N1_LF_tend6};

for iter=allfiles'
  CalcSetup(iter{:})
end
