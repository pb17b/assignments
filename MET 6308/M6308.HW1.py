# -*- coding: utf-8 -*-
"""
Created on Mon Sep 13 17:50:09 2021

@author: parke
"""
import numpy as np
import matplotlib.pyplot as plt

dU = 10
B = 1e3
L = 300e3
d = 100
nx = 100
n = 10
x = []
x = [0 for i in range(nx)]
D = 15000
nz = 50
Z = np.zeros(nz)
m = 20
wz = np.zeros(nz)

u = []
u = [0 for i in range(nx)]
c = 100
#f = 0
f = .0001
nt = 20
dt = 600
t = []
t = [0 for i in range(nt)]

for i in range(0, nx):
    x[i] = i*(L/nx)
    u[i] = (dU)/(1+((x[i]-L/2)**2)/B**2)
    
for i in range(0, nz):
    Z[i] = i*(D/nz)
    wz[i] = (1)/(1+((Z[i]-D/2)**2)/d**2)

for i in range(0, nt):
    t[i] = i*dt
#print(u)
#plt.plot(u)

An = []
An = np.zeros([n])
Kn = []
Kn = np.zeros([n])
Wn = []
Wn = np.zeros([n, m])
Mn = []
Mn = np.zeros([m])
Bn = []
Bn = np.zeros([m])

ubuilt2 = np.ones((nz, nx, nt))
#ubuilt = [0 for i in range(nx)]
Ns = .01
for i in range(0, n):
    Kn[i] = (i*np.pi)/L
    An[i] = np.sum(u*np.sin(np.multiply(Kn[i],x)))*(2/L)
    Wn[i] = np.sqrt(((c**2)*(Kn[i]**2)+(f**2)))

for i in range(0, m):
    Mn[i] = (i*np.pi)/D
    Bn[i] = np.sum(wz*np.sin(np.multiply(Mn[i],Z)))*(2/D)
    for j in range(0,n):    
        Wn[j,i] = np.sqrt(((Ns**2)*Kn[j]**2)/((Kn[j]**2)+Mn[j]**2+1e-9))


for j in range(0, nt):
    
    for i in range(0, nx):
        for iz in range(0,nz):
            sumM = 0
            for im in range(0,m):
                sumM = sumM + np.sum(An*Bn[im] *  (np.sin(Mn[im]*Z[iz])) * np.sin((Kn*x[i]))*(np.cos((Wn[:,im]*t[j]))))/2
               # ubuilt2[iz,i,j] = np.sum(An*np.sin(np.multiply(Kn,x[i]))*(np.cos(np.multiply(Wn,t[j]))))/2
            ubuilt2[iz,i,j]=sumM
    
print(ubuilt2)

#i thinkneed different length 
for i in range(nt):
    plt.contour(x,Z,ubuilt2[:,:,i])
    plt.xlabel('Length (m)')
    plt.ylabel('Depth (m)')
    #plt.ylim(-5,5)
    plt.show()
    

    






