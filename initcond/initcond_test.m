function [ initcond ] = initcond_test( x )

initcond=[...
  cos(pi*x).*cos(pi*0)   % v
  sin(pi*x).*sin(pi*0)]; % p


end