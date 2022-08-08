function [ rho ] = rho_jump( x )

  if (x<0.333333333333333333333333333 || x>0.6666666666666666666666666667)
    rho=2;
  else
    rho=1.0;
  end

end