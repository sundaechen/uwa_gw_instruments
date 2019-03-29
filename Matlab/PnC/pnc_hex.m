% function pnc_hex(a)
% For COMSOL, the default unit is um instead of nm for GDSII
% This code generate a honeycomb pattern used in the paper:
% https://www.nature.com/articles/nnano.2017.101
% 

clear all

addpath('C:\Users\Sundae\Documents\MATLAB\gdsii-toolbox-141\Basic\gdsio')
addpath('C:\Users\Sundae\Documents\MATLAB\gdsii-toolbox-141\Basic')

gs = gds_structure('BASIC');

    a = 310; % need to devide 1000 for COMSOL

    structure_radius = ceil(19.5*a/2); % need to devide 1000 for COMSOL
    lattice_param = a/sqrt(3);
    radius = 0.26*a;

    nvertex = 30;
    
    x0 = 0;
    y0 = 0;
       
%     figure()
    if isempty(findobj('Title', 'Mask'))
        ax = gca;
        title(ax, 'Mask');
    end
    axis('equal');  
    hold on
    
    nholes = floor(structure_radius/lattice_param);
    lattice_param_x = lattice_param;
    lattice_param_y = lattice_param*sin(pi/3);

    %% draw edge
    for j = -2*nholes:2*nholes
        for i = -(2*nholes+mod(j,2)/2):(2*nholes+mod(j,2)/2)
%             % for round structure
%             if i^2+(j*sin(pi/3))^2<=(structure_radius)^2/lattice_param^2 

            % for square structure
            if i^2 <=(structure_radius)^2/lattice_param^2 ...
                    && (j*sin(pi/3))^2 <=(structure_radius)^2/lattice_param^2
                
                if i^2+(j*sin(pi/3))^2 >1 % remove center hole
                
                    if mod(ceil(i)-mod(j+1,2),3)~=2
                        % Draw lattice in matlab for verification 
                        rectangle('Position',...
                            [lattice_param_x*i,lattice_param_y*j, radius, radius],...
                            'Curvature',[1 1],'EdgeColor','k');
                        
                        % create one polygon
                        c1 = polygon_circle(lattice_param_x*i,lattice_param_y*j,radius,nvertex);
                        % create boundary element and add to the structure (on different layers)
                        gs(end+1) = gds_element('boundary', 'xy', c1, 'layer',1);

                    end
                end
            end
        end
    end

    %% draw center part 
    for j = -2*nholes:2*nholes
        for i = -(2*nholes+mod(j,2)/2):(2*nholes+mod(j,2)/2)
            if i^2+(j*sin(pi/3))^2 <= 1 % remove center hole

                if mod(ceil(i)-mod(j+1,2),3)~=2
                    % Draw lattice in matlab for verification 
                    rectangle('Position',...
                        [2*sin(2*pi/3)*lattice_param_y*j, 2*sin(2*pi/3)*lattice_param_x*i, radius, radius],...
                        'Curvature',[1 1],'EdgeColor','r');
                                            
                    % create one polygon
                    c1 = polygon_circle(2*sin(2*pi/3)*lattice_param_y*j, 2*sin(2*pi/3)*lattice_param_x*i, radius,nvertex);
                    % create boundary element and add to the structure (on different layers)
                    gs(end+1) = gds_element('boundary', 'xy', c1, 'layer',1);

                end
            end
        end
    end
    
    %% center removed part
%     
%         for j = -2*nholes:2*nholes
%         for i = -(2*nholes+mod(j,2)/2):(2*nholes+mod(j,2)/2)
%             if i^2+(j*sin(pi/3))^2<=(2*radius)^2/lattice_param^2 % remove center hole
% 
%                 if mod(ceil(i)-mod(j+1,2),3)~=2
%                     % Draw lattice in matlab for verification 
%                     rectangle('Position',...
%                         [lattice_param_x*i, lattice_param_y*j,radius, radius],...
%                         'Curvature',[1 1],'EdgeColor','b');
%                 end
%             end
%         end
%     end

     hold off
     
% create a library to hold the structure
glib = gds_library('pnc', 'uunit',1e-6, 'dbunit',1e-9, gs);

% finally write the library to a file
filename = sprintf('!pnc_R_%dum_a_%dum.gds',structure_radius,a);
write_gds_library(glib, filename);

