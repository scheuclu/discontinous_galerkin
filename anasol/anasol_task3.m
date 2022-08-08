function [ sol ] = anasol_task3( x,t )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sol=[...
  cos(pi*x).*cos(pi*t)   % v
  sin(pi*x).*sin(pi*t)]; % p

end

