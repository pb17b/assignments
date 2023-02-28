lon = ncread('sst_79-18.nc','longitude');
lat = ncread('sst_79-18.nc','latitude');
sst_jan = zeros(480,241,4960);
sst = ncread('sst_79-18.nc','sst',[1 1 1],[Inf Inf 124]);
sst_jan(:,:,1:124) = sst;
a = 1;b = 1;

%part 1
%january is 31 days, so 124 time steps to 247
%leap year is out of phase, add or subtract 1 from n
for n = 1:39
    if rem(n+2,4) > 0
        b = b + 1460;
        sst = ncread('sst_79-18.nc', 'sst', [1 1 b],[Inf Inf 124]);
        %n;
        %start = a + 124;
        %done = a +247;
    sst_jan(:,:,a+124:a+247) = sst;
    elseif rem(n+2,4) == 0
        b = b + 1464;
        sst = ncread('sst_79-18.nc','sst', [1 1 b],[Inf Inf 124]);
        %n ;
        %start = a + 124;
        %done = a + 247;
    sst_jan(:,:,a+124:a+247) = sst;
    end
    a = a+124;
end


%part 2
sst_janmean1 = sst_jan(:,:,1:2852) - 273.15;
sst_janmean2 = sst_jan(:,:,3721:4960) - 273.15;

figure(1),
pcolor(lon,lat,mean(sst_janmean1,3)'); shading flat; colorbar; %caxis([260 290]);
hold on;
contour(lon,lat,mean(sst_janmean1,3)',0:3:21,'LineColor','k','ShowText','on');
title('Average January SST 1979-2001');
xlabel('Longitude');
ylabel('Latitude');
y = colorbar;
ylabel(y, 'Temperature(C)')
print(gcf, 'Part2_AvgSSTjan7901.png', '-dpng', '-r450')


figure(2),
pcolor(lon,lat,mean(sst_janmean2,3)'); shading flat; colorbar; %caxis([260 290]);
hold on;
contour(lon,lat,mean(sst_janmean2,3)',0:3:21,'LineColor','k','ShowText','on');
title('Average January SST 2009-2018');
xlabel('Longitude');
ylabel('Latitude');
y = colorbar;
ylabel(y, 'Temperature(C)')
print(gcf, 'Part2_AvgSSTjan0918.png', '-dpng', '-r450')

%The regions where there are SST fronts located have tightly packed
%contours, or strong temperature gradients. These regions are also located on the
%western boundaries. Pretty cool to see the stacking of contours fom
%freezing to warmer temperatures. 


%part 3
R = 6371000;

jangrad = zeros(480,241,4960);
jangrad2 = zeros(480,241,4960);
for n = 1:4960
    for j = 2:240
        for i = 2: 479
            dxSST = sst_jan(i+1,j,n)-sst_jan(i-1,j,n);
            dySST = sst_jan(i,j+1,n)-sst_jan(i,j-1,n);
            dlon = lon(i+1) - lon(i-1);
            dlat = lat(j+1) - lat(j-1);
            dx = R*(dlon)*cosd(dlat)*pi/180;
            dy = R*(dlat)*pi/180;
            %sstdx = dxSST/dx;
            %sstdy = dySST/dy;
            jangrad(i,j,n) = dxSST/dx; 
            jangrad2(i,j,n) = dySST/dy;
            e = e + 1;
        end
    end
end
%sst y and sst x data compared on the same plot for both year sets

sst_jangrad1 = jangrad(:,:,1:2852);
mean_grad1x = mean(sst_jangrad1,3);

sst_jangrad2 = jangrad(:,:,3721:4960);
mean_grad2x = mean(sst_jangrad2,3);

sst_jangrad3 = jangrad2(:,:,1:2852);
mean_grad1y = mean(sst_jangrad3,3);

sst_jangrad4 = jangrad2(:,:,3721:4960);
mean_grad2y = mean(sst_jangrad4,3);

%The plots of SST gradients show the western boundaries and regions where
%SSTT fronts are located very well. For dSST/dx we see that the gradients
%of temperature are almost exclusive to the western boundaries, and for
%dSST/dy we see emphasis on western boundary gradients. It is much easier
%to see the meridional gradients of SST because SSTs vary more so in the
%meridional direction. 

figure(3),
subplot(2,1,1);
pcolor(lon,lat,(mean_grad1x)'); shading flat; colorbar; polarmap(jet); caxis([-1e-5 1e-5]);
%hold on;
%contour(lon,lat,(mean_grad1x)',0:3:21,'LineColor','k','ShowText','on');
title('January Gradient SST/dx 1979-2001');
xlabel('Longitude');
ylabel('Latitude');
y = colorbar;
ylabel(y, 'Temperature(C)');
subplot(2,1,2);
pcolor(lon,lat,(mean_grad2x)'); shading flat; colorbar; polarmap(jet); caxis([-1e-5 1e-5]);
%hold on;
%contour(lon,lat,(mean_grad2x)',0:3:21,'LineColor','k','ShowText','on');
title('January Gradient SST/dx 2009-2018');
xlabel('Longitude');
ylabel('Latitude');
y = colorbar;
ylabel(y, 'Temperature(C)');
print(gcf, 'Part3_JanGradSSTdx.png', '-dpng', '-r450')

figure(4),
subplot(2,1,1);
pcolor(lon,lat,(mean_grad1y)'); shading flat; colorbar; polarmap(jet); caxis([-1e-5 1e-5]);
%hold on;
%contour(lon,lat,(mean_grad1y)',0:3:21,'LineColor','k','ShowText','on');
title('January Gradient SST/dy 1979-2001');
xlabel('Longitude');
ylabel('Latitude');
y = colorbar;
ylabel(y, 'Temperature(C)');
subplot(2,1,2);
pcolor(lon,lat,(mean_grad2y)'); shading flat; colorbar; polarmap(jet); caxis([-1e-5 1e-5]);
%hold on;
%contour(lon,lat,(mean_grad2x)',0:3:21,'LineColor','k','ShowText','on');
title('January Gradient SST/dy 2009-2018');
xlabel('Longitude');
ylabel('Latitude');
y = colorbar;
ylabel(y, 'Temperature(C)');
print(gcf, 'Part3_JanGradSSTdy.png', '-dpng', '-r450')


%part 4
meanpart1 = mean_grad1x - mean_grad2x;
meanpart2 = mean_grad1y - mean_grad2y;


%this plot looks like shit
figure(5),
subplot(2,1,1);
pcolor(lon,lat,(meanpart1)'); shading flat; colorbar; polarmap(jet); caxis([-1e-5 1e-5]);
%hold on;
%contour(lon,lat,mean(jangrad2,3)',0:3:21,'LineColor','k','ShowText','on');
title('Diff b/t January SST/dx Gradient from 79-01 and 09-18');
xlabel('Longitude');
ylabel('Latitude');
y = colorbar;
ylabel(y, 'Temperature(C)');
subplot(2,1,2);
pcolor(lon,lat,(meanpart2)'); shading flat; colorbar; polarmap(jet); caxis([-1e-5 1e-5]);
%hold on;
%contour(lon,lat,mean(jangrad2,3)',0:3:21,'LineColor','k','ShowText','on');
title('Diff b/t January SST/dy Gradient from 79-01 and 09-18');
xlabel('Longitude');
ylabel('Latitude');
y = colorbar;
ylabel(y, 'Temperature(C)');
print(gcf, 'Part4_JanGradientDiffSST.png', '-dpng', '-r450')

%Based on my plot of differences in gradients between each time period I
%can conclude that the western boundaries are once again the location where
%the gradients stick out the most. What this says is that there will be
%more of an atmosperic response in the regions where the difference in
%gradient is located. This means these coastal regions (western boundaries)
%are favorable for more latent and sensible heat release to occur compared
%to other regions, which in turn leads to more storms (baroclinic
%lows/leafs). Of course, the ocean causes an atmospheric response, but it
%is lagged. The illustrations of this assignment just make the regions
%where atmospheric responses to the ocean are clearly visible. 

%Something that is very noticable in all plots is the spatial resolution.
%For each time frame representing 2009-2018 there is a substantial upgrade
%in the overall resolution of each plot of SST gradients and averages. I
%thought this was cool to see. It is most evident in the png file named
%'Part3_JanGradSSTdy.