function [Kesigma]=elksigma(le,P,I0,A)
h=le; %m
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
% x=le;
% %Given element shape functions
% Nx=[1-3*(x/h)^2+2*(x/h)^3 -x+2*(x^2/h)-(x^3/h) 1-(x-h) 3*(x/h)^2-2*(x/h)^3 (x^2/h)-(x^3/h) x/h];
% %B=dN/dx
% B=diff(Nx,x);
% 
% Kesigma= integral(B.T*Nx*B, 0,le);

Kesigma=[36*P/(30*h) -3*h*P/(30*h) 0 -36*P/(30*h) -3*h*P/(30*h) 0;
    -3*h*P/(30*h) 4*h^2*P/(30*h) 0 3*h*P/(30*h) -h^2*P/(30*h) 0;
    0 0 I0*P/(A*h) 0 0 -I0*P/(A*h);
    -36*P/(30*h) 3*h*P/(30*h) 0 36*P/(30*h) 3*h*P/(30*h) 0;
    -3*h*P/(30*h) -h^2*P/(30*h) 0 3*h*P/(30*h) 4*h^2*P/(30*h) 0;
    0 0 -I0*P/(A*h) 0 0 I0*P/(A*h)];

end