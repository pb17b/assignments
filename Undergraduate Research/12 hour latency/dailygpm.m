close all
clear all
format shortg

load nwfl1.txt;
load swfl1.txt;
load sfl1.txt;
load srvr1.txt;
load stjrvr1.txt;

%plot(qng)

%%%%%Date Time y m d %%
t1=datetime(2000,6,1);
t2=datetime(2020,5,15);
t=t1:t2;
y=year(t);
m=month(t);
n=day(t);
% %%%%%%%%%%%%

nwfl=[y' m' n' nwfl1];
swfl=[y' m' n' swfl1];
srvr=[y' m' n' srvr1];
sfl=[y' m' n' sfl1];
stjrvr=[y' m' n' stjrvr1];

clim_p1=zeros(365,1);
clim_p2=zeros(365,1);
clim_p3=zeros(365,1);
clim_p4=zeros(365,1);
clim_p5=zeros(365,1);

stYr=2001;
edYr=2019;

for i=stYr:edYr
                vaM1=nwfl(find(nwfl(:,1)==i),:);
                vaM2=swfl(find(swfl(:,1)==i),:);
                vaM3=srvr(find(srvr(:,1)==i),:);
                vaM4=sfl(find(sfl(:,1)==i),:);
                vaM5=stjrvr(find(stjrvr(:,1)==i),:);

                svaM1=size(vaM1);
                if svaM1(1,1) >= 366 % leap year
                        N1=vaM1(1:365,:);
                        N2=vaM2(1:365,:);
                        N3=vaM3(1:365,:);
                        N4=vaM4(1:365,:);
                        N5=vaM5(1:365,:);
                else
                        N1=vaM1;
                        N2=vaM2;
                        N3=vaM3;
                        N4=vaM4;
                        N5=vaM5;
                end
                clim_p1=clim_p1+N1(:,4);
                clim_p2=clim_p2+N2(:,4);
                clim_p3=clim_p3+N3(:,4);
                clim_p4=clim_p4+N4(:,4);
                clim_p5=clim_p5+N5(:,4);
end

clim_p1=clim_p1/(edYr-stYr+1);
clim_p2=clim_p2/(edYr-stYr+1);
clim_p3=clim_p3/(edYr-stYr+1);
clim_p4=clim_p4/(edYr-stYr+1);
clim_p5=clim_p5/(edYr-stYr+1);

clim_pa1=clim_p1-mean(clim_p1)
clim_pa2=clim_p2-mean(clim_p2)
clim_pa3=clim_p3-mean(clim_p3)
clim_pa4=clim_p4-mean(clim_p4)
clim_pa5=clim_p5-mean(clim_p5)


% %%%%%%%%%%%%%%%%%%

clim_m1=zeros(365,1);
clim_m2=zeros(365,1);
clim_m3=zeros(365,1);
clim_m4=zeros(365,1);
clim_m5=zeros(365,1);

cnwfl=nanmean(nwfl(:,4));
cswfl=nanmean(swfl(:,4));
csrvr=nanmean(srvr(:,4));
csfl=nanmean(sfl(:,4));
cstjrvr=nanmean(stjrvr(:,4));

%%Computation of cumulative anomalies starts here %
anwfl=nwfl(:,4)-cnwfl;
aswfl=swfl(:,4)-cswfl;
asrvr=srvr(:,4)-csrvr;
asfl=sfl(:,4)-csfl;
astjrvr=stjrvr(:,4)-cstjrvr;

pnwfl=[y' m' n' anwfl];
pswfl=[y' m' n' aswfl];
psrvr=[y' m' n' asrvr];
psfl=[y' m' n' asfl];
pstjrvr=[y' m' n' astjrvr];

at_nwfl=[];
at_swfl=[];
at_srvr=[];
at_sfl=[];
at_stjrvr=[];

for i=stYr:edYr
                vaM1=pnwfl(find(pnwfl(:,1)==i),:);
                vaM2=pswfl(find(pswfl(:,1)==i),:);
                vaM3=psrvr(find(psrvr(:,1)==i),:);
                vaM4=psfl(find(psfl(:,1)==i),:);
                vaM5=pstjrvr(find(pstjrvr(:,1)==i),:);

                svaM1=size(vaM1);
                if svaM1(1,1) >= 366 % leap year
                        M1=vaM1(1:365,:);
                        M2=vaM2(1:365,:);
                        M3=vaM3(1:365,:);
                        M4=vaM4(1:365,:);
                        M5=vaM5(1:365,:);
                else
                        M1=vaM1;
                        M2=vaM2;
                        M3=vaM3;
                        M4=vaM4;
                        M5=vaM5;
                end
                clim_m1=clim_m1+M1(:,4);
                clim_m2=clim_m2+M2(:,4);
                clim_m3=clim_m3+M3(:,4);
                clim_m4=clim_m4+M4(:,4);
                clim_m5=clim_m5+M5(:,4);
% %%%%Horizontal Catination of Preciptation orginal data %%% A365x42 Matrix
                if i == stYr
                        at_nwfl=horzcat(at_nwfl,M1);
                        at_swfl=horzcat(at_swfl,M2);
                        at_srvr=horzcat(at_srvr,M3);
                        at_sfl=horzcat(at_sfl,M4);
                        at_stjrvr=horzcat(at_stjrvr,M5);
                else
                        at_nwfl=horzcat(at_nwfl,M1(:,4));
                        at_swfl=horzcat(at_swfl,M2(:,4));
                        at_srvr=horzcat(at_srvr,M3(:,4));
                        at_sfl=horzcat(at_sfl,M4(:,4));
                        at_stjrvr=horzcat(at_stjrvr,M5(:,4));
                end


end

clim_m1=clim_m1/(edYr-stYr+1);
clim_m2=clim_m2/(edYr-stYr+1);
clim_m3=clim_m3/(edYr-stYr+1);
clim_m4=clim_m4/(edYr-stYr+1);
clim_m5=clim_m5/(edYr-stYr+1);

cum_anwfl=cumsum(at_nwfl,'omitnan');
cum_aswfl=cumsum(at_swfl,'omitnan');
cum_asrvr=cumsum(at_srvr,'omitnan');
cum_asfl=cumsum(at_sfl,'omitnan');
cum_astjrvr=cumsum(at_stjrvr,'omitnan');


%%%Onset and demise of yearly Cumulative anomalies %%%%
yr=2001:2019;
%figure('unit','normalized','position',[.03 .03 .80 .90]);
x=1:365;
j=1;
for i=4:size(cum_anwfl,2)
B=cum_anwfl(:,i);
%%%%% Choosing Onset and Demise after 130 days%
        intmin(j)=9.99e+8;
        for ii=130:size(B,1)-93
                if( B(ii) < intmin(j) )
                  intmin(j)=B(ii);
                  xmin=ii+1;
                end
        end
        intmax(j)=-9.99e+8;
%%%%Restriction in Demise date between Onset and 300 days
        for ii=xmin:size(B,1)-65
                if( B(ii) > intmax(j) )
                  intmax(j)=B(ii);
                  xmax=ii+1;
                end
        end

n1_OD(j) = xmin;
n1_DD(j) = xmax;
j=j+1;
end
clear B xmax xmin;
%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1;
for i=4:size(cum_aswfl,2)
B=cum_aswfl(:,i);
%%%%% Choosing Onset and Demise after 130 days%
        intmin(j)=9.99e+8;
        for ii=130:size(B,1)-93
                if( B(ii) < intmin(j) )
                  intmin(j)=B(ii);
                  xmin=ii+1;
                end
        end
        intmax(j)=-9.99e+8;
%%%%Restriction in Demise date between Onset and 300 days
        for ii=xmin:size(B,1)-65
                if( B(ii) > intmax(j) )
                  intmax(j)=B(ii);
                  xmax=ii+1;
                end
        end 

n2_OD(j) = xmin;
n2_DD(j) = xmax;
j=j+1;
end
clear B xmax xmin;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1;
for i=4:size(cum_asrvr,2)
B=cum_asrvr(:,i);
%%%%% Choosing Onset and Demise after 130 days%
        intmin(j)=9.99e+8;
        for ii=130:size(B,1)-93
                if( B(ii) < intmin(j) )
                  intmin(j)=B(ii);
                  xmin=ii+1;
                end
        end
        intmax(j)=-9.99e+8;
%%%%Restriction in Demise date between Onset and 300 days
        for ii=xmin:size(B,1)-65
                if( B(ii) > intmax(j) )
                  intmax(j)=B(ii);
                  xmax=ii+1;
                end
        end

n3_OD(j) = xmin;
n3_DD(j) = xmax;
j=j+1;
end
clear B xmax xmin;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1;
for i=4:size(cum_asfl,2)
B=cum_asfl(:,i);
%%%%% Choosing Onset and Demise after 130 days%
        intmin(j)=9.99e+8;
        for ii=130:size(B,1)-93
                if( B(ii) < intmin(j) )
                  intmin(j)=B(ii);
                  xmin=ii+1;
                end
        end
        intmax(j)=-9.99e+8;
%%%%Restriction in Demise date between Onset and 300 days
        for ii=xmin:size(B,1)-65
                if( B(ii) > intmax(j) )
                  intmax(j)=B(ii);
                  xmax=ii+1;
                end
        end

n4_OD(j) = xmin;
n4_DD(j) = xmax;
j=j+1;
end
clear B xmax xmin;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1;
for i=4:size(cum_astjrvr,2)
B=cum_astjrvr(:,i);
%%%%% Choosing Onset and Demise after 130 days%
        intmin(j)=9.99e+8;
        for ii=130:size(B,1)-93
                if( B(ii) < intmin(j) )
                  intmin(j)=B(ii);
                  xmin=ii+1;
                end
        end
        intmax(j)=-9.99e+8;
%%%%Restriction in Demise date between Onset and 300 days
        for ii=xmin:size(B,1)-65
                if( B(ii) > intmax(j) )
                  intmax(j)=B(ii);
                  xmax=ii+1;
                end
        end

n5_OD(j) = xmin;
n5_DD(j) = xmax;
j=j+1;
end
clear B xmax xmin;


%%%%%CHANGE THE VARIABLE NAMES TO PLOT EACH INDIVIDUAL YEAR, 2001, 2002,ETC.%%%

%%%%%%%%%%PLOTTING%%%%%%%%%%%

figure('unit','normalized','position',[.03 .03 .80 .80]);
subplot(2, 3, 1)
x=1:365;
bar(clim_p1);
ylim([-20 20]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Precipitation','fontsize',15)
hold on
yyaxis right
plot(x,cumsum(clim_pa1),'LineWidth',2,'color','r');
%datetick('x','ddmmmyyyy','keepticks')
ylim([-400 400]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Daily Cumulative Anomaly','fontsize',15)
title('(a) NWFL');
%    Putting line dots and dates %%%%
yL = get(gca,'YLim');
%line([xx(49) xx(49)],yL,'Color','k','LineWidth',0.5);
%line([xx(174) xx(174)],yL,'Color','k','LineWidth',0.5);
%plot(xx(49),215,'r.','MarkerSize',20)
%plot(xx(174),-315,'r.','MarkerSize',20)
right_color = [1 0 0];
ax =gca;
ax.YColor = right_color;





subplot(2, 3, 2)
x=1:365;
bar(clim_p2);
ylim([-20 20]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Precipitation','fontsize',15)
hold on
yyaxis right
plot(x,cumsum(clim_pa2),'LineWidth',2,'color','r');
%datetick('x','ddmmmyyyy','keepticks')
ylim([-400 400]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Daily Cumulative Anomaly','fontsize',15)
title('(b) SWFL');
%    Putting line dots and dates %%%%
yL = get(gca,'YLim');
%line([xx(49) xx(49)],yL,'Color','k','LineWidth',0.5);
%line([xx(174) xx(174)],yL,'Color','k','LineWidth',0.5);
%plot(xx(49),215,'r.','MarkerSize',20)
%plot(xx(174),-315,'r.','MarkerSize',20)
right_color = [1 0 0];
ax =gca;
ax.YColor = right_color;






subplot(2, 3, 3)
x=1:365;
bar(clim_p3);
ylim([-20 20]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Precipitation','fontsize',15)
hold on
yyaxis right
plot(x,cumsum(clim_pa3),'LineWidth',2,'color','r');
%datetick('x','ddmmmyyyy','keepticks')
ylim([-400 400]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Daily Cumulative Anomaly','fontsize',15)
title('(c) SRVR');
%    Putting line dots and dates %%%%
yL = get(gca,'YLim');
%line([xx(49) xx(49)],yL,'Color','k','LineWidth',0.5);
%line([xx(174) xx(174)],yL,'Color','k','LineWidth',0.5);
%plot(xx(49),215,'r.','MarkerSize',20)
%plot(xx(174),-315,'r.','MarkerSize',20)
right_color = [1 0 0];
ax =gca;
ax.YColor = right_color;



subplot(2, 3, 4)
x=1:365;
bar(clim_p4);
ylim([-20 20]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Precipitation','fontsize',15)
hold on
yyaxis right
plot(x,cumsum(clim_pa4),'LineWidth',2,'color','r');
%datetick('x','ddmmmyyyy','keepticks')
ylim([-400 400]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Daily Cumulative Anomaly','fontsize',15)
title('(d) SFL');
%    Putting line dots and dates %%%%
yL = get(gca,'YLim');
%line([xx(49) xx(49)],yL,'Color','k','LineWidth',0.5);
%line([xx(174) xx(174)],yL,'Color','k','LineWidth',0.5);
%plot(xx(49),215,'r.','MarkerSize',20)
%plot(xx(174),-315,'r.','MarkerSize',20)
right_color = [1 0 0];
ax =gca;
ax.YColor = right_color;









subplot(2, 3, 5)
x=1:365;
bar(clim_p5);
ylim([-20 20]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Precipitation','fontsize',15)
hold on
yyaxis right
plot(x,cumsum(clim_pa5),'LineWidth',2,'color','r');
%datetick('x','ddmmmyyyy','keepticks')
ylim([-400 400]);
set(gca,'FontSize',15)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Daily Cumulative Anomaly','fontsize',15)
title('(e) STJRVR');
%    Putting line dots and dates %%%%
yL = get(gca,'YLim');
%line([xx(49) xx(49)],yL,'Color','k','LineWidth',0.5);
%line([xx(174) xx(174)],yL,'Color','k','LineWidth',0.5);
%plot(xx(49),215,'r.','MarkerSize',20)
%plot(xx(174),-315,'r.','MarkerSize',20)
right_color = [1 0 0];
ax =gca;
ax.YColor = right_color;

set(gcf,'color','w')
