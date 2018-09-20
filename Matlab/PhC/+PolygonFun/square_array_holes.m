function square_array_holes(position, radius, lattice_param, nvertex, nholes, filename, show)
% Generate a square lattice of polygon circles with nvertex points
% and put it in filename with formatting for input in Ledit
% Radius and lattice_param in µm
% Position is a dimension 2 vector containing the bottom left corner
% coordinates of the lattice
% Show is a boolean for plotting in maltab a figure with the generated
% result. Can be set to 0 because very slow

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

    for j = 1:nholes,
    for i = 1:nholes,
        % Create polygons
        c = PolygonFun.polygoncircles(position(1)+lattice_param*i, position(2)+lattice_param*j, radius, nvertex);
        % Draw lattice in matlab for verification
        if show,
            rectangle('Position',[position+[i, j]*lattice_param radius, radius],'Curvature',[1 1]);
        end
        
        % Write polygons to file
        fprintf(fid, 'polygon -! ');
        fprintf(fid, [format2 '\n'], c);        
    end
    end
    
set(ax, 'DataAspectRatio', [1 1 1]) 

hold off
  
fclose(fid);

end