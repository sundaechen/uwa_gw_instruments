
# coding: utf-8

# In[1]:


import visa
import time
import csv
import numpy as np
#import matplotlib.pyplot as plt
#get_ipython().run_line_magic('matplotlib', 'inline')


# In[2]:


rm=visa.ResourceManager()
print(rm.list_resources())


# In[3]:


inst=rm.open_resource('ASRL3::INSTR')
print("connected")


# In[4]:


A=inst.query('DSPY ? 1')


# In[5]:


A=A.split(',')
A=np.array(A)
A=A.astype(float)


# In[6]:


# value of y
#plt.plot(A)


# In[7]:


def readdata():
   # print(inst.query('*IDN?'))
    A=inst.query('DSPY ? 1')

    N=int(inst.query('DSPN ? 1'))-2
    MaxFString=inst.query('DBIN ? 0, ' + str(N))
    N2=len(MaxFString)-1
    MaxF=float(MaxFString[:N2])
    MinF=float(inst.query('DBIN ? 0, 0'))

    As=[]
    for I in range(0,N+1,1):
        As = As + [float(A[I*16:I*16+15])]

    Xs=[]
    for I in range(0,N+1,1):
        Xs = Xs + [MinF+I*(MaxF-MinF)/N]
    
    return As, Xs


# In[8]:


[As, Xs]=readdata()


# In[9]:


def savedata(name, As,Xs):    
    filename = name + '.csv'
    print(filename)    

    with open(filename,'w') as fp:
        writer = csv.writer(fp, delimiter=',')
        writer.writerows([Xs]+[As])


# In[10]:


savedata('notitle', As, Xs)

