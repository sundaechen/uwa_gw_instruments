function hexagon_array_holes(radius, lattice_param, structure_radius, nvertex, nholes, filename, show)
% Generate a hexagon lattice of polygon circles with nvertex points
% and put it in filename with formatting for input in Ledit
% Radius and lattice_param in um

% Open file to write polygons
fid = fopen(filename, 'w');

% Format comma-space
format1 = '%.3f ';
format2 = repmat(format1,1, 2*nvertex);

if isempty(findobj('Title', 'Mask')),
    ax = gca;
    title(ax, 'Mask');
end
hold on

lattice_param_x = lattice_param;
lattice_param_y = lattice_param*sin(pi/3);

for j = -2*nholes:2*nholes
    for i = -(2*nholes+mod(j,2)/2):(2*nholes+mod(j,2)/2)
        if i^2+(j*sin(pi/3))^2<=(structure_radius)^2/lattice_param^2
            % Create polygons
            c = PolygonFun.polygoncircles(lattice_param_x*i, lattice_param_y*j, radius, nvertex);
            % Draw lattice in matlab for verification 
            rectangle('Position',[lattice_param_x*i,lattice_param_y*j, radius, radius],'Curvature',[1 1]);
        

%         % Write polygons to file

        fprintf(fid, 'polygon -! ');
        fprintf(fid, [format2 '\n'], c);
        end
    end
end
 
axis('equal');    

hold off
  
fclose(fid);

end