function sample_id_holes(position, radius, nvertex, nholes, filename, show)
% Generates holes to determine ID of Sample
% For Instance One Hole means Sample P1 (for GaAsp)

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

for i = 1:nholes
        % Create polygons
        c = PolygonFun.polygoncircles(position(1)+3*(i-1)*radius, position(2), radius, nvertex);
        % Draw lattice in matlab for verification
        if show,
            rectangle('Position',[position, radius, radius],'Curvature',[1 1]);
        end
        
        % Write polygons to file
        fprintf(fid, 'polygon -! ');
        fprintf(fid, [format2 '\n'], c);        
end
    
set(ax, 'DataAspectRatio', [1 1 1]) 

hold off
  
fclose(fid);

end