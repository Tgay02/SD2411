%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Program
% Beam FE-code for bending about 1-axis and St.Venant torsion
%
% Use SI units only
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf

% Definitions and input data
L=1 %1.0;		% Length [m]
E=1 %7E+10;	% Youngs modulus [N/m2]
G=1%2.6923E+10;	% Shear modulus [N/m2]
I=1%2E-9;		% Moment of inertia about x-axis [m4]
J=1%1E-9;		% Torsional constant [m4]
EI=1%E*I;		% Bending stiffness [Nm2]
GJ=1%G*J;		% Torsional stiffness [Nm2]
I0=1%4E-8;	% Polar moment of inertia [m4]
A=1%1.2E-4;	% Cross-section area [m2]
ro=1%2700;	% Material density [kg/m3]
J0=1%I0*ro;	% Mass moment of inertia [kgm]
%h=0.04;

% Loads and masses
m=A*ro;	% mass per unit length of elements [kg/m]
q=0;           % Distributed load [N/m]
qt=1;		% Distributed torque [Nm/m]
S=0;           % Concentrated load at end of beam [N]
T=0;		% Beam end torque [Nm]
P=-1;		% Buckling load [N]

% Element input data
nelem=10;		% number of elements
le=L/nelem;		% length of elements for even distribution
ndof=3*(nelem+1);	% number of degrees of freedom
nnode=nelem+1;		% number of nodes

% Node coordinates
node_z=zeros(nnode,1);
for i=1:nnode
        node_z(i)=le*(i-1);
end

% Assemble stiffness, load and initial stress matrix of the system
[K,Q,M,Ksigma]=assemble(le,EI,GJ,I0,A,J0,q,qt,S,T,m,P,ndof,nelem);

% Apply boundary conditions
% Remove locked dofs at x=0
% K,Q,M and Ksigma are now reduced and structural matrices formed
Ks=K(4:ndof,4:ndof);
Qs=Q(4:ndof);
Ms=M(4:ndof,4:ndof);
Ksigmas=Ksigma(4:ndof,4:ndof);

% Solve beam bending and torsion equation and present results
 
[defl,teta,fi,wmax,tmax,fimax]=bending(Ks,Qs,K,Q,nnode,node_z);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Solve beam buckling equation and plot results
% % The torsional buckling modes will all give identical load factors
% % pb is a matrix containing the buckling load factors, in ascending order
% % ub is a matrix of corresponding buckling modes (as columns)
% % (Column i of ub is buckling mode of buckling load (i,i) in pb)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pb,ub]=buckle(Ks,Ksigmas,nnode,node_z);

