%load in each dataset at only 0000UTC and every 3rd point starting from
%90N,0E. size of matrix should be 160x81x14610
sst = ncread('sst_79-18.nc','sst',[1 1 1],[Inf Inf Inf],[3 3 4]);
mslp = ncread('mslp_79-18.nc','msl',[1 1 1],[Inf Inf Inf],[3 3 4]);
lon = ncread('mslp_79-18.nc','longitude');
lat = ncread('mslp_79-18.nc','latitude');
%lon2 = lon(1:3:480);
%lat2 = lat(1:3:241);



%REMOVE SEASONAL CYCLE AND DETREND
%1979-2018; 39 years; leap years are 1980, 1984, 1988, 1992, 1996, 2000, 2004, 2008, 2012 and 2016
%reformat
mslp_reformat = zeros(160,81,40,366);
sst_reformat = zeros(160,81,40,366);
b = 1;
for n = 1:40 %start in 1979
    if rem(n+2,4) > 0 %i.e. if not a leap year 
        mslp_reformat(:,:,n,1:59) = mslp(:,:,b:b+58);
        mslp_reformat(:,:,n,60) = NaN;
        mslp_reformat(:,:,n,61:366) = mslp(:,:,b+59:b+364);
        sst_reformat(:,:,n,1:59) = sst(:,:,b:b+58);
        sst_reformat(:,:,n,237:240) = NaN;
        sst_reformat(:,:,n,61:366) = sst(:,:,b+59:b+364);
        b = b+365;
    else %i.e. if a leap year
        mslp_reformat(:,:,n,1:366) = mslp(:,:,b:b+365);
        sst_reformat(:,:,n,1:366) = sst(:,:,b:b+365);
        b = b+366;
    end
end
    
%calculate long term mean on each calendar day at specific time
dailymean_mslp = zeros(160,81,366);
dailymean_sst = zeros(160,81,366);
for n = 1:366
    a = squeeze(mslp_reformat(:,:,:,n));
    dailymean_mslp(:,:,n) = nanmean(a,3);
    b = squeeze(sst_reformat(:,:,:,n));
    dailymean_sst(:,:,n) = nanmean(b,3);
end
%remove long term mean
mslp_annualcycleremoved = zeros(160,81,40,366);
sst_annualcycleremoved = zeros(160,81,40,366);
for i = 1:160
    for j = 1:81
        for n = 1:40
            for nn = 1:366
                mslp_annualcycleremoved(i,j,n,nn) = mslp_reformat(i,j,n,nn) - dailymean_mslp(i,j,nn);
                sst_annualcycleremoved(i,j,n,nn) = sst_reformat(i,j,n,nn) - dailymean_sst(i,j,nn);
            end
        end
    end
end
%reformat back
mslp_reformatback = zeros(160,81,14610);
sst_reformatback = zeros(160,81,14610);
b = 1;
for n = 1:40%start in 1979
    if rem(n+2,4) > 0
        mslp_reformatback(:,:,b:b+58) = mslp_annualcycleremoved(:,:,n,1:59);
        mslp_reformatback(:,:,b+59:b+364) = mslp_annualcycleremoved(:,:,n,61:366);
        sst_reformatback(:,:,b:b+58) = sst_annualcycleremoved(:,:,n,1:59);
        sst_reformatback(:,:,b+59:b+364) = sst_annualcycleremoved(:,:,n,61:366);
        b = b+365;
    else
        mslp_reformatback(:,:,b:b+365) = mslp_annualcycleremoved(:,:,n,:);
        sst_reformatback(:,:,b:b+365) = sst_annualcycleremoved(:,:,n,:);
        b = b+366;
    end
end
%detrend
mslp_detrended = zeros(160,81,14610);
sst_detrended = zeros(160,81,14610);
for i = 1:160
    for j = 1:81
        mslp_detrended(i,j,:) = detrend(squeeze(mslp_reformatback(i,j,:)));
        sst_detrended(i,j,:) = detrend(squeeze(sst_reformatback(i,j,:)));
    end
end

%---------------------------------------------------------------

%ISOLATING DEC, FEB, AND JAN MONTHS 
%90x40=3600 cant use the very first year b/c no dec from year before. so 
%minus 59 from total. plus 10 leap year days total. 35320 b/c leaving out
%dec 2018.
months = zeros(160,81,3520);
%1979 and 1980
months(:,:,1:91) = mslp_reformatback(:,:,335:425);
c = 91;
d = 425;
for n = 1:38
    %leap year
    if rem(n,4) == 0
        months(:,:,c+1:c+91) = mslp_reformatback(:,:,d+276:d+366);
        c = c + 91; d = d + 366;
    else
        %not a leap year
        months(:,:,c+1:c+90) = mslp_reformatback(:,:,d+276:d+365);
        c = c + 90; d = d + 365;
    end
end



%CONVERTING INTO MONTHLY MEAN VALUES FOR MSLP
%need matrix to be 160x81x117 so loop through 117 times
%rem 1 is dec, 2 is jan, 0 is feb, but feb has two conditions
monthly = zeros(160,81,117);
e = 1;
for n = 1:117
    if rem(n,3) == 1
        monthly(:,:,n) = nanmean(months(:,:,e:e+30),3);
        e = e + 31;
    elseif rem(n,3) == 2
        monthly(:,:,n) = nanmean(months(:,:,e:e+30),3);
        e = e + 31;
    elseif rem(n,3) == 0 && rem(n-3,12) > 0 
        monthly(:,:,n) = nanmean(months(:,:,e:e+27),3);
        e = e + 28;
    elseif rem(n,3) == 0 && rem(n-3,12) == 0
        monthly(:,:,n) = nanmean(months(:,:,e:e+28),3);
        e = e + 29;
    end
end

%EOF ANALYSIS ON THE DJF MONTHLY MEANS
lon2 = lon(1:3:480);
lat2 = lat(1:3:241);
mslpeof = monthly(:,1:32,:);
for n = 1:160
    for nn = 1:32
        for m = 1:117
            mslpeof(n,nn,m) = mslpeof(n,nn,m)*cosd(lat2(nn));
        end
    end
end

mslpeof2 = reshape(mslpeof,[5120,117]);
%covariance
mslpeof_covariance = mslpeof2*mslpeof2.';

%using eigenvalue function 'eigs'
[C,L] = eigs(mslpeof_covariance,10); %the first 2 eigenvalues

eigenvalues = diag(L)/sum(diag(L));
%plotting the first 10 eigenvalues
figure(2),
plot(eigenvalues,'k+');

%principal component calculation (first two components)
principle_comp = C(:,1).'*mslpeof2;
principle_comp_2 = C(:,2).'*mslpeof2;

pcomp1 = zeros(39,1);
pcomp2 = zeros(39,1);
g = 1;
for n = 1:39
    pcomp1(n,1) = (principle_comp(g)*principle_comp(g+1)*principle_comp(g+2))/3;
    pcomp2(n,1) = (principle_comp_2(g)*principle_comp_2(g+1)*principle_comp_2(g+2))/3;
    g = g + 3;
end


year = zeros(39,1);
h = 1;
for n = 1979:2017
    year(h,1) = n;
    h = h + 1;
end

figure(3),
subplot(2,1,1)
plot(year,pcomp1);
subplot(2,1,2);
plot(year,pcomp2);


leadmode = C(:,1);
patterns1 = reshape(leadmode,[160 32]);
leadmode2 = C(:,2);
patterns2 = reshape(leadmode2,[160 32]);

figure(4),
subplot(2,1,1);
contour(lon2,lat2(1:32),100*patterns1',-1.5:0.5:1.5); colorbar;
subplot(2,1,2);
contour(lon2,lat2(1:32),100*patterns2',-1.5:0.5:1.5); colorbar;

%-------------------------------------------------------------------

%PART2 FOR MSLP

comptop = zeros(160,32);
compbot = zeros(160,32);
for n = 1:117
    if principle_comp(1,n) > 4.1e3
        comptop = comptop + monthly(:,1:32,n);
    end
    if principle_comp(1,n) < 4.1e3
        compbot = compbot + monthly(:,1:32,n);
    end
end

figure(5),
subplot (2,1,1);
pcolor(lon2,lat2(1:32),comptop'); shading flat; colorbar;
subplot(2,1,2);
pcolor(lon2,lat2(1:32),compbot'); shading flat; colorbar;


%--------------------------------------------------------------


%PART2 BUT WITH SST ANOMALIES

%CAN IGNORE EVERYTING UP TO LINE 327

months2 = zeros(160,81,3520);
%1979 and 1980
months2(:,:,1:91) = sst_reformatback(:,:,335:425);
c = 91;
d = 425;
for n = 1:38
    %leap year
    if rem(n,4) == 0
        months2(:,:,c+1:c+91) = sst_reformatback(:,:,d+276:d+366);
        c = c + 91; d = d + 366;
    else
        %not a leap year
        months2(:,:,c+1:c+90) = sst_reformatback(:,:,d+276:d+365);
        c = c + 90; d = d + 365;
    end
end

%CONVERTING INTO MONTHLY MEAN VALUES FOR SST
%need matrix to be 160x81x117 so loop through 117 times
%rem 1 is dec, 2 is jan, 0 is feb, but feb has two conditions
monthly2 = zeros(160,81,117);
e = 1;
for n = 1:117
    if rem(n,3) == 1
        monthly2(:,:,n) = nanmean(months2(:,:,e:e+30),3);
        e = e + 31;
    elseif rem(n,3) == 2
        monthly2(:,:,n) = nanmean(months2(:,:,e:e+30),3);
        e = e + 31;
    elseif rem(n,3) == 0 && rem(n-3,12) > 0 
        monthly2(:,:,n) = nanmean(months2(:,:,e:e+27),3);
        e = e + 28;
    elseif rem(n,3) == 0 && rem(n-3,12) == 0
        monthly2(:,:,n) = nanmean(months2(:,:,e:e+28),3);
        e = e + 29;
    end
end

%EOF ANALYSIS ON THE DJF MONTHLY MEANS
lon2 = lon(1:3:480);
lat2 = lat(1:3:241);
mslpeof_sst = monthly2(:,1:32,:);
for n = 1:160
    for nn = 1:32
        for m = 1:117
            mslpeof_sst(n,nn,m) = mslpeof_sst(n,nn,m)*cosd(lat2(nn));
        end
    end
end


mslpeof2_sst = reshape(mslpeof_sst,[5120,117]);
%covariance
mslpeof_covariance2 = mslpeof2_sst*mslpeof2_sst.';

%---------------------------------------------------------------------
%NaN issue is right after here
%---------------------------------------------------------------------

%using eigenvalue function 'eigs'
[C,L] = eigs(mslpeof_covariance2,10); %the first 2 eigenvalues

eigenvalues2 = diag(L)/sum(diag(L));
%plotting the first 10 eigenvalues
figure(6),
plot(eigenvalues2,'k+');

%principal component calculation (first two components)
principle_comp_sst = C(:,1).'*mslpeof2_sst;
principle_comp_2_sst = C(:,2).'*mslpeof2_sst;

pcomp1_sst = zeros(39,1);
pcomp2_sst = zeros(39,1);
g = 1;
for n = 1:39
    pcomp1_sst(n,1) = (principle_comp_sst(g)*principle_comp_sst(g+1)*principle_comp_sst(g+2))/3;
    pcomp2_sst(n,1) = (principle_comp_2_sst(g)*principle_comp_2_sst(g+1)*principle_comp_2_sst(g+2))/3;
    g = g + 3;
end


%year = zeros(39,1);
%h = 1;
%for n = 1979:2017
%    year(h,1) = n;
%    h = h + 1;
%end

figure(7),
subplot(2,1,1)
plot(year,pcomp1_sst);
subplot(2,1,2);
plot(year,pcomp2_sst);


leadmode_sst = C(:,1);
patterns1_sst = reshape(leadmode_sst,[160 32]);
leadmode2_sst = C(:,2);
patterns2_sst = reshape(leadmode2_sst,[160 32]);

figure(8),
subplot(2,1,1);
contour(lon2,lat2(1:32),100*patterns1_sst',-1.5:0.5:1.5); colorbar;
subplot(2,1,2);
contour(lon2,lat2(1:32),100*patterns2_sst',-1.5:0.5:1.5); colorbar;

comptop2_sst = zeros(160,32);
compbot2_sst = zeros(160,32);
for n = 1:117
    if principle_comp(1,n) > 4.1e3
        comptop2_sst = comptop + monthly2(:,1:32,n);
    end
    if principle_comp(1,n) < 4.1e3
        compbot2_sst = compbot + monthly2(:,1:32,n);
    end
end

figure(9),
subplot (2,1,1);
pcolor(lon2,lat2(1:32),comptop2_sst'); shading flat; colorbar;
subplot(2,1,2);
pcolor(lon2,lat2(1:32),compbot2_sst'); shading flat; colorbar;





%for finding the one location where all time steps are NaN
%find(isnan(mslp)==1)