
slhf06 = ncread('2016-06.nc','slhf');
slhf06 = (slhf06)/(-3600);
sshf06 = ncread('2016-06.nc','sshf');
sshf06 = (sshf06)/(-3600);
slhf12 = ncread('2016-12.nc','slhf');
slhf12 = (slhf12)/(-3600);
sshf12 = ncread('2016-12.nc','sshf');
sshf12 = (sshf12)/(-3600);
longitude06 = ncread('2016-06.nc', 'longitude');
latitude06 = ncread('2016-06.nc', 'latitude');
longitude = ncread('2016-12.nc', 'longitude');
latitude = ncread('2016-12.nc', 'latitude');

%slhf_06 = zeros(1440,721,720);
%slhf_06(:,:,1) = slhf06;

%part 1
meanslhf06 = (mean(slhf06,3));
meansshf06 = (mean(sshf06,3));
meanslhf12 = (mean(slhf12,3));
meansshf12 = (mean(sshf12,3));

%a = 1; b = 1;

%for n = 1:720
%    b = b + 1;
%    slhf06 = ncread('2016-06.nc', 'slhf',[1 1 b],[Inf Inf 1]);
%    slhf_06(:,:,a+1) = slhf06;
    %need to devide each value by 3600, not sure how syntax goes
%    a = a + 1;
%end

%%
figure(1),
subplot(2,1,1);
pcolor(longitude06,latitude06,(meanslhf06)'); shading flat; colorbar;
title('SLHF June');
rectangle('Position',[290,36,5,2]);
xlabel('Longitude');
ylabel('Latitude');
h = colorbar;
ylabel(h, 'Flux (Wm^-2)')
subplot(2,1,2);
pcolor(longitude06,latitude06,(meansshf06)'); shading flat; colorbar;
title('SSHF June');
rectangle('Position',[290,36,5,2]);
xlabel('Longitude');
ylabel('Latitude');
h = colorbar;
ylabel(h, 'Flux (Wm^-2)')
%print(gcf, 'JuneFluxes.png', '-dpng', '-r450')

figure(2),
subplot(2,1,1);
pcolor(longitude,latitude,(meanslhf12)'); shading flat; colorbar;
title('SLHF December');
rectangle('Position',[290,36,5,2]);
xlabel('Longitude');
ylabel('Latitude');
h = colorbar;
ylabel(h, 'Flux (Wm^-2)')
subplot(2,1,2);
pcolor(longitude,latitude,(meansshf12)'); shading flat; colorbar;
title('SSHF December');
rectangle('Position',[290,36,5,2]);
xlabel('Longitude');
ylabel('Latitude');
h = colorbar;
ylabel(h, 'Flux (Wm^-2)')
%print(gcf, 'DecemberFluxes.png', '-dpng', '-r450')






