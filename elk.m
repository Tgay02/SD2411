function [Ke]=elk(le,EI,GJ);

h=40 %mm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble element stiffness matrix
% File name: elk.m
% 
% le [m]	Element length
% EI [Nm2]	Element bending stiffness (constant in the lab)
% GJ [Nm2]	Element torsional stiffness (constant in the lab)
%
% Ke is returned - element stiffness matrix
%
% Make sure the stiffness matrix is symmetric!
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ke=[12*EI/h^3 -6*EI/h^2 0 (-12)*EI/h^3 (-6)*EI 0 ;
    (-6)*EI/h^2 4*EI/h 0 6*EI/h^2 2*EI/h 0;
    0 0 GJ/h 0 0 -GJ/h;
    (-12)*EI/h^3 6*EI/h^2 0 12*EI/h^3 6*EI/h^2 0;
    (-6)*EI/h^2 2*EI/h 0 6*EI/h^2 4*EI/h 0;
    0 0 (-GJ)/h 0 0 GJ/h]
end