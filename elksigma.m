function [Kesigma]=elksigma(le,P,I0,A);

% I0		element polar moment of inertia [m4]
% A		element cross-section area [m2]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble element initial stress stiffness matrix
% File name: elksigma.m
% 
% le [m]	Element length
% P  [N]	"Tensile" buckling load
% Kesigma is returned - element initial stress matrix
%
% Make sure the initial stress matrix is symmetric!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Given element shape functions
Nx=[1-3*(x/h)^2+2*(x/h)^3 -x+2*(x^2/h)-(x^3/h) 1-(x-h) 3*(x/h)^2-2*(x/h)^3 (x^2/h)-(x^3/h) x/h]
%B=dN/dx
B=diff(Nx,x)

Kesigma= integral(B.T*Nx*B, 0,le)
end