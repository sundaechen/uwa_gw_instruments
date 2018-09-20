% This code calculate the area and height of the bumps on the FIB milling surface. 
% The input data is the AFM scan results.
    close all
    data = data2;
%% show data in contour plot   
    figure()
    contourf(data)
    daspect([1 1 1])
    colorbar
    title('Raw data')
%% find the base level with hist    
    rdata = reshape(data,1,[]);
    [counts, centers] = hist(rdata,200);
    
    figure()
    bar(centers, counts)
    grid on
    
    depth = centers(counts==max(counts));
     
    disp(['The average depth is; ',num2str(mean2(data))])
    disp(['The depth in most area is; ',num2str(depth)])
       
	[pks,locs,w,p] = findpeaks(counts,centers, 'SortStr','descend');  

%%  remove depth offset 
        data = data-depth; 

%% segmentation with watershed    
    l = watershed(-data,8);
    figure()
    pcolor(l)
    daspect([1 1 1])
    shading flat
    title('Segmentation with watershed')
%% find peaks in each segment    
    BWmax = imregionalmax(data,8);
%     figure()
%     pcolor(BWmax)
%     shading flat
%     daspect([1 1 1])
%     colormap(flipud(gray))
%     title('Peaks')
  
    if max(max(l)) ~= sum(sum(BWmax))
        error('Watershed has different number of regions with imregionalmax!')
    end
%% show select segment
    As =  zeros(1,max(max(l)));
	Ps =  zeros(1,max(max(l)));

    for s = 1:max(max(l))
%         figure(11)
%         pcolor(data.*(l==s));
%         daspect([1 1 1])
%         shading flat
%         colorbar
   %% count area     
%         figure(12)         
%         pcolor((l==s).*(data>3*w(1)))
%         shading flat
%         colormap(flipud(gray))
%         daspect([1 1 1])
%         caxis([0 1])
        
        As(s) = sum(sum((l==s).*(data>3*w(1))));
        Ps(s) = data((l==s)&BWmax);
        
%         disp(['Segment ', num2str(s), ':  area: ', num2str(As(s)), '  height: ', num2str(Ps(s))])
        
%         pause
%          close all              
    end
%% results    
    [areacounts, areacenters]=histcounts(As,100);
    [peakcounts, peakcenters]=histcounts(Ps,100);
    
%     figure()
%     plot(areacenters, areacounts)
%     set(gca,'YScale','log');
%     title('Area distribution')
%     
%     figure()
%     plot(peakcenters, peakcounts)
%     set(gca,'YScale','log');
%     title('Height distribution')
    
    R = zeros(length(peakcounts),length(areacounts));
    for i = 1:length(areacounts)
        for j = 1:length(peakcounts)
            R(j,i)=sum( (As>0 & As>=areacenters(i) & As<=areacenters(i+1)) .* (Ps>=peakcenters(j) & Ps<=peakcenters(j+1)));
        end
    end
    sum(sum(R))
   
    figure()
    imagesc(R)%,'InitialMagnification','fit')
    colormap(flipud(gray))
    set(gca,'YDir','normal')
    caxis([0,max(max(R))])
    cmap = flipud(parula(max(max(R))));
    cmap(1,:) = [1,1,1];
    colormap(cmap);
    colorbar
    
    
	ax = gca;
    ax.XTick = linspace(0,size(R,2),6)+0.5;
    ax.XTickLabel = linspace(areacenters(1), areacenters(end),6);
    xlabel('Area (counts)')
    ax.YTick = linspace(0,size(R,1),6)+0.5;
    ax.YTickLabel = linspace(peakcenters(1), peakcenters(end),6);
    ylabel('Height (nm)')
    
