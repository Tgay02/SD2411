function [pb,ub]=buckle(Ks,Ksigmas,nnode,node_z)

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
[ub,pb]=eig(Ks,-Ksigmas);

% Split bending and twist modes into separate vectors

%bending is the fist 2*nelem=2*(nnodes-1)
b=2*(nnode-1); %element index
%bending eigen vectors 
%bend_vect=ub(:,1:b) %columnwise indexing creating for the bending vectors 
%torsion
%tors_vect=ub(:,b+1:end)
[n,m] = size(ub);
bend_vect = [];
tors_vect = [];
for ii = 1:m
    if 0.001 > sum((ub(3:3:end,ii).^2))
        bend_vect =  [bend_vect ub(:,ii)];
    else
        tors_vect =  [tors_vect ub(:,ii)];
    end
end


% Normalise deflections, rotations and twist for plotting purposes (without risking to mix up signs or divide by zero)
% Plot buckling modes

% %bending vectors has the deflection and rotation component other zero
bend_defl=bend_vect(1:3:end,:);
bend_teta=bend_vect(2:3:end,:);
% %torsion has the twisting componenst others are 0
tors_fi=tors_vect(3:3:end,:);

for i=1:b
    hold on
    bend_defl(:,i)=bend_defl(:,i)/norm(bend_defl(:,i));
    wdefl = [0, bend_defl(:,i).'];
    subplot(3,2,2)
    plot(node_z,wdefl)
    legend(string(i)+'.vectors deflection')

end

for i=1:b
    hold on
    bend_teta(:,i)=bend_teta(:,i)/norm(bend_teta(:,i));
    wtetal = [0,bend_teta(:,i).'];
    subplot(3,2,4)
    plot(node_z,wtetal)
    legend(string(i)+'.vectors rotation')

    hold off

end 

for i=1:length(tors_fi(1,:))
    hold on
    tors_fi(:,i)=tors_fi(:,i)/norm(tors_fi(:,i));
    wfi = [0,tors_fi(:,i).'];
    subplot(3,2,6)
    plot(node_z,wfi)
    legend(string(i)+'.vectors twist')
    hold off

end

% Present the buckling loads
%ceating a 1D vector of the eigenvalues
diag_pb=diag(pb)


end



