function hexagon_array_holes_stream(radius, lattice_param, structure_radius, w_beam, resolution, filename, dwell_time, n_passes, hollow, show)
% Generate a list of beam positions according to the beam width
% and put it in filename with formatting for FEI stream file
% Radius and lattice_param in um

% 1st param: dwell time in unit of 100ns 
% 2nd param: x position
% 3rd param: y position
% 4th param(optical): beam blanked 0, unblanked 1

% Open file to write polygons
fid = fopen(filename, 'w');

% Format 
format1 = ' %.0f'; % position in intergers
format2 = strcat(num2str(dwell_time/0.1), format1, format1, format1, ' \n');

if isempty(findobj('Title', 'Mask'))
    ax = gca;
    title(ax, 'Mask');
end
axis('equal');   
hold on

nholes = floor(structure_radius/lattice_param);
lattice_param_x = lattice_param;
lattice_param_y = lattice_param*sin(pi/3);

n_passes = 1;
n_points = 0; %total number of points 
str_point = 'n_points   ';

% print stream file heading
fprintf(fid, 'S16 \n');
fprintf(fid, '1      \n');
fprintf(fid, '%s \n', str_point);

for j = -2*nholes:2*nholes
    for i = -(2*nholes+mod(j,2)/2):(2*nholes+mod(j,2)/2)
        if i^2+(j*sin(pi/3))^2<=(structure_radius)^2/lattice_param^2
            % Create points
            [c, cbeam, total_points] = PolygonFun.polygoncircles_stream(lattice_param_x*i, lattice_param_y*j, ...
                                                                 radius, w_beam, hollow);
            n_points = n_points+total_points;
            
            % Draw lattice in matlab for verification 
            rectangle('Position',[lattice_param_x*i,lattice_param_y*j, 2*radius, radius],'Curvature',[1 1]);

%         % Write points into stream file
        fprintf(fid, format2, [c/resolution; cbeam]);
        end
    end
end

fprintf('total points: %d \n',n_points);

 % rewrite the heading with no. of points
frewind(fid)

fprintf(fid, 'S16 \n');    
fprintf(fid, '1      \n');
 
pad_str = repmat(' ',1,11-length(num2str(n_points)));

fprintf(fid, '%s%s \n',num2str(n_points),pad_str);
fclose(fid);

hold off
  
end