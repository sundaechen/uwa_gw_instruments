function disk_array_holes(radius, lattice_param, structure_radius, nvertex, nholes, filename, show)
% Generate a square lattice of polygon circles with nvertex points
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

    for j = -nholes:nholes,
    for i = -nholes:nholes,
       if i^2+j^2<=(structure_radius)^2/lattice_param^2
        % Create polygons
        c = PolygonFun.polygoncircles(lattice_param*i, lattice_param*j, radius, nvertex);
        % Draw lattice in matlab for verification
        if show,
            rectangle('Position',[[i, j]*lattice_param radius, radius],'Curvature',[1 1]);
        end
        
        % Write polygons to file
        fprintf(fid, 'polygon -! ');
        fprintf(fid, [format2 '\n'], c);
       end
    end
    end
    
axis('square');    

hold off
  
fclose(fid);

end