function [defl,teta,fi,umax,tmax,fimax]=bending(Ks,Qs,K,Q,nnode,node_z);

defl=zeros(1,nnode);
teta=zeros(1, nnode);
fi=zeros(1, nnode);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate deformed beam bending and torsion shape and plot results
% File name: bending.m
%
% Ks		Structural stiffness matrix
% Qs		Structural load vector
% K		System stiffness matrix 
% Q		System load vector
% nnode		Number of nodes
% node_z	Nodal z-coordinates
%
% defl		Deflection vector of size nnodes
% teta		Rotation vector of size nnodes
% fi		Twist vector of size nnodes
% umax		Maximum deflection
% tmax	    Maximum rotation
% fimax		Maximum twist
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%w = [defl teta fi]
% Solve system of equations for the system matrix 
%in this matrix the parts connected to the wall are removed in the main
ws=Qs.'*inv(Ks);

%applying the boundary conditions to the force vector
%moving back the boundary values --> get the displacement
w=[0 0 0 ws] 

% Present displacements at the free end
%these are going to be the maximum values of the 
umax=w(end-2)
tmax=w(end-1)
fimax=w(end)

% Present reaction forces
%F_R=K*w-F
F_R=K*w.'-Q

% Create result vector containing deflections, rotations and twist
%it is inside the w vector?

% Split deflections, rotations and twist into separate vectors
defl=w(1:3:end)
teta=w(2:3:end)
fi=w(3:3:end)

% Normalise deflections, rotations and twist and plot results
defl=defl/norm(defl)
teta=teta/norm(teta)
%fi=fi/norm(fi) norm(fi)=0 therefore not a valid

subplot(2,1,1)
plot(node_z,defl, node_z,teta,node_z, fi )
legend('deflection', 'rotation', 'twist')

subplot(2,1,2)
plot(node_z, F_R(1:3:end),node_z, F_R(2:3:end),node_z, F_R(3:3:end))
legend('deflection reaction force', 'rotation reaction force', 'twist reaction force')

end
