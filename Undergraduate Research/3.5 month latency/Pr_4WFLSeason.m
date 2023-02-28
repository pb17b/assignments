close all;
clear all;
format shortG;
%%%%%Generate Date Time y m d %%
t1=datetime(2000,6,1);
t2=datetime(2020,5,15);
t=t1:t2;
y=year(t);
m=month(t);
n=day(t);

%%%Load files%%%%south florida only right now
load sfl1.txt;

load OD35hr.txt; 

%%%Remove undefined to NaN%%%
sfl=[y' m' n' sfl1];
%%%%%Daily Climatological Rain Computation starts%%%%
stYr=2001;
edYr=2019;

pt_sfl=[];

for i=stYr:edYr
	vaM1=sfl(find(sfl(:,1)==i),:);

	svaM1=size(vaM1);

	if svaM1(1,1) >= 366 % leap year
   		vaMn=vaM1(1:365,:);
	else
   		vaMn=vaM1;
	end
	if i == stYr
		pt_sfl=horzcat(pt_sfl,vaMn);
	else 
		pt_sfl=horzcat(pt_sfl,vaMn(:,4));
	end
end
        %Summer Seasonal Mean %%%%%%Winter already computed with other code#
        n_sm=zeros(19,1)-NaN;
        n_spm=zeros(19,1)-NaN;
        n_sfl=zeros(19,1)-NaN;
	ii=4;
        yn=length(stYr:edYr);
	for i=1:yn
		n_sm(i)=nansum(pt_sfl(OD35hr(i,2):OD35hr(i,3),ii));
        ii=ii+1;
	end
                n_Sum=nanmean(n_sm)


         AA=[n_sfl]
         AA(AA==0)=NaN;
         
        fid = fopen('PrSeason.txt','wt');
        for ii = 1:size(AA,1)
   	 fprintf(fid,'%g\t',AA(ii,:));
   	 fprintf(fid,'\n');
	end
	fclose(fid)
