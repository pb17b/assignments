'reinit'
'set display color white'
'c'

'set mpdset hires'
'set grid off'
'set grads off'


'open /home/pbeasley/heat/RSM/length/length-CRSM20-HI14.ctl'
'define one=ave(f5,time=12z01jan1986,time=12z01jan2005)'
*'define last=ave(hi13l,time=12z01jan1986,time=12z01jan2005)'

'open /home/pbeasley/heat/RSM/length/length-CRSM21-HI14.ctl'
'define one2=ave(f5.2,time=12z01jan2041,time=12z01jan2060)'
*'define last2nd=ave(hi13l.2,time=12z01jan2041,time=12z01jan2060)'

'open /home/pbeasley/heat/RSM/length/length-URSM20-HI14.ctl'
'define one3=ave(f5.3,time=12z01jan1986,time=12z01jan2005)'

'open /home/pbeasley/heat/RSM/length/length-URSM21-HI14.ctl'
'define one4=ave(f5.4,time=12z01jan2041,time=12z01jan2060)'

*'define first=ave(hi13f,time=12z01jan1986,time=12z01jan2005)'
*'define last=ave(hi13l,time=12z01jan1986,time=12z01jan2005)'

*'define first2=ave(hi13f.2,time=12z01jan2041,time=12z01jan2060)'
*'define last2=ave(hi13l.2,time=12z01jan2041,time=12z01jan2060)'

'define diff1=one2-one'
'define diff2=one4-one3'

'define t95=2.086'

'define varfavg=(sum(pow(f5.2-one2,2),time=12z01jan2041,time=12z01jan2060)+sum(pow(f5-one,2),time=12z01jan1986,time=12z01jan2005))/(20+20-2)'
'define tdiff=diff1/(sqrt(varfavg*(1/20+1/20)))'

'define varlavg=(sum(pow(f5.4-one4,2),time=12z01jan2041,time=12z01jan2060)+sum(pow(f5.3-one3,2),time=12z01jan1986,time=12z01jan2005))/(20+20-2)'
'define tdiff2=diff2/(sqrt(varlavg*(1/20+1/20)))'

'define statuc1=maskout(diff1,abs(tdiff)-abs(t95))'
'define statuc2=maskout(diff2,abs(tdiff2)-abs(t95))'


**************************************************
'set gxout shaded'
'set lat 24 31'
'set lon 271 281'
'set grid off'
'set xlint 2'
'set ylint 2'
'set parea 0.9 4.4 7.5 10.5'
'color 0 10 -kind olivedrab->darkgreen->green->greenyellow->yellow->goldenrod->saddlebrown'
'd one'
'basemap O 15 1'
'set parea 0.9 4.4 4.2 7.9'
'color 0 10 -kind olivedrab->darkgreen->green->greenyellow->yellow->goldenrod->saddlebrown'
'set mpdset hires'
'set xlab off'
'd one2'
'xcbar 0.025 0.175 1.6 10.5 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'
'basemap O 15 1'
'set parea 0.9 4.4 0.9 5.3'
'color 0 60 -kind blue->whitesmoke->red'
'set mpdset hires'
'set xlab on'
'd statuc1'
'basemap O 15 1'
*'set parea 4.4 7.9 7.5 10.8'
*'set ylab off'
'color -20 20 -kind blue->whitesmoke->red'
*'d statfuc'
'basemap O 15 1'
*'set parea 4.4 7.9 4.2 7.5'
'color -20 20 -kind blue->whitesmoke->red'
*'d statfu'
'basemap O 15 1'
*'set parea 4.4 7.9 0.9 4.2'
'color -20 20 -kind blue->whitesmoke->red'
*'d statfc'
'basemap O 15 1'
*'xcbar 8.05 8.15 0.9 10.8 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'
*'xcbar 4.75 4.9 1.6 10.5 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'
*'gxprint firstdate13-CRSM.eps'
*res needs to be fit for portrait mode
*'gxprint firstdate-CRSM-HI13.png x850 y1100'
*'c'


*********
'set gxout shaded'
'set lat 24 31'
'set lon 271 281'
'set grid off'
'set xlint 2'
'set ylint 2'
'set ylab off'
*'set parea 0.9 4.4 7.5 10.5'
'set parea 4.4 7.9 7.5 10.5'
'color 0 10 -kind olivedrab->darkgreen->green->greenyellow->yellow->goldenrod->saddlebrown'
'set mpdset hires'
'set xlab off'
'd one3'
'basemap O 15 1'
*'set parea 0.9 4.4 4.2 7.9'
'set parea 4.4 7.9 4.2 7.9'
'color 0 10 -kind olivedrab->darkgreen->green->greenyellow->yellow->goldenrod->saddlebrown'
'set mpdset hires'
'set xlab off'
'd one4'
*'xcbar 0.025 0.175 1.6 10.5 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'
'basemap O 15 1'
*'set parea 0.9 4.4 0.9 5.3'
'set parea 4.4 7.9 0.9 5.3'
'color 0 60 -kind blue->whitesmoke->red'
'set mpdset hires'
'set xlab on'
'd statuc2'
'basemap O 15 1'
*'set parea 4.4 7.9 7.5 10.8'
*'set ylab off'
'color -20 20 -kind blue->whitesmoke->red'
*'d statfuc'
'basemap O 15 1'
*'set parea 4.4 7.9 4.2 7.5'
'color -20 20 -kind blue->whitesmoke->red'
*'d statfu'
'basemap O 15 1'
*'set parea 4.4 7.9 0.9 4.2'
'color -20 20 -kind blue->whitesmoke->red'
*'d statfc'
'basemap O 15 1'
*'xcbar 4.75 4.9 1.6 10.5 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'
'xcbar 8 8.15 1.6 10.5 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'
'gxprint f5-HI14.eps'
*res needs to be fit for portrait mode
*'gxprint lastdate-CRSM-HI13.png x850 y1100'
*x850 y1100
***************************************************

*SECOND TWO PLOTS

*'set lat 24 31'
*'set lon 271 281'
*'set gxout shaded'
*'set grads off'
*'set grid off'
*'set ylint 2'
*'set xlint 2'
*'set ylab on'
*'set mpdset hires'
*'set parea 4.4 7.9 6.8 10.8'
*'color 70 320 -kind darkolivegreen->olivedrab->darkgreen->green->forestgreen->limegreen->lime->mediumspringgreen->springgreen->palegreen->lightgreen->greenyellow->beige->moccasin->palegoldenrod->khaki->yellow->gold->goldenrod->orange->darkorange->sandybrown->peru->chocolate->darkgoldenrod->saddlebrown'
*'d first2nd'

*'xcbar 8.05 8.15 4.5 10.3 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'

*'basemap O 15 1'
*'set mpdset hires'
*'set parea 4.4 7.9 4.2 7.5'
*'color 70 320  -kind darkolivegreen->olivedrab->darkgreen->green->forestgreen->limegreen->lime->mediumspringgreen->springgreen->palegreen->lightgreen->greenyellow->beige->moccasin->palegoldenrod->khaki->yellow->gold->goldenrod->orange->darkorange->sandybrown->peru->chocolate->darkgoldenrod->saddlebrown'
*'d last2nd'
*'basemap O 15 1'

*FIRST TWO PLOTS
*'set mpdset hires'
*'set parea 0.9 4.4 6.8 10.8'
*'open /home/pbeasley/heat/RSM/firstlast/test-date-CRSM21-HI13.ctl'
*'define first2nd=ave(hi13f.2,time=12z01jan2041,time=12z01jan2060)'
*'define last2nd=ave(hi13l.2,time=12z01jan2041,time=12z01jan2060)'
*'color 70 320 -kind darkolivegreen->olivedrab->darkgreen->green->forestgreen->limegreen->lime->mediumspringgreen->springgreen->palegreen->lightgreen->greenyellow->beige->moccasin->palegoldenrod->khaki->yellow->gold->goldenrod->orange->darkorange->sandybrown->peru->chocolate->darkgoldenrod->saddlebrown'
*'d first'
*'basemap O 15 1'

*'xcbar 8.15 8.3 1.5 7.0'
*'set mpdset hires'
*'set parea 0.9 4.4 4.2 7.5'
*'color 70 320 -kind darkolivegreen->olivedrab->darkgreen->green->forestgreen->limegreen->lime->mediumspringgreen->springgreen->palegreen->lightgreen->greenyellow->beige->moccasin->palegoldenrod->khaki->yellow->gold->goldenrod->orange->darkorange->sandybrown->peru->chocolate->darkgoldenrod->saddlebrown'
*'d last'
*'basemap O 15 1'

*THIRD TWO PLOTS

*'rgbset2'
*'set grads off'
*'set mpdset hires'
*'set gxout shaded'
*'set parea 4.4 7.9 0.9 4.9'
*'set clevs -40 -35 -30 -25 -20 -15 -10 -5  0 5  10   15   20   25   30   35 40'
*'set rbcols 49 47 45 43 41  61   63   65   66   68'
*'d maskout(diff2,abs(tdiff2)-abs(t95))'
*'set gxout contour'
*'set clevs -40 -35 -30 -25 -20 -15 -10 -5  0 5 10 15 20 25 30 35 40'
*'set ccols 1'
*'set clab off'
*'d maskout(diff2,abs(tdiff2)-abs(t95))'
*'basemap O 15 1'



*'set grads off'
*'set mpdset hires'
*'set gxout shaded'
*'set parea 0.9 4.4 0.9 4.9'
*'set clevs   -40 -35 -30 -25 -20 -15 -10 -5  0 5 10 15 20 25 30 35 40'
*'set rbcols 49  47  45  43  41 61 63 65 66 68'
*'d maskout(diff1,abs(tdiff)-abs(t95))'
*'set gxout contour'
*'set clab off'
*'set ccols 1'
*'set clevs    -40 -35 -30 -25 -20 -15 -10 -5  0 5 10 15 20 25 30 35 40'
*'d maskout(diff1,abs(tdiff)-abs(t95))'
*'basemap O 15 1'
*************************************************************************
*'xcbar 1 7.8 0.9 1.0 -fw 0.09 -fh 0.1 -line on -edge triangle'



