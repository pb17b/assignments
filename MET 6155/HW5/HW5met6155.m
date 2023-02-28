%loading in the files at every 3rd gridpoint. can change to a better res later
myfile = matfile('ozone900.mat');
ozone_degradedresolution = myfile.ozone900(1:3:320,1:3:160,:);

myfile2 = matfile('temp900.mat');
temp_degradedresolution = myfile2.temp900(1:3:320,1:3:160,:);

%ozone900 - 320x160x21912
%ozone_degradedresolution = myfile.ozone900(100:200,1:10,1:1000);

%changing the lat/lon to match the res of temp and ozone. now 107x64 instead
%of 320x160
lon = myfile.lon;
lat = myfile.lat;
lon2 = lon(1:3:320);
lat2 = lat(1:3:160);


correlation = zeros(107,54);
significance = zeros(107,54);
for i = 1:107
    for j = 1:54
        [R,P] = corrcoef(temp_degradedresolution(i,j,:),ozone_degradedresolution(i,j,:));
        correlation(i,j) = R(2,1);
        significance(i,j) = P(2,1);
        if significance(i,j) > 0.05
            significance(i,j) = NaN;
        %else
        %    significance(i,j) = 1;
        end
    end
end

%instead of using points to plot, plot it as a contour of 1, elseif not
%needed
%contoured 
figure(1),
%plot(lon2,lat2,(significance)'); marker '.';
pcolor(lon2,lat2,(correlation)'); shading flat; colorbar; 
hold on;
%contouring p values less than 0.5
contour(lon2,lat2,(significance)',1,'LineColor','k','ShowText','on');
title('Correlation b/t 900hPa Ozone and Temperature (P<.05 contoured)');
xlabel('Longitude');
ylabel('Latitude');

%Not able to remove the seasonal cycle, but here is my explanation for the
%difference between the two. 

%The correlation coefficients plotted are course, but this is because they
%include the seasonal cycle. If I were to remove them and plot the
%correlation coefficients then you would see more anomalous data points and
%there would be more area where there is less correlation. As for the
%significance or p-value there are some denoted in black contours for the
%data w/o seasonal cycle removed, and I would assume there would be less
%significant values when plotting the dtrended data and perhaps even
%pockets of p-values that persist due to anomalies. 



%detrending
temp_detrend = detrend(temp_degradedresolution);
ozone_detrend = detrend(ozone_degradedresolution);




%seasonal cycle***************
%have given up :(   :/
seasonal_initial = zeros(1,21912);
seasonal_second = zeros(15,1464);
b = 0;
%use b to change the values every loop
%days up to leap year 236
for n = 1:15
    if rem(n,4) > 0 
        seasonal_second(1,1:236) = seasonal_initial(1,b+1:b+236);
        seasonal_second(1,237:240) = nan;
        seasonal_second(1,241:1464) = seasonal_initial(1,b+237:b+1460);
    elseif rem(n,4) == 0
        seasonal_second(1,1:1464) = seasonal_initial(1,b+1:b+1464);
    end
    b=b+1;
end

%calculating daily mean
daily_mean = zeros(1,1464);
for n = 1:15
    daily_mean(n) = seasonal_second(n)/15;
end

%subtracting value from the long term mean
for n = 1:15
    for nn = 1:1464
    end
end

%back from 15x1464 to 1x21912

%once have this, will have a long term mean 1464x1, mean for the given
%timestep is the mean for the 15 years.
% once we have that. can loop through
%n =1:15 and nn = 1:1464. everytime there is a value, subtract the
%corresponding value from the long term mean. 
%last step is to go from 15x1464 back to 1x21912








%lead/lag
%loading in just one lat/lon location with all timesteps
ozone_location = myfile.ozone900(139,98,:);
temp_location = myfile2.temp900(139,98,:);

corrstore= zeros(25,1);
for n = 1:12
    [R,P] = corrcoef(temp_location(:,:,1:21912-n),ozone_location(:,:,n+1:21912)); %lead
    corrstore(13-n,1) = R(2,1);
end
[R,P] = corrcoef(temp_location(:,:,1:21912),ozone_location(:,:,1:21912)); 
corrstore(13,1) = R(2,1);
for n = 1:12
    [R,P] = corrcoef(temp_location(:,:,1+n:21912),ozone_location(:,:,1:21912-n)); %leadcorrelationlagtest = R(2,1);
    corrstore(n+13,1) = R(2,1);
end

figure(2),
plot(corrstore);
title('Lead/Lag Correlation Between the 900hPa Ozone and Temperature', '(19.626N, 155.25E)');
ylabel('Correlation');
%xticks([-3 -2 -1 0 1 2 3]);
xlabel('Days, where day 13 is ozone=temp. (+/- 3days either side)');
%my figure is lead first, then lag. Traditionally it would be lag then
%lead. Just specifying that.

%Explanation for part 2

%The seasonal cycle is not removed so the data is more correlated with
%itself when compared to the data that has the seasonal cycle removed. W/o the seasonal cycle removed
%we see  higher correlations because the values each year don't deviate too
%far from each other. If I had plotted the seasonal cycle removed you would
%see the corerlation fall off pretty hard after the first few time steps
%because the data being used are anomalous. This means that the lead/lag or
%lag/lead depending on which side of 0th index you look at fall off the
%further you get away from the 0th index of 1:21912.




%autocorrelation
autocorrstore = zeros(1,1460);
for n = 1:1460
     [R,P] = corrcoef(temp_location(:,:,1+n:21912),temp_location(:,:,1:21912-n));
    %[R,P] = corrcoef(temp_location(:,:,n),temp_location(:,:,n+1460)); %leadcorrelationlagtest = R(2,1);
    autocorrstore(1,n) = R(2,1);
end
figure(3),
plot(autocorrstore);
title('Autocorrelation out to 365 Days for 900hPa Temperature', '(19.626N, 155.25E)')
xlabel('Days');
ylabel('Correlation');
%fig4 is denoted as fig15 in submission
figure(4),
plot(autocorr(temp_location,'NumLags',1460));
%autocorrelation wouldn't plot again, so I couldn't add title or axis labels 
%plot(autocorr(temp_degradedresolution),'NumLags','1460');


%Explanation for part 3

%W/o removing the seasonal there is an evident correlation for the first
%couple of days and then it falls off, but remains to be correlated because
%each years seasonal temperatures don't vary too much from one another.
%However, the seasonal cycle removed data gets rid of this issue and the
%autocorrelation shows it falling off after a couple of time steps, because
%anomalous data does not affect the outcome of later timesteps far out. For
%example, after ~2 days or 6 timesteps we see the data fall out of
%correlation very quickly





%longitude value 139 is 155.25, lon2 is 47
%latitude value 98 is 19.626, lat2 is b/t 33 and 35








%power spectra
temp_locationsqzd = squeeze(temp_location());
%getting every 0000z value and storing
temp_0000 = zeros(1,5478);
e = 1;
for n = 1:21912
    temp_0000(1,n) = temp_location(:,e);
    e = e + 4;
end
%loop above gives an error because e+4 goes to 21913


t = (0:5478-1)*1;
figure(5),
plot(t,temp_0000);
title('Timeseries for 900hPa Temperature at 0000UTC','(w/o detrending or seasonal cycle removed) (19.626N, 155.25E)');
xlabel('Time (days)');
ylabel('Temperature (K)');


y = fft(temp_0000);
%remove 0Hz component, i.e mean value of signal
%getting rid of the first value
y(1) = [];

n = length(y);
%the coefficients are complex numbers due to i in F series
power = abs(y(1:floor(n/2))).^2;
maxfreq = 1/2;
%gives frequencies that the fft gives associated with the coefficients
freq = ((1:n/2)/(n/2))*maxfreq;

figure(6),
plot(freq,log10(power),'x');
title('Power Spectra Plotted with Frequency on the y-axis (0000UTC)', '(19.626N, 155.25E)');
xlabel('Power (W/day)');
ylabel('Frequency(log distribution)');

period = 1./freq;

figure(7); 
plot(period,log10(power),'x');
title('Power Spectra Plotted with Period on the y-axis (0000UTC)', '(19.626N, 155.25E)');
xlabel('Power (W/day)');
ylabel('Period(log distribution)');

%Explanation part4

%First off, the power spectra plotted timeseries w/o the seasonal cycle
%removed shows the seasonal cycle values pretty well. It basically shows
%the Beta coefficient values that influence the timeseries most. That being
%the 365, 182, and 91 day marks because the seasons occur for ~91 days,
%summer and winter are 182 days apart, and a year cycle is 365 days. With
%the seasonal cycle removed the data doesn't show the 365, 182, and 91
%marks because we have gotten rid of those, and instead we have the
%anomalies plotted. There is less spread along the y-axis.




%Filtering
%Lines 215-233 are not needed for filtering but give a different method
%actual filtering is below this section
%temp_0000 corresponds to 0000z values, 1 timestep per day
temp2_0000 = bandpass(temp_0000,[1/400 1/100],1);
t = (0:5478-1)*1;
y = fft(temp2_0000);
y(1) = [];
n = length(y);
power = abs(y(1:floor(n/2))).^2;
maxfreq = 1/2;
freq = ((1:n/2)/(n/2))*maxfreq;
%figure(7); plot(freq,log10(power),'x');
%title('900hPa Temperature (w/o detrending or seasonal cycle removed','bandpass filtered between a period of 100 and 400 days');

temp3_0000 = bandpass(temp_0000,[1/1000 1/400],1);
t = (0:5478-1)*1;
y = fft(temp3_0000);
y(1) = [];
n = length(y);
power = abs(y(1:floor(n/2))).^2;
maxfreq = 1/2;
freq = ((1:n/2)/(n/2))*maxfreq;
%figure(8); plot(freq,log10(power),'x');
%title('900hPa Temperature (w/o detrending or seasonal cycle removed','bandpass filtered between a period of 400 and 1000 days');



%tempsqzd = squeeze(temp_degradedresolution(30,20,1:4:21912));
%bandpass filtering 
%didnt need to squeeze couldve used temp_0000
temp2_0000 = bandpass(temp_0000,[1/400 1/100],1);
temp3_0000 = bandpass(temp_0000,[1/1000 1/400],1);
figure(8),
plot(t,temp2_0000);
title('Bandpass Filtered Timeseries 1/400 1/100', 'for 0000UTC Temp at (155.25E, 19.626N)');
xlabel('Days');
ylabel('Frequency');
figure(9),
plot(t,temp3_0000);
title('Bandpass Filtered Timeseries 1/1000 1/400', 'for 0000UTC Temp at (155.25E, 19.626N)');
xlabel('Days');
ylabel('Frequency');

%Explanation part 5

%The only differences that we see here is the filtering out of the 365
%value, or the annual value that shows the contrasting seasons of winter
%and summer. Instead, we see a smoothed out timeseries of the data that
%still includes the seasonal cycle, but is less evident. For the data with
%the seasonal cycle removed we see all of the anomalous values inbetween
%the frequencies selected.

