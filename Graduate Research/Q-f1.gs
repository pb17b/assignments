'reinit'
'c'


'open /Net/water/abhardwaj/RSM-FL/DailyA/r_pgbF.ctl'
*'open /home/pbeasley/heat/RSM/TandRH/r_pgbF.ctl'
'set lat 24 31'
'set lon 271 281'
'set time 12z01Jan2041 12z31Dec2060'
'define rh2=SPFHprs.1'
'close 1'

'open /home/pbeasley/heat/RSM/TandRH/date1-URSM21.ctl'
'set lat 24 31'
'set lon 271 281'
'define comp2=ave(maskout(rh2,s1.1),time=12z01Jan2041,time=12z31Dec2060)'
'define s1avgU21=sum(s1.1,time=12z01Jan2041,time=12z31Dec2060)'
*named s1sumU2186** bc didnt want to change name to year
'define s1sumU21=sum(s1.1,time=12z01Jan2041,time=12z31Dec2060)'
'define s1aveU2186=ave(s1.1,time=12z01Jan2041,time=12z31Dec2041)'
'define s1aveU2187=ave(s1.1,time=12z01Jan2042,time=12z31Dec2042)'
'define s1aveU2188=ave(s1.1,time=12z01Jan2043,time=12z31Dec2043)'
'define s1aveU2189=ave(s1.1,time=12z01Jan2044,time=12z31Dec2044)'
'define s1aveU2190=ave(s1.1,time=12z01Jan2045,time=12z31Dec2045)'
'define s1aveU2191=ave(s1.1,time=12z01Jan2046,time=12z31Dec2046)'
'define s1aveU2192=ave(s1.1,time=12z01Jan2047,time=12z31Dec2047)'
'define s1aveU2193=ave(s1.1,time=12z01Jan2048,time=12z31Dec2048)'
'define s1aveU2194=ave(s1.1,time=12z01Jan2049,time=12z31Dec2049)'
'define s1aveU2195=ave(s1.1,time=12z01Jan2050,time=12z31Dec2050)'
'define s1aveU2196=ave(s1.1,time=12z01Jan2051,time=12z31Dec2051)'
'define s1aveU2197=ave(s1.1,time=12z01Jan2052,time=12z31Dec2052)'
'define s1aveU2198=ave(s1.1,time=12z01Jan2053,time=12z31Dec2053)'
'define s1aveU2199=ave(s1.1,time=12z01Jan2054,time=12z31Dec2054)'
'define s1aveU2100=ave(s1.1,time=12z01Jan2055,time=12z31Dec2055)'
'define s1aveU2101=ave(s1.1,time=12z01Jan2056,time=12z31Dec2056)'
'define s1aveU2102=ave(s1.1,time=12z01Jan2057,time=12z31Dec2057)'
'define s1aveU2103=ave(s1.1,time=12z01Jan2058,time=12z31Dec2058)'
'define s1aveU2104=ave(s1.1,time=12z01Jan2059,time=12z31Dec2059)'
'define s1aveU2105=ave(s1.1,time=12z01Jan2060,time=12z31Dec2060)'

'define totalsumU21 = s1aveU2186 + s1aveU2187 + s1aveU2188 + s1aveU2189 + s1aveU2190 + s1aveU2191 + s1aveU2192 + s1aveU2193 + s1aveU2194 + s1aveU2195 + s1aveU2196 + s1aveU2197 + s1aveU2198 + s1aveU2199 + s1aveU2100 + s1aveU2101 + s1aveU2102 + s1aveU2103 + s1aveU2104 + s1aveU2105'

'close 1'



'open /Net/water/abhardwaj/RSM-FL/DailyA/r_pgbH.ctl'
'set lat 24 31'
'set lon 271 281'
'set time 12z01Jan1986 12z31Dec2005'
'define rh=SPFHprs.1'
'close 1'

'open /home/pbeasley/heat/RSM/TandRH/date1-URSM20.ctl'
'set lat 24 31'
'set lon 271 281'
'define comp1=ave(maskout(rh,s1.1),time=12z01Jan1986,time=12z31Dec2005)'
'define s1sumU20=sum(s1.1,time=12z01Jan1986,time=12z31Dec2005)'
'define s1aveU2086=ave(s1.1,time=12z01Jan1986,time=12z31Dec1986)'
'define s1aveU2087=ave(s1.1,time=12z01Jan1987,time=12z31Dec1987)'
'define s1aveU2088=ave(s1.1,time=12z01Jan1988,time=12z31Dec1988)'
'define s1aveU2089=ave(s1.1,time=12z01Jan1989,time=12z31Dec1989)'
'define s1aveU2090=ave(s1.1,time=12z01Jan1990,time=12z31Dec1990)'
'define s1aveU2091=ave(s1.1,time=12z01Jan1991,time=12z31Dec1991)'
'define s1aveU2092=ave(s1.1,time=12z01Jan1992,time=12z31Dec1992)'
'define s1aveU2093=ave(s1.1,time=12z01Jan1993,time=12z31Dec1993)'
'define s1aveU2094=ave(s1.1,time=12z01Jan1994,time=12z31Dec1994)'
'define s1aveU2095=ave(s1.1,time=12z01Jan1995,time=12z31Dec1995)'
'define s1aveU2096=ave(s1.1,time=12z01Jan1996,time=12z31Dec1996)'
'define s1aveU2097=ave(s1.1,time=12z01Jan1997,time=12z31Dec1997)'
'define s1aveU2098=ave(s1.1,time=12z01Jan1998,time=12z31Dec1998)'
'define s1aveU2099=ave(s1.1,time=12z01Jan1999,time=12z31Dec1999)'
'define s1aveU2000=ave(s1.1,time=12z01Jan2000,time=12z31Dec2000)'
'define s1aveU2001=ave(s1.1,time=12z01Jan2001,time=12z31Dec2001)'
'define s1aveU2002=ave(s1.1,time=12z01Jan2002,time=12z31Dec2002)'
'define s1aveU2003=ave(s1.1,time=12z01Jan2003,time=12z31Dec2003)'
'define s1aveU2004=ave(s1.1,time=12z01Jan2004,time=12z31Dec2004)'
'define s1aveU2005=ave(s1.1,time=12z01Jan2005,time=12z31Dec2005)'

'define totalsumU20 = s1aveU2086 + s1aveU2087 + s1aveU2088 + s1aveU2089 + s1aveU2090 + s1aveU2091 + s1aveU2092 + s1aveU2093 + s1aveU2094 + s1aveU2095 + s1aveU2096 + s1aveU2097 + s1aveU2098 + s1aveU2099 + s1aveU2000 + s1aveU2001 + s1aveU2002 + s1aveU2003 + s1aveU2004 + s1aveU2005'


'reset'
'close 1'



'open /home/pbeasley/heat/RSM/TandRH/jayq2mcopy.ctl'
'set lat 24 31'
'set lon 271 281'
'set time 12z01Jan1986 12z31Dec2005'
'define rh3=q2m.1'
'close 1'

'open /home/pbeasley/heat/ERA5/TandRH/date1-ERA5-HI13.ctl'
'set lat 24 31'
'set lon 271 281'
'define comp3=ave(maskout(rh3,s1.1),time=12z01Jan1986,time=12z31Dec2005)'
'define s1sumERA=sum(s1.1,time=12z01Jan1986,time=12z31Dec2005)'

'define s1aveERA86=ave(s1.1,time=12z01Jan1986,time=12z31Dec1986)'
'define s1aveERA87=ave(s1.1,time=12z01Jan1987,time=12z31Dec1987)'
'define s1aveERA88=ave(s1.1,time=12z01Jan1988,time=12z31Dec1988)'
'define s1aveERA89=ave(s1.1,time=12z01Jan1989,time=12z31Dec1989)'
'define s1aveERA90=ave(s1.1,time=12z01Jan1990,time=12z31Dec1990)'
'define s1aveERA91=ave(s1.1,time=12z01Jan1991,time=12z31Dec1991)'
'define s1aveERA92=ave(s1.1,time=12z01Jan1992,time=12z31Dec1992)'
'define s1aveERA93=ave(s1.1,time=12z01Jan1993,time=12z31Dec1993)'
'define s1aveERA94=ave(s1.1,time=12z01Jan1994,time=12z31Dec1994)'
'define s1aveERA95=ave(s1.1,time=12z01Jan1995,time=12z31Dec1995)'
'define s1aveERA96=ave(s1.1,time=12z01Jan1996,time=12z31Dec1996)'
'define s1aveERA97=ave(s1.1,time=12z01Jan1997,time=12z31Dec1997)'
'define s1aveERA98=ave(s1.1,time=12z01Jan1998,time=12z31Dec1998)'
'define s1aveERA99=ave(s1.1,time=12z01Jan1999,time=12z31Dec1999)'
'define s1aveERA00=ave(s1.1,time=12z01Jan2000,time=12z31Dec2000)'
'define s1aveERA01=ave(s1.1,time=12z01Jan2001,time=12z31Dec2001)'
'define s1aveERA02=ave(s1.1,time=12z01Jan2002,time=12z31Dec2002)'
'define s1aveERA03=ave(s1.1,time=12z01Jan2003,time=12z31Dec2003)'
'define s1aveERA04=ave(s1.1,time=12z01Jan2004,time=12z31Dec2004)'
'define s1aveERA05=ave(s1.1,time=12z01Jan2005,time=12z31Dec2005)'

'define totalsumERA = s1aveERA86 + s1aveERA87 + s1aveERA88 + s1aveERA89 + s1aveERA90 + s1aveERA91 + s1aveERA92 + s1aveERA93 + s1aveERA94 + s1aveERA95 + s1aveERA96 + s1aveERA97 + s1aveERA98 + s1aveERA99 + s1aveERA00 + s1aveERA01 + s1aveERA02 + s1aveERA03 + s1aveERA04 + s1aveERA05'

'set time 12z01Jan1986 12z31Dec2005'
'define terpERA=lterp(rh3,rh)'
'define terpERA2=lterp(rh3,rh2)'
'define addterp=lterp(totalsumERA,totalsumU20)'
'set time 12z01Jan1986'

'define addERAU20=addterp+totalsumU20'


*ADDING CODE FROM PRACTICE2.GS
******************************************************************************
'set lat 24 31'
'set lon 271 281'

'define ERAterp=lterp(comp3,comp1)'
'define ERAterp2=lterp(comp3,rh2)'

'define diff2 = comp1 - ERAterp'
'define diff3 = comp2 - comp1'

'set t 1'
*95% confidence interval value
'define t95=2.086'

********************************************************************************
'define varfavg=(sum(pow(terpERA-ERAterp,2),time=12z01jan1986,time=12z01jan2005)+sum(pow(rh-comp1,2),time=12z01jan1986,time=12z01jan2005))/(addterp+totalsumU20-2)'
'define tdiff=diff2/(sqrt(varfavg*(1/addterp+1/totalsumU20)))'

'define stat1=maskout(diff2,abs(tdiff)-abs(t95))'

********************************************************************************
'define varfavg3=(sum(pow(rh-comp1,2),time=12z01jan1986,time=12z01jan2005)+sum(pow(rh2-comp2,2),time=12z01jan2041,time=12z01jan2060))/(totalsumU20+totalsumU21-2)'
'define tdiff3=diff3/(sqrt(varfavg3*(1/totalsumU20+1/totalsumU21)))'

'define stat3=maskout(diff3,abs(tdiff3)-abs(t95))'

*******************************************************************************
'set display color white'
'c'
'set grads off'
'set gxout shaded'
'set mpdset hires'
'set lat 24 31'
'set lon 271 281'
'set grid off'
'set xlint 2'
'set ylint 2'
'set parea 0.9 4.4 7.5 10.5'
'color 12 18 .5 -kind saddlebrown->goldenrod->yellow->greenyellow->green->darkgreen->olivedrab'
'd comp1*1000'
'basemap O 15 1'
'set parea 0.9 4.4 4.2 7.9'
'color 12 18 .5 -kind saddlebrown->goldenrod->yellow->greenyellow->green->darkgreen->olivedrab'
'set mpdset hires'
'd comp2*1000'
'basemap O 15 1'
'set parea 0.9 4.4 0.9 5.3'
'color 12 18 .5 -kind saddlebrown->goldenrod->yellow->greenyellow->green->darkgreen->olivedrab'
'set mpdset hires'
'd comp3*1000'
'basemap O 15 1'
'xcbar 0.025 0.175 1.6 10.5 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'

'set parea 4.4 7.9 7.5 10.5'
'set ylab off'
'set xlab on'
'color -4 4 .5 -kind red->whitesmoke->blue'
'set mpdset hires'
'd stat1*1000'
'basemap O 15 1'
'set parea 4.4 7.9 4.2 7.9'
'color -4 4 .5 -kind red->whitesmoke->blue'
'set mpdset hires'
'd stat3*1000'
'basemap O 15 1'
'xcbar 7.95 8.10 1.6 10.5 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'

'gxprint Q-f1.eps'
