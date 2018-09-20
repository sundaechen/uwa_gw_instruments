% This code is for generating square lattice

% This mask is made on 09/12/2016
% for SiN 50 nm membrane to have high reflection at 1064 nm
% When we decided to do new membranes (200 nm thick) at 1064 nm
% We were stuck at 1078 nm
% if lambda in nm and radium in um
% lambda_res = -0.87225*radius + 1312.6
% For radius = 293 nm, thickness = 200 nm and a = 830nm
% the resonance is predicted at 1056.4 nm
% We want to scan 20 nm of resonance, we could do five membranes
% L = 1.015, 1.019, 1.020, 1.025
% R = 0.277, 0.309, 0.317, 0.354

clear all
close all

lattice_param = 1.111;
%radius = [277,309,317,354,386.5];
radius = 0.346;
% Number of holes in radius of PhC
structure_radius = 25;
nholes = floor(structure_radius/lattice_param);
% Number of points for generating circles
nvertex = 60;
%nvertex = 350;

% Current membrane Id (id of last membrane made)
startid = 0;

for i = 1:length(radius),
    filename = ['Mask_SiN_T100_L1111_D692' num2str(i+startid)];
    fullfilename = [filename '.dat'];
    
    % Create structures
    PolygonFun.disk_array_holes(radius(i), lattice_param,structure_radius, nvertex, nholes, fullfilename, 1);
    
    fclose('all');
    pause(10)
    set(gca,'visible','off')
    saveas(gca, [filename '.png']);
end
