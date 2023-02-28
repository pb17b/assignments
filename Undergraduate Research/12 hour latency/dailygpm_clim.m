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
                clim_p3=clim_p3+N2(:,4);
                clim_p4=clim_p4+N3(:,4);
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


%%%Onset and demise of yearly Cumulative anomalies %%%%
yr=2001:2019;
%figure('unit','normalized','position',[.03 .03 .80 .90]);
x=1:365;
j=1;
for i=1:1
B=cumsum(clim_pa1);
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
for i=1:1
B=cumsum(clim_pa2);
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
for i=1:1
B=cumsum(clim_pa3);
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
for i=1:1
B=cumsum(clim_pa4);
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
%5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1;
for i=1:1
B=cumsum(clim_pa5);
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
ylim([-300 300]);
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
ylim([-300 300]);
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
ylim([-300 300]);
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
ylim([-300 300]);
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
ylim([-300 300]);
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
