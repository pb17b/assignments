
# coding: utf-8

# # Notebook #1: Global and hemispheric mean temperatures
# 
# This notebook reads in the spatial-mean temperature file from an LMR reanalysis.  After exploring this dataset, we make three figures:
# 1. Time-series of global-mean temperature anomalies
# 2. Time-series of Northern Hemisphere and Southern Hemisphere-mean temperature anomalies
# 3. Probability density functions of temperature anomalies for different years

# In[1]:

# A non-python command to make sure all figures are plotted on this page.
get_ipython().magic(u'matplotlib inline')


# In[2]:

# Import the necessary python packages 
import numpy as np
import matplotlib.pyplot as plt
import random
import xarray as xr

# Import a custom python function
import sys
sys.path.append('../python_functions')
import filters as flt


# ## The GMT file
# 
# One of the outputs of the LMR is a "gmt" file with mean temperatures anomalies.  This file contains several variables:
# * **gmt**, **nhmt**, and **shmt**: Global, Northern Hemisphere, and Southern Hemisphere-mean temperature anomalies
# * **time**: Years of the reconstruction

# In[3]:

# Specify the name of an experiment and open the data set using xarray.
experiment_name = 'hackathon_PAGES2kv1'
handle = xr.open_dataset('../data/'+experiment_name+'/gmt_ensemble_MCiters.nc',decode_times=False)


# In[4]:

# "print" shows us the contents of a file.  "print" this new variable to see the contents of the file.
print(handle)


# In[5]:

# Load data into variables
gmt_data = handle['gmt'].values
nhmt_data = handle['nhmt'].values
shmt_data = handle['shmt'].values
recon_times = handle['time'].values


# In[6]:

# The time variable gives the year.
print(recon_times)


# In[7]:

# To print only specific cells of an array, specify the indicies in brackets.  In python, indices start at 0, not 1!
print(recon_times[0:10])


# In[8]:

# The gmt variable contains global-mean temperature.  It is an array with three dimensions: time, iterations, and
# ensemble members.  The "shape" command shows the shape of an array.
print(gmt_data.shape)


# ## Uncertainty in the LMR
# One strength of the LMR framework is that is produces an ensemble of results, quantifying uncertainty.
# 
# Each time the LMR is run, it uses a random 75% of the proxy records and a random 200 years of the model results.  Differences in these 200 "prior" years lead to the 200 different "posterior" results.  These are the 200 **ensemble** members.
# 
# Additionally,  multiple **iterations** of the LMR are run.  Each iteration uses a different 75% of the proxy records and a different 200 model years.  This is another way of sampling uncertainty.  In these results, 11 iterations were run.
# 
# 11 iterations, each with 200 ensemble members, gives us 2200 possible solutions based on the data.

# In[9]:

# Print the first 10 values of one ensemble member.  '0:10' means the first 10 indices of the 'time' dimension.
# 0s in the other dimensions selects the first index in those two dimensions.
print(gmt_data[0:10,0,0])


# In[10]:

# Print the first 10 values of a different ensemble member, to prove that these values are different.
print(gmt_data[0:10,3,7])


# In[11]:

# To get a better sense of what this data looks like, make a basic plot of two ensemble members.
plt.style.use('ggplot')
plt.figure(figsize=(20,11))

plt.plot(recon_times,gmt_data[:,0,0])
plt.plot(recon_times,gmt_data[:,3,7])
plt.title("Global-mean 2 m air temperature anomalies for two ensemble members ($^\circ$C)",fontsize=20)
plt.xlabel("Year",fontsize=16)
plt.ylabel("Temperature anomaly ($^\circ$C)",fontsize=16)
plt.show()


# ## Discussion Question
# 
# * Why does the LMR produce a range of possible answers?  Why not just use the median?
# * What do you notice about the two ensemble member above?

# ## Figures
# 
# Let's make some more figures to better understand the data.  First, let's make a better figure of global-mean temperature anomalies over time.  I've specified some options for the figure.  Leave them as-is for now.  You can return to them later to modify what we are plotting.  The "highest density region" shows the range of results between the two percentiles listed below (initially the 2.5 - 97.5 percentiles).

# In[12]:

### OPTIONS
# Some options for modifying the figures

# Years to view
selected_years = [1000,2000]
# Number of years in boxcar smoothing (1=no smoothing) 
window_size = 10
# Highest density region
hdr_bounds = [2.5,97.5]
# Number of ensemle members to view
sample_members = 5


# In[13]:

### CALCULATIONS

# Get dimensions
nyears = gmt_data.shape[0]
niters = gmt_data.shape[1]
nens   = gmt_data.shape[2]

# Reshape the arrays so that iterations and ensemble members are on the same axis
gmt = np.reshape(gmt_data,(nyears,niters*nens))
nhmt = np.reshape(nhmt_data,(nyears,niters*nens))
shmt = np.reshape(shmt_data,(nyears,niters*nens))

# Select random indices
random.seed(a=0)
random_indices = random.sample(xrange(0,nens*niters),sample_members)

# Define a simple smoothing function
def boxcar(ts,window_size):
    ts_smoothed = np.convolve(ts,np.ones(window_size)/window_size,'valid')
    return ts_smoothed

# Modify the time axis to account for the boxcar smoothing
years = boxcar(recon_times,window_size)


# In[14]:

### FIGURES
# Set the plot style to 'ggplot'.
plt.style.use('ggplot')


# ## Figure 1. Global-mean temperature anomalies through time.

# In[15]:

# FIGURE 1: Plot the whole LMR reconstruction, smoothing data with a moving average.
plt.figure(figsize=(20,11))
plt.axes([.1,.1,.8,.8])

# Boxcar filter (A very basic filter.)
line1 = plt.fill_between(years,boxcar(np.percentile(gmt,hdr_bounds[0],axis=1),window_size),                          boxcar(np.percentile(gmt,hdr_bounds[1],axis=1),window_size),color='b',alpha=0.2)
for i in random_indices: line2, = plt.plot(years,boxcar(gmt[:,i],window_size),color='gray',linewidth=.5)

line3, = plt.plot(years,boxcar(np.mean(gmt,axis=1),window_size),color='k',linewidth=1)

# Butterworth filter (Feel free to comment out the lines above unstead of these to use a different filter.)
#line1 = plt.fill_between(recon_times,flt.butterworth(np.percentile(gmt,hdr_bounds[0],axis=1),.1), \
#                         flt.butterworth(np.percentile(gmt,hdr_bounds[1],axis=1),.1),color='b',alpha=0.2)
#for i in random_indices: line2, = plt.plot(recon_times,flt.butterworth(gmt[:,i],.1),color='gray',linewidth=.5)

#line3, = plt.plot(recon_times,flt.butterworth(np.mean(gmt,axis=1),.1),color='k',linewidth=1)

plt.xlim(selected_years)
#plt.ylim(-1.5,1)
plt.title("Global-mean 2 m air temperature anomalies ($^\circ$C), "+str(window_size)+           "-year sliding mean.\nExperiment: "+experiment_name,fontsize=20)
plt.xlabel("Year",fontsize=16)
plt.ylabel("Temperature anomaly ($^\circ$C)",fontsize=16)
plt.legend([line1,line3,line2],["HDR","Mean","Sample members"],loc=2,fontsize=16)
plt.show()


# ## Discussion Question
# 
# Why does the highest density region become narrower toward the present?

# ## Figure 2. Northern and Southern Hemisphere mean temperature anomalies through time.
# 
# In addition to global-mean temperatures, this file contains NH and SH-mean temperatures.  Lets make a figure with both of these hemispheric means plotted.

# In[16]:

# FIGURE 2: Plot the NH and SH reanalyses.
plt.figure(figsize=(20,11))
plt.axes([.1,.1,.8,.8])
line1 = plt.fill_between(years,boxcar(np.percentile(nhmt,hdr_bounds[0],axis=1),window_size),                          boxcar(np.percentile(nhmt,hdr_bounds[1],axis=1),window_size),color='r',alpha=0.2)
line2 = plt.fill_between(years,boxcar(np.percentile(shmt,hdr_bounds[0],axis=1),window_size),                          boxcar(np.percentile(shmt,hdr_bounds[1],axis=1),window_size),color='m',alpha=0.2)
line3, = plt.plot(years,boxcar(np.mean(nhmt,axis=1),window_size),color='r',linewidth=1)
line4, = plt.plot(years,boxcar(np.mean(shmt,axis=1),window_size),color='m',linewidth=1)
plt.xlim(selected_years)
#plt.ylim(-1.5,1)
plt.title("NH and SH mean 2 m air temperature anomalies ($^\circ$C), "+str(window_size)+           "-year sliding mean.\nExperiment: "+experiment_name,fontsize=20)
plt.xlabel("Year",fontsize=16)
plt.ylabel("Temperature anomaly ($^\circ$C)",fontsize=16)
plt.legend([line1,line3,line2,line4],["NH HDR","NH mean","SH HDR","SH mean"],loc=2,ncol=2,fontsize=16)
plt.show()


# ## Figure 3. Distribution of temperature anomalies.
# 
# As explained above, the LMR produces a collection of possible results.  This is partially shown in the shaded "highest density region" above, but let's plot histograms for individual years to see this more clearly.

# In[17]:

# Use the shape command to remind ourselves what the data array looks like.
print(gmt.shape)


# In[18]:

# FIGURE 3: Probability density functions of specific years.

# Specify the years you want to see probability density functions for.
years_pdf = [1850,2000]
# Find the indices of the years listed above using "list comprehension".
index_of_years = [recon_times.tolist().index(year) for year in years_pdf]
nyears_pdf = len(years_pdf)

# Use the subplot function to create multiple plots.
f, ax = plt.subplots(nyears_pdf,1,figsize=(20,11),sharex=True,sharey=True)
ax = ax.ravel()
for i in range(nyears_pdf):
    ax[i].set_title("Year "+str(years_pdf[i]))
    ax[i].hist(gmt[years_pdf[i],:],40)
    ax[i].set_ylabel("Frequency of occurance",fontsize=16)
    ax[i].set_xlabel("Temperature anomalies ($^\circ$C)",fontsize=16)

f.suptitle("Probability density functions of temperature anomalies at specific years.",fontsize=20)
f.tight_layout()
f.subplots_adjust(top=.9)
plt.show()


# ## Exploring variables
# 
# If you're unsure about the purpose or contents of any of the variables we're using, feel free to take a look at a variable with the **shape** (for arrays) or **print** commands to get a better idea of its contents, as follows:

# In[19]:

print(recon_times.shape)


# In[20]:

print(recon_times)


# ## Further exploration
# 
# Modify the options in the code above to change the figures, or modify other parts of the code. 

# ## Questions and discussion
# 
# What remains unclear?  What looks interesting?

# In[ ]:



