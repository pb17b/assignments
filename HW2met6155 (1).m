lon = ncread('sst_79-18.nc','longitude');
lat = ncread('sst_79-18.nc','latitude');
sst_nov = zeros(480,241,4800);
sst = ncread('sst_79-18.nc','sst',[1 1 1217],[Inf Inf 120]);
sst_nov(:,:,1:120) = sst;
a = 1;b = 1217;


for n = 1:39
    if rem(n+3,4) > 0
        b = b + 1460;
        sst = ncread('sst_79-18.nc', 'sst', [1 1 b],[Inf Inf 120]);
    sst_nov(:,:,a+120:a+239) = sst;
    elseif rem(n+3,4) == 0
        b = b + 1464;
        sst = ncread('sst_79-18.nc','sst', [1 1 b],[Inf Inf 120]);
    sst_nov(:,:,a+120:a+239) = sst;
    end
    a = a+120;
end


sst_novmean = zeros(480,241,40);
sst_novmean(:,:,1) = mean(sst_nov(:,:,1:120),3);
e = 1;

for n = 2:40
    sst_novmean(:,:,n) = mean(sst_nov(:,:,e+120:e+239),3);
    e = e+120;
end

oni = [0.5;0.1;-0.2;2.2;-1.0;-0.9;-0.3;1.1;1.3;-1.8;-0.2;0.4;1.2;-0.3;0.0;1.0;-1.0;-0.4;2.4;-1.5;-1.5;-0.7;-0.3;1.3;0.4;0.7;-0.6;0.9;-1.5;-0.6;1.4;-1.6;-1.1;0.1;-0.2;0.6;2.6;-0.7;-0.8;0.9];

c = 0; 
d = 0;
sst_onipos = zeros(480,241);
sst_onineg = zeros(480,241);
%need the squeeze to be of function sst_novmean
%need it to be a matrix of 480x241x40 not 480x241x4800

for n = 1:40
    if oni(n,1) > 0.5
        c = c + 1;
        %sst_novmean = sst_novmean + sst_nov(:,:,n);
        sst_onipos = sst_onipos + squeeze(sst_novmean(:,:,n));
        %sst_onipos = sst_onipos + squeeze(sst_nov(:,:,n));
    elseif oni(n,1) < -0.5
        d = d + 1;
        %sst_novmean = sst_novmean + sst_nov(:,:,n);
        sst_onineg = sst_onineg + squeeze(sst_novmean(:,:,n));
        %sst_onineg = sst_onineg + squeeze(sst_nov(:,:,n));
    end 
end

sst_onipos = sst_onipos/c;
sst_onineg = sst_onineg/d;


overallmean = mean(sst_nov,3);
anompos = sst_onipos - overallmean;
anomneg = sst_onineg - overallmean;


figure(1),
subplot(2,1,1);
pcolor(lon,lat,(sst_onipos)'); shading flat; colorbar; caxis([273 303]);
title('Average November SST when ONI > +0.5');
xlabel('Longitude');
ylabel('Latitude');
h = colorbar;
ylabel(h, 'Temperature(K)')
subplot(2,1,2);
pcolor(lon,lat,(sst_onineg)'); shading flat; colorbar; caxis([273 303]);
title('Average November SST when ONI < -0.5');
xlabel('Longitude');
ylabel('Latitude');
h = colorbar;
ylabel(h, 'Temperature(K)')
%setting the plot dimensions for the png before printing and saving
%set(gcf, 'Position', [0 0 1920 1080]);
print(gcf, 'NovemberSSTavg.png', '-dpng', '-r450')

%polarmap is very useful for anomaly plots*********
figure(2),
subplot(2,1,1);
pcolor(lon,lat,(anompos)'); shading flat; colorbar; polarmap(jet); caxis([-2 2])
title('November SST when ONI > +0.5 - Average all Nov (+Anomaly)');
xlabel('Longitude');
ylabel('Latitude');
h = colorbar;
ylabel(h, 'Temperature(K)')
subplot(2,1,2);
pcolor(lon,lat,(anomneg)'); shading flat; colorbar; polarmap(jet); caxis([-2 2])
title('November SST when ONI < -0.5 - Average all Nov (-Anomaly)');
xlabel('Longitude');
ylabel('Latitude');
h = colorbar;
ylabel(h, 'Temperature(K)')
print(gcf, 'NovemberAnomaly.png', '-dpng', '-r450')

