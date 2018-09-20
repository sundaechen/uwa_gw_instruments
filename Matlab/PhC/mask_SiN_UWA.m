% This code is for generating hexagon lattice
% Radius and lattice_param in um

clear all
close all

lattice_param = 1.028;
radius = 0.410-0.05;
% Number of holes in radius of PhC
structure_radius = 25;
nholes = floor(structure_radius/lattice_param);
% Number of points for generating circles
nvertex = 60;
%nvertex = 350;

% Current membrane Id (id of last membrane made)
% startid = 0;

for i = 1:length(radius),
    filename = ['Mask_SiN_hex_T200_L1028_D720_PD50'];
    fullfilename = [filename '.dat'];
    
    % Create structures
%     PolygonFun.disk_array_holes(radius(i), lattice_param, structure_radius, nvertex, nholes, fullfilename, 1);
    PolygonFun.hexagon_array_holes(radius(i), lattice_param, structure_radius, nvertex, nholes, fullfilename, 1);

    
    fclose('all');
    set(gca,'visible','off')
    saveas(gca, [filename '.png']);
end
