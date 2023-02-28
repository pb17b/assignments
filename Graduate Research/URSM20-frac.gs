'reinit'
'set display color white'
'c'

'open /home/pbeasley/heat/RSM/length/length-URSM20-HI13.ctl'
'define one=ave(f1,time=12z01jan1986,time=12z01jan2005)'
'define two=ave(f2,time=12z01jan1986,time=12z01jan2005)'
'define three=ave(f3,time=12z01jan1986,time=12z01jan2005)'
'define four=ave(f4,time=12z01jan1986,time=12z01jan2005)'
'define five=ave(f5,time=12z01jan1986,time=12z01jan2005)'

'define p2 = (two/one)*100'
'define p3 = (three/one)*100'
'define p4 = (four/one)*100'
'define p5 = (five/one)*100'

***************************************************************************
'set mpdset hires'
'set grid off'
'set grads off'

'set gxout shaded'
'set lat 24 31'
'set lon 271 281'
'set grid off'
'set xlint 2'
'set ylint 2'
'set ylab on'
'set parea 0.9 4.4 4.2 7.9'
*'color 50 100 5 -kind olivedrab->darkgreen->green->greenyellow->yellow->goldenrod->saddlebrown'
'color 50 100 -kind blue->whitesmoke->red'
'set mpdset hires'
'd p2'
'basemap O 15 1'

'set parea 0.9 4.4 0.9 5.3'
'set ylab on'
*'color 50 100 5 -kind olivedrab->darkgreen->green->greenyellow->yellow->goldenrod->saddlebrown'
'color 50 100 -kind blue->whitesmoke->red'
'set mpdset hires'
'd p3'
'xcbar 0.025 0.175 1.6 7.5 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'
'basemap O 15 1'

'set parea 4.4 7.9 4.2 7.9'
'set ylab off'
*'color 50 100 5 -kind olivedrab->darkgreen->green->greenyellow->yellow->goldenrod->saddlebrown'
'color 50 100 -kind blue->whitesmoke->red'
'set mpdset hires'
'd p4'
'basemap O 15 1'

'set parea 4.4 7.9 0.9 5.3'
'set ylab off'
*'color 50 100 5 -kind olivedrab->darkgreen->green->greenyellow->yellow->goldenrod->saddlebrown'
'color 50 100 -kind blue->whitesmoke->red'
'set mpdset hires'
'd p5'
'basemap O 15 1'


'set parea 0.9 4.4 7.5 10.5'
'set ylab on'
'set xlab off'
'color 50 180 10 -kind olivedrab->darkgreen->green->greenyellow->yellow->goldenrod->saddlebrown'
'set mpdset hires'
'd one'
'basemap O 15 1'
'xcbar .025 .175 7.6 10.5 -fw 0.09 -fh 0.1 -line on -dir v -edge triangle'
