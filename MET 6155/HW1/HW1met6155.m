u = ncread('2017-06.nc', 'u');
v = ncread('2017-06.nc', 'v');
uDec = ncread('2017-12.nc', 'u');
vDec = ncread('2017-12.nc', 'v');
u900Dec = squeeze(uDec(:,:,4,:));
v900Dec = squeeze(vDec(:,:,4,:));
u900 = squeeze(u(:,:,4,:));
v900 = squeeze(v(:,:,4,:));
lon = ncread('2017-06.nc','longitude');
lat = ncread('2017-06.nc','latitude');
lonDec = ncread('2017-12.nc','longitude');
latDec = ncread('2017-12.nc','latitude');
R = 6371000;
Div_June = zeros(480,241,120);
Div_December = zeros(480,241,124);


for n = 1:120
    for j = 2:240
       for i = 2:479
              dU = u900(i+1,j,n)-u900(i-1,j,n);
              dV = v900(i,j+1,n)-v900(i,j-1,n);
              dlon = lon(i+1)-lon(i-1); 
              dlat = lat(j+1)-lat(j-1);
              dx = R*(dlon)*cosd(dlat)*pi/180;
              dy = R*(dlat)*pi/180;
              Div_June(i,j,n) = dU/dx + dV/dy;
             % Umean = mean(Div_June,3);
              %Div_June(i,j,n) = (dU(i,j,n))/(dx(i,j,n)) + (dV(i,j,n))/(dy(i,j,n));
       end
    end
end

for n = 1:124
    for j = 2:240
       for i = 2:479
              dUDec = u900Dec(i+1,j,n)-u900Dec(i-1,j,n);
              dVDec = v900Dec(i,j+1,n)-v900Dec(i,j-1,n);
              dlonDec = lonDec(i+1)-lonDec(i-1); 
              dlatDec = latDec(j+1)-latDec(j-1);
              dxDec = R*(dlonDec)*cosd(dlatDec)*pi/180;
              dyDec = R*(dlatDec)*pi/180;
              Div_December(i,j,n) = dUDec/dxDec + dVDec/dyDec;
             % Umean = mean(Div_June,3);
       end
    end
end

Difference = mean(Div_June,3) - mean(Div_December,3);

pcolor(lon,lat,mean(Div_June,3)'); shading flat; colorbar; caxis([-1e-5 1e-5]);
title('Global Average 900hPa Divergence for June 2017');
xticks([0 60 120 180 240 300 360]);
yticks([-90 -60 -30 0 30 60 90]);
xlabel('Longitude');
ylabel('Latitude');
%xticklabels('0E','60E','120E','180E','240E','300E','360E');

pcolor(lon,lat,mean(Div_December,3)'); shading flat; colorbar; caxis([-1e-5 1e-5]);
title('Global Average 900hPa Divergence for December 2017');
xticks([0 60 120 180 240 300 360]);
yticks([-90 -60 -30 0 30 60 90]);
xlabel('Longitude');
ylabel('Latitude');
%xticklabels('0E','60E','120E','180E','240E','300E','360E');

pcolor(lon,lat,Difference'); shading flat; colorbar; caxis([-1e-5 1e-5]);
title('Global Average 900hPa Div Diff b/t June & December 2017');
xticks([0 60 120 180 240 300 360]);
yticks([-90 -60 -30 0 30 60 90]);
xlabel('Longitude');
ylabel('Latitude');
%xticklabels('0E','60E','120E','180E','240E','300E','360E');



