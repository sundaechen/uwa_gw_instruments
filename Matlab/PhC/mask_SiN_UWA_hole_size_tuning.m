% This code is for generating hexagon lattice
% Radius and lattice_param in um

clear all
close all

lattice_param = 1.016;
diameters = [0.464:0.01:0.704];
% radius = 0.450/2;
% Number of holes in radius of PhC
structure_radius = 5;
nholes = floor(structure_radius/lattice_param);
% Number of points for generating circles
nvertex = 60;
%nvertex = 350;

% Current membrane Id (id of last membrane made)
startid = 0;

% filename = ['Mask_SiN_Hex_T200_L1007_Dtuning_PD10_v3'];
% fullfilename = [filename '.dat'];
% fid = fopen(fullfilename, 'w');
% fclose(fid)
    
for i = 1:length(diameters)
    disp([i,length(diameters)])
    offset_y = floor((i-1)./5)*structure_radius*2+1;
    offset_x = mod((i-1),5)*structure_radius*2+1;
    
    filename = ['Mask_SiN_Hex_T200_L1016_D' '_PD10_' num2str(i+startid)];
    fullfilename = [filename '.dat'];
    
    % Create structures
%     PolygonFun.disk_array_holes(radius(i), lattice_param, structure_radius, nvertex, nholes, fullfilename, 1);
    PolygonFun.hexagon_array_holes_array(offset_x, offset_y, ...
        diameters(i)./2, lattice_param, structure_radius, ...
        nvertex, nholes, fullfilename, 1);

    
    fclose('all');
%    pause(10)
    set(gca,'visible','off')
%     saveas(gca, [filename '.png']);
end