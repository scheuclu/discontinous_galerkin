function [ rho ] = rho_task5( x )

  if (x<0.333333333333333333333333333 || x>0.6666666666666666666666666667)
    rho=0.16;
  else
    rho=1.0;
  end

end

