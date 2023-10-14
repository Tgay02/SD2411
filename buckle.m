function [pb,ub]=buckle(Ks,Ksigmas,nnode,node_z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve beam buckling equation
% File name: buckle.m
% 
% Ks		Structural stiffness matrix
% Ksigmas	Structural inital stiffness matrix
% nnode		Number of nodes
% node_z	Nodal x-coordinates
%
% pb		Matrix with eigenvalues (load factors) in diagonal
% ub		Corresponding matrix of eigenvectors (buckling modes)
% 	(Column i of ub shows the buckling mode for buckling load (i,i) in pb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate eigenvalues and eigenvectors
[ub,pb]=eig(Ksigmas)

% Split bending and twist modes into separate vectors
%ceating a 1D vector of the eigenvalues
diag_pb=diag(pb)

%checking (Ks+lambda_i Ksigmas) w_i=0

%bending is the fist 2*nelem=2*(nnodes-1)
b=2*(nnode-1); %element index

%bending eigen vectors 
bend_vect=ub(:,1:b) %columnwise indexing creating for the bending vectors 
%bending eigen values
bend_labm=diag_pb(1:b)

%torsin eigen vectors
tors_vect=ub(:,b+1:end)
%torsion eigen values
tors_lam=diag_pb(b+1:end)

% Normalise deflections, rotations and twist for plotting purposes (without risking to mix up signs or divide by zero)
%bending vectors has the deflection and rotation component other zero
bend_defl=bend_vect(1:3:end,:)/norm(bend_vect(1:3:end,:)) %doing the normalization rowwise
bend_teta=bend_vect(2:3:end,:)/norm(bend_vect(2:3:end,:))

%torsion has the twisting componenst others are 0
tors_fi=tors_vect(3:3:end,:)/norm(tors_vect(3:3:end,:))


% Plot buckling modes
%not sure about that part
plot(node_z(:end-1),bend_defl, node_z(:end-1),bend_teta,node_z(:end-1), tors_fi )
legend('deflection', 'rotation', 'twist')

% Present the buckling loads
%??? idk should we calculate the forces





