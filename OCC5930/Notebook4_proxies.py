
# coding: utf-8

# # Notebook #4: The proxy database
# 
# In this script, we'll take a look at one of the LMR inputs: the proxy database.
# 
# One of the initial steps of running the LMR is to preprocess the proxy network.  This step puts the data into a standard format and calculates annual-mean values, among other things.  Let's take a look at these standard files.

# In[1]:

# A non-python command to make sure all figures are plotted on this page.
get_ipython().magic(u'matplotlib inline')


# In[2]:

# Import the necessary python packages 
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


# In[3]:

# Load the proxy data and metadata using the pandas library.
proxies = pd.read_pickle('../LMR_data/data/proxies/Pages2kv1_Proxies.df.pckl')
metadata = pd.read_pickle('../LMR_data/data/proxies/Pages2kv1_Metadata.df.pckl')


# In[4]:

# The "type" and "shape" commands can be used to learn more about the data set.
# The proxy data:
print(type(proxies))
print(proxies.shape)


# In[5]:

# The proxy metadata:
print(type(metadata))
print(metadata.shape)


# In[6]:

# Let's look at the contents of the proxy file.
print(proxies)


# In[7]:

# The "keys" command shows all of the keys for this dataset.
print(proxies.keys())


# In[8]:

# Display all of the fields in the metadata file.
print(metadata.keys())


# In[9]:

# As an example, plot the metadata of the first record.
# Loop through every element of the metadata and print it to screen.
for key in metadata.keys():
    print('%27s : %20s' % (key, metadata.loc[100][key]))


# In[10]:

# We can write some code to search the metadata for a proxy we're interested in.
search_string = 'Europe'
field_to_search = 'PAGES 2k Region'

#search_string = 'lake'
#field_to_search = 'Archive type'

# Loop through every key.  If part of the key matches the the search string, print the index and the key.
n_proxies = metadata.shape[0]
print('%5s: %20s: %20s: %20s:' % ('index','Site','Country/Region','Archive type'))
for i in range(n_proxies):
    if isinstance(metadata.loc[i][field_to_search], basestring):
        if search_string.lower() in metadata.loc[i][field_to_search].lower():
            print('%5s: %20s, %20s, %20s' % (i, metadata.loc[i]['Site'], metadata.loc[i]['Country/Region'],                                              metadata.loc[i]['Archive type']))


# In[11]:

# Choose the index of a record you're interested in.
index_selected = 344


# In[12]:

# Loop through every element of the metadata and print it to screen.
for key in metadata.keys():
    print('%27s : %20s' % (key, metadata.loc[index_selected][key]))


# In[13]:

# Get the key of the desired record.
proxyID_selected = metadata.loc[index_selected]['Proxy ID']
print(proxyID_selected)

# Get the data for this record.
proxy_data = proxies[proxyID_selected]


# In[14]:

# Save some useful metadata to new variables.
reference    = metadata.loc[index_selected]['Reference']
site_name    = metadata.loc[index_selected]['Site']
lat          = metadata.loc[index_selected]['Lat (N)']
lon          = metadata.loc[index_selected]['Lon (E)']
archive_type = metadata.loc[index_selected]['Archive type']
measurement  = metadata.loc[index_selected]['Proxy measurement']


# In[15]:

# Make a figure of the proxy record.
plt.style.use('ggplot')

plt.figure(figsize=(15,5))
ax = plt.axes([.1,.1,.8,.8])
plt.plot(proxy_data,color='k',marker='o',linewidth=1)
plt.title(str(site_name)+" ("+str(archive_type)+").  Lat: "+str(lat)+"$^\circ$N, Lon: "+          str(lon)+"$^\circ$E\nReference: "+reference[0:100])
plt.xlabel("Year")
plt.ylabel(measurement)
plt.show()


# ## Further exploration
# 
# Search for a different record and look at the results.

# ### Discussion
# 
# Use of data from both proxy records and climate models is crucial to the advancement of paleoclimate research.
# * How many of you primarily work with proxy records?
# * How many of you primarily work with model output?
# * Do you often use data from both areas?

# In[ ]:



