
# coding: utf-8

# # Notebook #3: EOF analysis of LMR output
# 
# This notebook walks you through simple steps to generate EOFs of LMR fields. It makes use of the eofs package:
#  
#     Dawson, A., (2016). eofs: A Library for EOF Analysis of Meteorological, 
#     Oceanographic, and Climate Data. Journal of Open Research Software. 4(1), 
#     p.e14. DOI: http://doi.org/10.5334/jors.122
# 

# In[1]:

from __future__ import print_function
import cartopy.crs as ccrs
import cartopy.feature as cfeature
import cartopy.util as cutil
import matplotlib.pyplot as plt
import numpy as np
import xarray as xr
from eofs.xarray import Eof
import matplotlib.gridspec as gridspec
# for graphics
plt.style.use('ggplot')

# Import a custom python function
import sys
sys.path.append('../python_functions')
import filters as flt


# ### LOAD DATA

# In[2]:

# Specify the name of an experiment and open the data set using xarray.
experiment_name = 'hackathon_PAGES2kv1'

ds = xr.open_dataset('../data/'+experiment_name+'/tas_sfc_Amon_MCiters_ensemble_mean.nc',decode_times=False)
print(ds)
ds_ensMean = ds.mean(dim=('member')) # average over records

tas     = ds_ensMean['tas']
nt , ny, nx = tas.shape

# glean coordinates
lat   = tas['lat'].values
lon   = tas['lon'].values
years = tas['time'].values


# ### EOF analysis

# Now let's perform EOF analysis per se. First, we need to define some weights proportional to the area of each grid cell

# In[3]:

#  Square-root of cosine of latitude weights are applied before the computation of EOFs.
coslat = np.cos(np.deg2rad(lat))
wgts = np.sqrt(np.abs(coslat[..., np.newaxis])) # ensure values near 0 are >0, and add extra axis for compatibility


# Create an EOF solver to do the EOF analysis. the eofs package works natively with xarray, so there's very little we need to do. 

# In[4]:

tsolver = Eof(tas, weights=wgts)


# In[5]:

# first let's inspect the eigenvalue spectrum
pctvar = np.round(tsolver.varianceFraction(neigs=20).values*100) # eigenvalue spectrum
f,ax = plt.subplots(2,1,sharex=True)
ax[0].plot(pctvar,'o')
ax[0].set_title('Eigenvalue spectrum',fontweight='bold')
ax[0].set_ylabel('% variance')
ax[1].plot(np.cumsum(pctvar),'o')
ax[1].set_xlabel('Mode index')
ax[1].set_ylabel('% total')
plt.show()


#  You can see that the first mode accounts for ~50% of the variance, and the first 5, 90%. This is a standard "red" spectrum, as you'd expect for a geophysical field. 
#  
#  Now let's retrieve the EOFs, expressed as the correlation between the leading PC time series and the input tas anomalies at each grid point, and the PC time series themselves. Let's keep 4 of those, since returns and interpretability diminish fast in EOF land.

# In[6]:

eof = tsolver.eofsAsCovariance(neofs=4)
pc  = tsolver.pcs(npcs=4, pcscaling=1)


#  Now let's plot the EOFs and PCs themselves. Because we're going to have to do this quite a bit, let's be smart and write a couple of functions to do that. 

# In[7]:

def contourLevels(DataArray,nc = 21):
    '''
    Computes evenly-spaced contour levels

    '''
    Li = max(abs(DataArray.max()),abs(DataArray.min()))
    clevs = np.linspace(-Li/10, Li/10, nc)
    return clevs, Li

def eofPlotter_xr(eof,pc,pctvar,lon,proj,ttl,units,modes=(1,2),nc=31,cmap=plt.cm.RdBu_r,fnt='Open Sans'):
    '''
    Plot 2 EOF modes using the output of the xarray eof solver 
    '''
    # declare figure
    fig = plt.figure(1,figsize=(12,6))
    gs = gridspec.GridSpec(2, 2, bottom=.05, top=.90, wspace=.1,width_ratios=[1, 1.3])
    # plot EOF1
    EOF1 = eof.sel(mode=modes[0]-1).values
    EOF1c, lonc = cutil.add_cyclic_point(EOF1, lon) # make cyclic 
    ax1 = plt.subplot(gs[0, 0],projection=proj)
    clevs, Li = contourLevels(EOF1)
    #cf = ax1.contourf(lon,lat,-EOF1.values,levels=clevs, cmap=plt.cm.RdBu_r,transform=ccrs.PlateCarree())
    cf = ax1.contourf(lonc,lat,EOF1c,nc, vmin=-Li,vmax=Li, cmap=cmap,transform=ccrs.PlateCarree())
    ax1.set_global()
    ax1.add_feature(cfeature.COASTLINE, edgecolor='k')
    ax1.set_title(r'EOF '+str(modes[0]),fontname=fnt,fontsize=12)
    #ax1.set_title(r'EOF '+str(modes[0])+' ('+units+', '+ str(pctvar[modes[0]-1])+ '% var)',fontname=fnt,fontsize=12)
    cb = plt.colorbar(cf,ax=ax1, orientation='vertical')
    # now plot PC1
    pc1 = pc.sel(mode=modes[0]-1)
    ax2 = plt.subplot(gs[0, 1])
    ax2.plot(years,pc1); ax2.set_title('PC '+str(modes[0]))
    plt.setp(ax2.get_xticklabels(), visible=False)

    # plot EOF2
    EOF2 = eof.sel(mode=modes[1]-1).values
    EOF2c, lonc = cutil.add_cyclic_point(EOF2, lon) # make cyclic 
    clevs, Li = contourLevels(EOF2)
    ax3 = plt.subplot(gs[1, 0],projection=proj)
    cf = ax3.contourf(lonc,lat,EOF2c,nc, vmin=-Li,vmax=Li, cmap=cmap,transform=ccrs.PlateCarree())
    ax3.set_global()
    ax3.add_feature(cfeature.COASTLINE, edgecolor='k')
    ax3.set_title(r'EOF '+str(modes[1]),fontname=fnt,fontsize=12)
    #ax3.set_title(r'EOF '+str(modes[1])+' ('+units+', '+ str(pctvar[modes[1]-1])+ '% var)',fontname=fnt,fontsize=12)
    cb = plt.colorbar(cf,ax=ax3, orientation='vertical')
    # now plot PC2
    pc2 = pc.sel(mode=modes[1]-1)
    ax4 = plt.subplot(gs[1, 1])
    ax4.plot(years,pc2); ax4.set_title('PC '+str(modes[1])); ax4.set_xlabel('Year CE')
    
    fig.suptitle(ttl,fontweight='bold',fontsize=16,fontname=fnt)    
    ax = (ax1,ax2,ax3,ax3)
    fn = ttl + '_modes'+str(modes)
    fstr = fn.replace(' ','_').replace(',',"").replace('(',"").replace(')',"") # make filename from title

    return fig, ax, fstr


# In[8]:

# Plot unfiltered EOFS
proj = ccrs.Orthographic(central_longitude=0.0, central_latitude=90)  
units = '\xb0C'
ttl = 'LMR unfiltered'
  
f1, ax1, fn = eofPlotter_xr(eof,pc,pctvar,lon,proj,ttl,units,modes=(1,2)) # invoke plotter
plt.show()


# Ain't it pretty? 
# The first mode clearly corresponds to a "global warming" mode with a strong 20th century expression and a spatial pattern suggestive of polar amplification. Mode 2 has a maximum over Alaska and a cold annulus throughout much of the northern midlatitudes.  
# 
# Now let's look at modes 3 and 4:

# In[9]:

f2, ax2, fn = eofPlotter_xr(eof,pc,pctvar,lon,proj,ttl,units,modes=(3,4))
plt.show()


# By definition, all these modes are bi-orthogonal, and they get harder to interpret as we go down the list.
# 
# Also, annual data are rather noisy. Let us zoom in on multidecadal variations (say, 20y and longer)

# ### Applying a low-pass filter
# 
# Here we'll be using the filters package provided under "python_functions". We'll be using a Butterworth filter with default options. to see what they are, type: 

# In[10]:

get_ipython().magic(u'pinfo flt.butterworth')


# In[11]:

# apply 20y low-pass filter
Tc= 20; fc = 1./Tc
ns = ny*nx  # number of spatial points
tas_v = np.reshape(tas.values,(nt, ns)) # reshape into 2d
tas_f = np.empty(tas_v.shape) # create recipient array

for j in range(ns):  # loop over all grid points
    tas_f[:,j] = flt.butterworth(tas_v[:,j],fc,pad='reflect') # apply Butterworth filter with default options

tas_f = np.reshape(tas_f,(nt , ny, nx)) # reshape into 3d


# Notice that the filer works on NumPy arrays, but doesn't "know" about xarray. We can apply EOF analysis on this new (NumPy) aray, but we need to invoke the eofs package in a slightly different way. We also need to modify our plotter routine so it handles NumPy arrays, not just xarrays. 

# In[12]:

# run EOF solver
from eofs.standard import Eof as SEof
tsolver = SEof(tas_f, weights=wgts)
pctvar10y = np.round(tsolver.varianceFraction(neigs=20)*100)
# first let's  inspect the eigenvalue spectrum
f,ax = plt.subplots(2,1,sharex=True)
ax[0].plot(pctvar10y,'o')
ax[0].set_title('Eigenvalue spectrum',fontweight='bold')
ax[0].set_ylabel('% variance')
ax[1].plot(np.cumsum(pctvar10y),'o')
ax[1].set_xlabel('Mode index')
ax[1].set_ylabel('% total')
plt.show()


# This is similar to before, except that the first mode now explains nearly 60% of the variance.

# In[13]:

eof10y = tsolver.eofsAsCovariance(neofs=2)
pc10y  = tsolver.pcs(npcs=2, pcscaling=1)


# In[14]:

def eofPlotter_np(eof,pc,pctvar,lon,proj,ttl,units,modes=(1,2),nc=31,cmap=plt.cm.RdBu_r,fnt='Open Sans'):
    '''
    Plot 2 EOF modes using the output of the 'standard' eof solver
    '''
    # declare figure
    fig = plt.figure(1,figsize=(12,6))
    gs = gridspec.GridSpec(2, 2, bottom=.05, top=.90, wspace=.1,width_ratios=[1, 1.3])
    # plot EOF1
    EOF1 = eof[modes[0]-1,...]
    EOF1c, lonc = cutil.add_cyclic_point(EOF1, lon) # make cyclic
    ax1 = plt.subplot(gs[0, 0],projection=proj)
    clevs, Li = contourLevels(EOF1)
    #cf = ax1.contourf(lon,lat,-EOF1.values,levels=clevs, cmap=plt.cm.RdBu_r,transform=ccrs.PlateCarree())
    cf = ax1.contourf(lonc,lat,EOF1c,nc, vmin=-Li,vmax=Li, cmap=cmap,transform=ccrs.PlateCarree())
    ax1.set_global()
    ax1.add_feature(cfeature.COASTLINE, edgecolor='k')
    ax1.set_title(r'EOF '+str(modes[0]),fontname=fnt,fontsize=12)
    #ax1.set_title(r'EOF '+str(modes[0])+' ('+units+', '+ str(pctvar[modes[0]-1])+ '% var)',fontname=fnt,fontsize=12)
    cb = plt.colorbar(cf,ax=ax1, orientation='vertical')
    # now plot PC1
    pc1 = pc[:,modes[0]-1]
    ax2 = plt.subplot(gs[0, 1])
    ax2.plot(years,pc1); ax2.set_title('PC '+str(modes[0]))
    plt.setp(ax2.get_xticklabels(), visible=False)

    # plot EOF2
    EOF2 = eof[modes[1]-1,...]
    EOF2c, lonc = cutil.add_cyclic_point(EOF2, lon) # make cyclic
    clevs, Li = contourLevels(EOF2)
    ax3 = plt.subplot(gs[1, 0],projection=proj)
    cf = ax3.contourf(lonc,lat,EOF2c,nc, vmin=-Li,vmax=Li, cmap=cmap,transform=ccrs.PlateCarree())
    ax3.set_global()
    ax3.add_feature(cfeature.COASTLINE, edgecolor='k')
    ax3.set_title(r'EOF '+str(modes[1]),fontname=fnt,fontsize=12)
    #ax3.set_title(r'EOF '+str(modes[1])+' ('+units+', '+ str(pctvar[modes[1]-1])+ '% var)',fontname=fnt,fontsize=12)
    cb = plt.colorbar(cf,ax=ax3, orientation='vertical')
    # now plot PC2
    pc2 = pc[:,modes[1]-1]
    ax4 = plt.subplot(gs[1, 1])
    ax4.plot(years,pc2); ax4.set_title('PC '+str(modes[1])); ax4.set_xlabel('Year CE')

    fig.suptitle(ttl,fontweight='bold',fontsize=16,fontname=fnt)
    ax = (ax1,ax2,ax3,ax3)
    fn = ttl + '_modes'+str(modes)
    fstr = fn.replace(' ','_').replace(',',"").replace('(',"").replace(')',"") # make filename from title

    return fig, ax, fstr


# In[15]:

# now plot
ttl = 'LMR, 20y lowpass filter'
f1, ax1, fn = eofPlotter_np(eof10y,pc10y,pctvar10y,lon,proj,ttl,units,modes=(1,2)) # invoke plotter
plt.show()


# The patterns are ostensibly the same as in the unfiltered case, but explain more variance overall, and the temporal signature is easier to see. Notice the practically flat curves over the first millennium BCE. Looking only at the ensemble mean, one would think that climate ground to a halt during this interval. This is, of course, be preposterous. The reality is that the ensemble mean is not a useful summary of what's going on. Let's therefore look at ensemble EOFs.

# ### Ensemble EOFs
# 
# Let's start by extracting the ensemble members and reshaping the matrix in a friendly form

# In[16]:

ds_all = xr.open_dataset('../data/'+experiment_name+'/tas_sfc_Amon_MCiters_ensemble_full_all.nc',decode_times=False)
print(ds_all)

tas     = ds_all['tas']
tas = np.reshape(tas.values, (11*20,2001, 42, 63))
nens, nt, ny, nx = tas.shape


# Now loop over ensemble members and apply EOF analysis. 

# In[17]:

npcs = 1  # keep only first PC
nsample = 50
ensPC = np.empty((nsample,nt,2)) # define receiver PC matrix
select = np.random.randint(0,nens,nsample)
for je in range(nsample):
    print("Solving EOF problem for ensemble member "+str(je+1)+"/"+ str(nsample))
    EnsSolver = SEof(tas[select[je],...], weights=wgts)
    eof = EnsSolver.eofsAsCovariance(neofs=1)
    if (eof.max()>0.5):
        sign = +1
    else:
        sign = -1 
        
    ensPC[je,...] = sign*EnsSolver.pcs(npcs=npcs, pcscaling=1)


# Now let's plot the result. Let's define a function to do that.

# In[18]:

def tsEnsPlot(t, X, ax, col='RoyalBlue',ns=7):
    """Plots results of an ensemble of timeseries X(t)
       X: 2-dim Numpy Arrray
       t: time axis (needs to have same dimesion as X # of rows or columns)
       ax: axis to plot into
       col: color of patch
       ns: number of sample lines
    """
    plt.style.use('ggplot')

    nt = len(t)
    tdim = X.shape.index(nt)
    if tdim == 1:
       X = X.T

    nens = X.shape[1]
    Xq = np.percentile(X,(2.5,25,50,75,97.5),axis=1).T # compute quantiles
    # plot quantiles
    ax.fill_between(t,Xq[:,0],Xq[:,4],color=col,alpha=0.3,label='95% HDR')
    ax.fill_between(t,Xq[:,1],Xq[:,3],color=col,alpha=0.6,label='IQR')
    if ns>0:
        # plot individual members
        ax.plot(t,X[:,np.random.randint(nens,size=ns)],color='Gray',linewidth=0.5,alpha=0.4)
    # in any case, plot median
    ax.plot(t,Xq[:,2],color='Black',linewidth=1,label='median')
    ax.legend(loc='upper left',ncol=4)
    return ax, Xq


# In[19]:

f,ax = plt.subplots(1,1)
_ = tsEnsPlot(years, ensPC[:,:,0].T, ax=ax, col='RoyalBlue',ns=0)
plt.show()


# So we see that the first PC is quite consistent from iteration to iteration. Thus, using the ensemble mean for the EOF plots above wasn't as misguided as it might seem *a priori*. Breathe a huge sigh of relief, and please move on to the next activity. 
