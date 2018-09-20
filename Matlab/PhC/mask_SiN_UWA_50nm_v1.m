% This mask is made after meeting of 29/09/2015
% When we decided to do new membranes (200 nm thick) at 1064 nm
% We were stuck at 1078 nm
% if lambda in nm and radium in um
% lambda_res = -0.87225*radius + 1312.6
% For radius = 293 nm, thickness = 200 nm and a = 830nm
% the resonance is predicted at 1056.4 nm
% We want to scan 20 nm of resonance, we could do five membranes
% R = 302, 305, 308, 311, 314

clear all
close all

lattice_param = 1.025;
% radius = [302, 305, 308, 311, 314];
radius = 0.683*0.5;
% Number of holes in radius of PhC
structure_radius = 25;
nholes = floor(structure_radius/lattice_param);
% Number of points for generating circles
nvertex = 60;
%nvertex = 350;

% Current membrane Id (id of last membrane made)
startid = 5;

for i = 1:length(radius),
    filename = ['Mask_SiN_T50_L1025_D708c683_v1' num2str(i+startid)];
    fullfilename = [filename '.dat'];
    
    % Create structures
    PolygonFun.disk_array_holes(radius(i), lattice_param,structure_radius, nvertex, nholes, fullfilename, 1);
    
    fclose('all');
    pause(10)
    set(gca,'visible','off')
    saveas(gca, [filename '.png']);
end
