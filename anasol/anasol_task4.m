function [ sol ] = anasol_task4( x,t )

sol=[...
  0.5*exp( (-( (x-c_task4(x)*t)-0.5).^2)/0.02^2 )-0.5*exp( (-( (x+c_task4(x)*t)-0.5).^2)/0.02^2 )   % v
  0.5*exp( (-( (x-c_task4(x)*t)-0.5).^2)/0.02^2 )+0.5*exp( (-( (x+c_task4(x)*t)-0.5).^2)/0.02^2 )]; % p

end

