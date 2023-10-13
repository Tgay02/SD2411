function [Qe]=elq(le,q,qt);

h = 40 %mm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble element load vector
% File name: elq.m
% 
% le [m]	Element length
% q  [N/m]	Element distributed load (constant in the lab)
% qt  [N]	Element distributed torque (constant in the lab)
% Qe is returned - element load vector
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Qe = [q*h/2 ; 
      q*h/2 ;
      q*h/2 ;
      q*h/2 ;
      q*h/2 ;
      q*h/2 ]

end