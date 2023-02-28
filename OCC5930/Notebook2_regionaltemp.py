
# coding: utf-8

# # Notebook #2. Regional temperatures
# 
# This python script reads in a spatial temperature file from an LMR reanalysis.  It also reads in a modern temperature data set (MLOST).  After exploring the LMR data set, we make two figures:
# 1. A map of temperature difference between two periods.
# 2. A time series of temperature anomalies averaged over a particular region, compared against the MLOST data.

# In[1]:

# A non-python command to make sure all figures are plotted on this page.
get_ipython().magic(u'matplotlib inline')


# In[2]:

# Import the necessary python packages 
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap
import xarray as xr
import calendar
from __future__ import print_function

# Import a custom python function
import sys
sys.path.append('../python_functions')
import map_proxies


# ## The spatial temperature file
# 
# One of the outputs of the LMR is a file containing spatial data of the 2m air temperature field.  This file contains several variables:
# * **tas**: Spatial temperature anomalies
# * **lat**: Latitudes of the data
# * **lon**: Longitudes of the data
# * **time**: Years of the reconstruction

# In[3]:

# Specify the name of an experiment and open the data set using xarray.
experiment_name = 'hackathon_PAGES2kv1'

# We ought to use the full ensemble.  However, this file is slow to load.
#handle = xr.open_dataset('../data/'+experiment_name+'/tas_sfc_Amon_MCiters_ensemble_full_all.nc',decode_times=False)

# Instead, we'll use just the means of the 11 iterations.  This will have unrealistically small uncertainty bands.
handle = xr.open_dataset('../data/'+experiment_name+'/tas_sfc_Amon_MCiters_ensemble_mean.nc',decode_times=False)


# In[4]:

# Use "print" to see the contents of the file.
print(handle)


# In[5]:

# Load data into variables
tas = handle['tas'].values
lat = handle['lat'].values
lon = handle['lon'].values
time = handle['time'].values


# ### While we wait for that to load...
# 
# Any questions so far?

# In[6]:

# Use the "shape" command to see the shape of the tas array.
print(tas.shape)


# In[7]:

# Place ensemble members and iterations on the same axis.  (Only use these lines if using all iterations.)
#niter  = tas.shape[0]
#nens   = tas.shape[1]
#nyears = tas.shape[2]
#nlat   = tas.shape[3]
#nlon   = tas.shape[4]
#tas = np.reshape(tas,(niter*nens,nyears,nlat,nlon))


# In[8]:

# Put iterations on the first axis.  (Only use this line if using the mean of the iterations.)
tas = np.swapaxes(tas,0,1)


# In[9]:

# Compute the mean of all iterations
tas_mean = np.mean(tas,axis=0)


# In[10]:

# Use the "shape" command to see the shape of the tas_mean array.
print(tas_mean.shape)


# In[11]:

# Make a very basic plot of one year of this data.
# (This won't be a very useful map, but I'm showing it for illustration purposes.)
plt.style.use('ggplot')
plt.figure(figsize=(20,11))
plt.imshow(tas_mean[-1,:,:])  # -1 specifies the last index.  In this case, we're look at the last year.
plt.title("2 m air temperature anomalies for the final year of the reanalysis ($^\circ$C)",fontsize=20)
plt.colorbar()
plt.show()


# ## Reference temperature dataset
# 
# Along with the LMR output, let's load an MLOST temperature dataset.  We'll use this later on for comparison with the LMR results.

# In[12]:

# Specify the location of the MLOST data set and open it using xarray.
handle_mlost = xr.open_dataset('../LMR_data/data/analyses/MLOST/MLOST_air.mon.anom_V3.5.4.nc',decode_times=True)


# In[13]:

# Use "print" to see the contents of the file.
print(handle_mlost)


# In[14]:

# Load data into variables
tas_mlost = handle_mlost['air'].values
lat_mlost = handle_mlost['lat'].values
lon_mlost = handle_mlost['lon'].values
time_mlost = handle_mlost['time'].values


# In[15]:

print(time_mlost)


# In[16]:

# The MLOST data is monthly, but the LMR data is annual.  Let's compute an annual-mean MLOST data.

# First, reshape the data so that years are on the first axis and months are on the second axis.
years_mlost = range(1880,2015)
nyears_mlost = len(years_mlost)

tas_mlost_2d = np.reshape(tas_mlost[0:(nyears_mlost*12),:,:],(nyears_mlost,12,len(lat_mlost),len(lon_mlost)))


# In[17]:

# Function: Compute the annual-means weighted by the correct number of days in each month.
def annual_mean(years,data_monthly):
    data_annual = np.zeros((len(years)))
    data_annual[:] = np.nan
    for i,year in enumerate(years):
        if calendar.isleap(year):
            days_in_months = [31,29,31,30,31,30,31,31,30,31,30,31]
        else:
            days_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]
        data_annual[i] = np.average(data_monthly[i,:],weights=days_in_months)
    #
    return data_annual


# In[18]:

# Create a variable filled with NaNs to store the new annual data in.
tas_mlost_annual = np.zeros((nyears_mlost,len(lat_mlost),len(lon_mlost)))
tas_mlost_annual[:] = np.nan

# Since our function isn't designed to handle latitude and longitude data, we need use loops to call the function
# for every lat and lon seperately.
for j in range(len(lat_mlost)):
    print("Computing: "+str(j+1)+"/"+str(len(lat_mlost)), end='\r')
    for i in range(len(lon_mlost)):
       tas_mlost_annual[:,j,i] = annual_mean(years_mlost,tas_mlost_2d[:,:,j,i])


# In[19]:

# Take a quick look at the dimentions of the new-created array.
print(tas_mlost_annual.shape)


# In[20]:

# Remove the mean of years 1950-1980 from the verification data, to make it more comparible to the LMR data.
ref_years = [1950,1980]
ref_indices = [years_mlost.index(year) for year in ref_years]

tas_mlost_ref = np.nanmean(tas_mlost_annual[ref_indices[0]:ref_indices[1]+1,:,:],axis=0)

tas_mlost_annual = tas_mlost_annual - tas_mlost_ref[None,:,:]


# ## Figures
# 
# Let's make some more figures to better understand the data.  First, let's make a map of temperature anomalies between two time periods.  I've specified some the boundary years of the two periods.  Feel free to change them to explore other years.

# In[21]:

### FIGURES
plt.style.use('ggplot')


# ## Figure 1. Spatial temperature anomalies between two periods

# In[22]:

### OPTIONS
# Years to map temperature anomalies over.
anomaly_period = [1980,2000]
reference_period = [1840,1860]


# In[23]:

# FIGURE 1: Map of temperature change between two periods
m = Basemap(projection='robin',lon_0=180,resolution='c')
lon_2d,lat_2d = np.meshgrid(lon,lat)
x, y = m(lon_2d,lat_2d)
levels = np.linspace(-3,3,25)

plt.figure(figsize=(20,11))
plt.axes([.05,.05,.9,.9])
m.contourf(x,y,np.mean(tas_mean[anomaly_period[0]:anomaly_period[1]+1,:,:],axis=0)-           np.mean(tas_mean[reference_period[0]:reference_period[1]+1,:,:],axis=0),           levels,extend='both',cmap='bwr',vmin=np.min(levels),vmax=np.max(levels))
m.drawcoastlines()
m.drawparallels(np.arange(-90,90,30))
m.drawmeridians(np.arange(0,360,30))
m.colorbar(location='bottom')
map_proxies.map_proxies('../data/'+experiment_name,m,'all','proxytypes',200,'b','k',1)
plt.title("Temperature anomalies (C) for years "+str(anomaly_period[0])+"-"+str(anomaly_period[1])+" minus "+          str(reference_period[0])+"-"+str(reference_period[1])+" CE.",fontsize=20)
plt.show()


# ## Proxy network
# 
# After taking a look at the data above, uncomment the line starting "map_proxies" and run the segment again.  "map_proxies" is a custom function to display the proxies used in the data assimilation.

# ## Discussion Question
# 
# Annual proxies from PAGES2k v1 are used to create this climate reanalysis.  What are the strengths and weaknesses of the data set shown above?  Where and how should improvements be made?

# ## Figure 2. Time-series of temperature over a particular region.
# 
# Now that we have a map of spatial temperature variations, let's take a closer look at a particular region.  The code below will make a regional time series.

# ## Python functions
# 
# For bits of code that are self-contained and may be useful later, it's good to write functions.  A function generally looks like this:
# 
# ```python
# def name(your,imported,variables):
#     [code]
#     return new,outputs
# ```
# 
# Parts of a function:
# * **def**: Define a function with the command "def"
# * **name**: Give your function a unique name..
# * **imported variables**: In parentheses, list the variables which will be imported from the code outside the function.  These names must be consistent within the function, but they don't need to be given the same names as the corresponding variable outside the function.
# * **code**: Write all of the function code, indented four spaces.
# * **return**: If you'd like to return any variables back to the rest of the code, list them after the word "return".
# 
# Let's make two funtions:
# * Compute a regional average from given sets of latitude and longitude.
# * Compute a running mean of a time series.

# In[24]:

"""
Function: compute a spatial mean
Inputs: - 3D variable (time,lat,lon)
        - latitudes and longitudes 
        - latitude nad longitude boundaries
Output: - spatial-mean time series of variable
"""
def spatial_mean(variable,lat,lon,lat_min,lat_max,lon_min,lon_max):
    # Make all longitude values positive
    if lon_min < 0:
        lon_min = lon_min+360
    if lon_max <= 0:
        lon_max = lon_max+360
    #
    # Find the closest grid-points to the selected latitudes and longitudes
    j_min = np.abs(lat-lat_min).argmin()
    j_max = np.abs(lat-lat_max).argmin()
    i_min = np.abs(lon-lon_min).argmin()
    i_max = np.abs(lon-lon_max).argmin()
    #print('Computing spatial mean. i='+str(i_min)+'-'+str(i_max)+', j='+str(j_min)+'-'+str(j_max) \
    #      +'.  Points are inclusive.')
    #
    # This function is sometimes used for datasets that have NaN in them.   To ignore all NaNs, create a masked array.
    variable_masked = np.ma.masked_array(variable,np.isnan(variable))
    #
    # Compute a zonal mean over the selected longitude range.
    variable_zonal = np.nanmean(variable_masked[:,:,i_min:i_max+1],axis=2)
    #
    # Compute latitude weights.
    lat_weights = np.cos(np.radians(lat))
    #
    # Declare a new variable, then compute the mean weighted mean over the selected latitude range for every year.
    variable_mean = np.zeros(variable.shape[0])
    variable_mean[:] = np.nan
    time = 0
    for time in range(variable.shape[0]):
        variable_mean[time] = np.ma.average(variable_zonal[time,j_min:j_max+1],axis=0,weights=lat_weights[j_min:j_max+1])
    #
    return variable_mean


# In[25]:

"""
Function: Compute a running mean of a time series
Inputs: - time series of variable
        - size of window for running mean 
Output: - time series of variable smoothed with running mean
"""
def boxcar(ts,window_size):
    ts_smoothed = np.convolve(ts,np.ones(window_size)/window_size,'valid')
    return ts_smoothed


# ## Options for Fig. 2

# In[26]:

### OPTIONS
# Region to average over (latitudes: -90 to 90; longitudes: 0 to 360)
latitudes = [30,60]
longitudes = [-120,-90]
# Number of years in boxcar smoothing (1=no smoothing) 
window_size = 10
#window_size = 1


# ## Calculations

# In[27]:

# Modify the time axis to account for the boxcar smoothing
years = boxcar(time,window_size)
years_mlost_smoothed = boxcar(years_mlost,window_size)


# In[28]:

# Compute the spatial mean for the verification data.
tas_mlost_region = spatial_mean(tas_mlost_annual,lat_mlost,lon_mlost,                                latitudes[0],latitudes[1],longitudes[0],longitudes[1])


# In[29]:

# Compute the spatial mean for the LMR data (for every iteration).
niter = tas.shape[0]
nyears = tas.shape[1]
tas_region = np.zeros((niter,nyears))
tas_region[:] = np.nan
for iteration in range(niter):
    print("Computing: "+str(iteration+1)+"/"+str(niter), end='\r')
    tas_region[iteration,:] = spatial_mean(tas[iteration,:,:,:],lat,lon,latitudes[0],latitudes[1],longitudes[0],longitudes[1])


# ### While we wait for that to compute...
# 
# Question or comments about the code?  About the LMR?

# ## Figure #2

# In[30]:

# More options
# Years to view
selected_years = [1000,2000]
# HDR uncertainty region
hdr_bounds = [2.5,97.5]

# FIGURE 2: Plot the time series of temperature anomalies, averaged over the given region.
plt.figure(figsize=(20,11))
plt.axes([.1,.1,.8,.8])
line1 = plt.fill_between(years,boxcar(np.percentile(tas_region,hdr_bounds[0],axis=0),window_size),                         boxcar(np.percentile(tas_region,hdr_bounds[1],axis=0),window_size),color='b',alpha=0.2)
line3, = plt.plot(years_mlost_smoothed,boxcar(tas_mlost_region,window_size),color='b',linewidth=2)
line2, = plt.plot(years,boxcar(np.mean(tas_region,axis=0),window_size),color='k',linewidth=1)
tas_mlost_region
plt.xlim(selected_years)
#plt.ylim(-1.5,1)
plt.title("Regional-mean 2 m air temperature anomalies ($^\circ$C), "+str(window_size)+          "-year sliding mean.\nRegion: Lat: "+str(latitudes[0])+" - "+str(latitudes[1])+          ", Lon: "+str(longitudes[0])+" - "+str(longitudes[1]),fontsize=20)
plt.xlabel("Year",fontsize=16)
plt.ylabel("Temperature anomaly ($^\circ$C)",fontsize=16)
plt.legend([line1,line2,line3],["LMR HDR","LMR mean","MLOST"],loc=2,fontsize=16)
plt.show()


# ## Questions and discussion
# 
# * Reminder: Because we're only using the iteration means, the error bars do not reflect the actual LMR uncertainty range.  When doing a real analysis, make sure to use all ensemble members.
# * Go back to the "Options for Fig. 2" section to specify a new region.  Does the time series show anything interesting?  Compare different regions.
# * What remains unclear?  Any questions or comments?

# In[ ]:



