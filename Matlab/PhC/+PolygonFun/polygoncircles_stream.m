function [c, total_points] = polygoncircles_stream(x,y,radius,w_beam,hollow)
%     hollow = 0;
%     x = 0;
%     y = 0;
%     w_beam = 0.133;
%     radius = 0.360-0.5*w_beam;
% fprintf('x:%.3f y:%.3f \n',x,y)
    x = x;
    y = y;
    if hollow == 1
        radius_start = radius - 0.5*w_beam;
    else
        radius_start = 0;
    end

    total_points = 1;
    for l = radius_start : 0.5*w_beam :radius
        total_points = total_points+floor(4*pi*l/w_beam);
    end
%     disp(['total points:', num2str(total_points)])

  % display beam positios for a circle
%     if isempty(findobj('Title', 'Mask')),
%         ax = gca;
%         title(ax, 'Mask');
%     end
%     hold on
%     axis('equal');
%     color = linspace(0,1,total_points);
% 
    %%%
    cx = zeros(total_points,1);
    cy = zeros(total_points,1);

    i = 1;
    cx(i) = x;
    cy(i) = y;

%     scatter(x,y,[],color(i), 'filled')
%     rectangle('Position',[x-0.5*w_beam,y-0.5*w_beam,w_beam,w_beam],'Curvature',[1 1])

    for l = radius_start : 0.5*w_beam :radius
        n_points = floor(4*pi*l/w_beam);
        for j = 0:2*pi/n_points:2*pi-2*pi/n_points
            i = i+1;
            cx(i) = x + l*cos(j);
            cy(i) = y + l*sin(j);
%             rectangle('Position',[cx(i)-0.5*w_beam,cy(i)-0.5*w_beam,w_beam,w_beam],'Curvature',[1 1])
%             scatter(cx(i),cy(i),[],color(i), 'filled')
        end
    end

%     hold off

%     color = linspace(1,10,total_points);
%     scatter(cx,cy,[],color,'filled')
%     axis('equal');   
% 
    c = [cx';cy'];
end
    