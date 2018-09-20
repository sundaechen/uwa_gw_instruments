% This code is for generating hexagon lattice
% Radius and lattice_param in um
tic
clear all
close all

lattice_param = 1.02;
radius_mask = 0.261;
structure_radius = 227.5/2;
w_beam = 0.133; % ion beam FWHM: 0.79nA 77nm
                %                2.5nA  133nm
                %                9.3nA  249nm            
radius = radius_mask-0.5*w_beam;
dwell_time = 8000; % unit of micro second
n_passes = 1;
hollow = 1;

n_pixel = 56576; % maximum x:65536 y:56576
resolution = 2*structure_radius/n_pixel; % um/pixel

% Current membrane Id (id of last membrane made)
% startid = 0;

for i = 1:length(radius)
    filename = strcat('Mask_SiN_hex_T200_L',...
                num2str(lattice_param*1000),...
                '_D',num2str(radius_mask*2000),...
                '_PD',num2str(structure_radius*2),...
                '_dwell_',num2str(dwell_time),...
                '_beam_', num2str(w_beam*1000),...
                '_0.5.str');
    
    % Create structures
%     PolygonFun.disk_array_holes(radius(i), lattice_param, structure_radius, nvertex, nholes, fullfilename, 1);
%     PolygonFun.hexagon_array_holes(radius(i), lattice_param, structure_radius, nvertex, nholes, fullfilename, 1);
    PolygonFun.hexagon_array_holes_stream(radius(i), lattice_param, structure_radius,...
            w_beam, resolution, filename, dwell_time, n_passes, hollow, 1);
    
    
    fclose('all');

    
%     pause(10)
%     set(gca,'visible','off')
%     saveas(gca, [filename '.png']);
end
toc