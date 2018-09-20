%% 
%had to change axis for some of the plots because they were inconsistent
%with previous plots, think I fixed all the dificulties with this but not
%neccessarily
%also one section doesn't work becuase I don't have the curve fitting
%toolbox, instead I output a file to mathematica and fit in there
%this is automated except for the setup section, requires the formatting
%from the simulations I modified the code in, will only work for those, also
%it requires that the data is all in a file available to matlab eg the
%current folder, this is where the results will be deposited
%both the simulation code and this code are originaly by Sundae
%setup: always run first
clear

shape = 'hex';
thickness = 75;
%%
list = dir(strcat('SiN2D_t',num2str(thickness),'nm_',shape,'*.txt'));
lattices = [];
radiuses = [];
pks = [];
locs = [];
ws = [];
ps = [];

for i = 1:size(list,1)-3
    name = list(i).name;
    out=regexp(name,'\d+.\d+','match');
    lattices =[lattices; str2num(cell2mat(out(2)))];
    radiuses =[radiuses; str2num(cell2mat(out(3)))];
    tempdata = importdata(list(i).name,',');
    [pk,loc,w,p] = findpeaks(1-tempdata(:,2),tempdata(:,1),...
        'SortStr','descend','WidthReference','halfheight');
    if isempty(pk)
        pk = 0; loc = 0; w = 0; p = 0;
    end
    pks = [pks;pk(1)];
    locs = [locs;loc(1)];
    ws = [ws;w(1)];
    ps = [ps;p(1)];
end

linewidth = table(lattices,radiuses, ws);
writetable(linewidth,strcat(num2str(thickness),'nm ',shape,' linewidth in wavelength.txt'),'Delimiter',',')

% linewidth = [lattices, radiuses, ws];
% save('linewidth in wavelength1.txt','linewidth','-ascii' )

figure()
scatter(radiuses,lattices,10,ws*1000,'filled')
colorbar
colormap('jet')
% colormap(flipud(colormap))
title(strcat(num2str(thickness),'nm',shape,' Linewidth in wavelength (nm)'))
ylabel('Lattice (nm)')
xlabel('Radius (nm)')
grid on

saveas(gca, [strcat('SiN_t',num2str(thickness),'_',shape,'_linewidth.png')])

% square lattice
ratio_area = pi*radiuses.^2./lattices.^2; 
% hexagon lattice
ratio_area = pi*radiuses.^2./(sin(pi/3)*lattices.^2);

figure()
h = histogram(ratio_area,20,'Normalization','probability','BinLimits',[0,1]);
grid on
xlabel('Ratio of hole area')
title('Histogram of ratio of hole area')
saveas(gca, [strcat('SiN_t',num2str(thickness),'nm_',shape,'_hole_area_ratio.png')])


figure()
subplot(121), plot(radiuses*1000,ws*1000,'.')
grid on
title('Linewidth in wavelength (nm)')
xlabel('Radius (nm)')
ylabel('Linewidth (nm)')
axis('tight')

subplot(122), plot(lattices*1000,ws*1000,'.')
grid on
title('Linewidth in wavelength (nm)')
xlabel('Lattice (nm)')
ylabel('Linewidth (nm)')
axis('tight')
    
saveas(gca, [strcat('SiN_t',num2str(thickness),'_',shape,'_linewidth_2.png')])
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%run this section for quick checks, shows colourmap of data, looking for
%dark areas which are low tansmission, useful when trying to zoom onto
%interesting areas
data = [];
Lattice = [];
Radius = [];
ref = [];

data=importdata(strcat('SiN2D_t',num2str(thickness),'nm_wavelength1064nm_',shape,'_zoom.txt'));
Lattice = data(1,1:size(data,2)-1);
Radius = data(2:size(data,1),1);
ref = data(2:size(data,1),2:size(data,2));

x1 = min(Radius);
x2 =max(Radius);
y1 =min(Lattice);
y2 = max(Lattice);

radius_step = 1000*(max(Radius)-min(Radius))/(length(Radius)-1);
lattice_step = 1000*(max(Lattice)-min(Lattice))/(length(Lattice)-1);

figure()
pcolor(Radius.',Lattice.',ref.')
shading flat
colorbar

xlabel('Radius (\mum)')
ylabel('Lattice (\mum)')
colormap('hot')
caxis([0,1.02])
title(strcat(num2str(thickness),'nm thick',shape,' SiN 2D PhC ZOOM'))

saveas(gca, [strcat('SiN_t',num2str(thickness),'_',shape,'_transmission.png')])
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data = SiN2Dt50nm';
[radius,lattice,v] = find(ref<0.0001); % find lattice and radius for R>99.99%

values = [];
for i = 1:sum(v)
    values = [values;ref(radius(i),lattice(i))];
end
figure()
scatter(Radius(radius),Lattice(lattice),10*(1-values),values,'filled')
colorbar
colormap('jet')
xlabel('Radius (\mum)')
ylabel('Lattice (\mum)')
grid on  

saveas(gca, [strcat('SiN_t',num2str(thickness),'_',shape,'_reflection_peaks.png')])
%% Fit: 'lattice vs. radius'.
%this section for output to mathematica
MMC=[];
MMC=table(Radius(radius),Lattice(lattice)');
writetable(MMC,strcat(num2str(thickness),'nm_',shape,'_MMC.xls'));
%%
% function [fitresult, gof] = createFit(lattice, radius)
%don't have curve fitting package yet so can't run this section, try to
%copy to uwa computer and run there because they appear to have it, or use
%mathematica for this part only
[xData, yData] = prepareCurveData( Radius(radius), Lattice(lattice)');

% Set up fittype and options.
ft = fittype( 'poly6' );

% Fit model to data.
[f, gof] = fit( xData, yData, ft, 'Normalize', 'off' );

% Plot fit with data.
figure( 'Name', 'Fit lattice vs. radius' );
h = plot(f, xData, yData);
legend( h, 'lattice vs. radius', 'fit 1', 'Location', 'SouthEast' );
% Label axes
xlabel radius
ylabel lattice
grid on

disp(f)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% count tolerance
[radius,lattice,v] = find(ref<0.02); % find lattice and radius for R>98%

n_radius = length(Radius);% -min(radius);
n_lattice = length(Lattice);% -min(lattice);
count_radius = zeros(length(Radius),1);
count_lattice = zeros(length(Lattice),1);

for i = 1:length(radius)
    count_radius(radius(i)) = count_radius(radius(i))+1;
end
    
for i = 1:length(lattice)
    count_lattice(lattice(i)) = count_lattice(lattice(i))+1;
end

figure()
subplot(121), plot(Radius*1000, count_radius*lattice_step,'*-')
grid on
title('Lattice tolerance for R>98%')
xlabel('Radius (nm)')
ylabel('Lattice (nm)')

subplot(122), plot(Lattice*1000, count_lattice*radius_step,'*-')
title('Radius tolerance for R>98%')
xlabel('Lattice (nm)')
ylabel('Radius (nm)')
grid on

saveas(gca, [strcat('SiN_t',num2str(thickness),'nm_',shape,'_tolerance.png')])

%% find linewidth of lattice
pkss = [];
locss = [];
ws = [];
ps = [];

for i = 1:size(ref,1)
    [pks,locs,w,p] = findpeaks(1-ref(i,:),'SortStr','descend');
    if isempty(pks)
        pks = 1; locs = 1; w = 1; p = 1;
    end        
    pkss = [pkss,pks(1)];
    locss = [locss,locs(1)];
    ws = [ws,w(1)];
    ps = [ps,p(1)];
end

figure()
scatter(Radius./Lattice(locss)',ws*1000*(max(Lattice)-min(Lattice))/(length(Lattice)-1),1)
title('Linewidth in lattice (nm)')
xlabel('Ratio of radius over lattice')
ylabel('Linewidth in lattice (nm)')
grid on

saveas(gca, [strcat('SiN_t',num2str(thickness),'nm_',shape,'_lattice_linewidth.png')])
%% find linewidth of radius
pkss = [];
locss = [];
ws = [];
ps = [];

for i = 1:size(ref,2)
    [pks,locs,w,p] = findpeaks(1-ref(:,i),'SortStr','descend');
    if isempty(pks)
        pks = 1; locs = 1; w = 1; p = 1;
    end        
    pkss = [pkss,pks(1)];
    locss = [locss,locs(1)];
    ws = [ws,w(1)];
    ps = [ps,p(1)];
end

figure()
scatter(Radius(locss)./Lattice',ws*1000*(max(Radius)-min(Radius))/(length(Radius)-1),1)
title('Linewidth in radius (nm)')
xlabel('Ratio of radius over lattice')
ylabel('Linewidth in radius (nm)')
grid on

saveas(gca, [strcat('SiN_t',num2str(thickness),'nm_',shape,'_radius_linewidth.png')])
%% plot transmission vs lattice
figure()
grid on
hold on
radius_title ='From left to right Radius (\mum): '; 

radius_p = linspace(1,size(data,2),8);
radius_pxlabel = linspace(x1,x2,8);
for i =2:length(radius_p)-1
     plot(data(:,round(radius_p(i))))
     radius_title = strcat(radius_title, num2str(radius_pxlabel(i),'%0.3f'), ',');
end
xlabel('lattice (\mum)')
ylabel('Transmission')
title(radius_title)
ax = gca;
ax.XTick = linspace(1,size(data,1),9);
ax.XTickLabel = linspace(y1,y2,9);
xlim([1 size(data,1)])
ylim([0 1.02])

saveas(gca, [strcat('SiN_t',num2str(thickness),'nm_',shape,'_transmission_vs_lattice.png')])
%% plot transmission vs radius 
figure()
grid on
hold on
lattice_title ='From left to right lattice (\mum): '; 

lattice_p = linspace(1,size(data,1),8);
lattice_pxlabel = linspace(y1,y2,8);
for i =2:length(lattice_p)-1
     plot(data(round(lattice_p(i)),:))
     lattice_title = strcat(lattice_title, num2str(lattice_pxlabel(i),'%0.3f'), ',');
end
xlabel('radius (\mum)')
ylabel('Transmission')
title(lattice_title)
ax = gca;
ax.XTick = linspace(1,size(data,2),9);
ax.XTickLabel = linspace(x1,x2,9);
xlim([1 size(data,2)])
ylim([0 1.02])

saveas(gca, [strcat('SiN_t',num2str(thickness),'nm_',shape,'_transmission_vs_radius.png')])
