function [ initcond ] = initcond_task4( x )

initcond=[...
  x*0   % v
  exp( (-(x-0.5).^2)/0.02^2 )]; % p

end