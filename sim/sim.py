import matplotlib.pyplot as plt
import numpy as np
import scipy.stats as st
import math

A=10
N=100

sm1=0.04 
sm2=0.06
b1=0.4 
b2=0.4
d1=0.2
d2=0.2
d11=0.001 
d12=0.001 
d21=0.001 
d22=0.001
sw11=0.1 
sw22=0.1
sw12=0.05 
sw21=0.05

x1, y1= np.random.uniform(-1, 1, (N, 2)).T
x2, y2= np.random.uniform(-1, 1, (N, 2)).T
x1=np.ndarray.tolist(x1)
x2=np.ndarray.tolist(x2)
y1=np.ndarray.tolist(y1)
y2=np.ndarray.tolist(y2)

#plt.plot(x1, y1, 'ob')
#plt.plot(x2, y2, 'or')

#count=0


for k in range(50):
    x_gen=[]
    y_gen=[]

    for i in range(len(x1)):
        if (np.random.random_sample()<b1):
    #      count+=1
            mean=[0, 0]
            cov=[[sm1*sm1,0],[0,sm1*sm1]]
            dx, dy=np.random.multivariate_normal(mean, cov, (1,1)).T
            x_gen.append(x1[i]+dx[0,0])
            y_gen.append(y1[i]+dy[0,0])
    #       print(count, i, dx, dy)

    #plt.plot(x_gen, y_gen, 'g^')

    x1.extend(x_gen)
    y1.extend(y_gen)

    #print(len(x_gen), len(y_gen))



    count=0

    x_gen=[]
    y_gen=[]

    for i in range(len(x2)):
        if (np.random.random_sample()<b2):
    #      count+=1
            mean=[0, 0]
            cov=[[sm2*sm2,0],[0,sm2*sm2]]
            dx, dy=np.random.multivariate_normal(mean, cov, (1,1)).T
            x_gen.append(x2[i]+dx[0,0])
            y_gen.append(y2[i]+dy[0,0])
    #       print(count, i, dx, dy)

    #plt.plot(x_gen, y_gen, 'y^')

    x2.extend(x_gen)
    y2.extend(y_gen)

    #print(len(x_gen), len(y_gen))

    x1_die=[]
    x2_die=[]
    y1_die=[]
    y2_die=[]

    for i in range(len(x1)):
        death=d1
        for j in range(len(x1)):
            if (i != j):
                death+=d11*st.norm.pdf(math.sqrt(math.pow(x1[i]-x1[j], 2)+math.pow(y1[i]-y1[j], 2)), 0, sw11)
        for j in range(len(x2)):
            death+=d21*st.norm.pdf(math.sqrt(math.pow(x1[i]-x2[j], 2)+math.pow(y1[i]-y2[j], 2)), 0, sw21)
        if (np.random.random_sample()<death):
            x1_die.append(x1[i])
            y1_die.append(y1[i])


    for i in range(len(x2)):
        death=d2
        for j in range(len(x2)):
            if (i != j):
                death+=d22*st.norm.pdf(math.sqrt(math.pow(x2[i]-x2[j], 2)+math.pow(y2[i]-y2[j], 2)), 0, sw22)
        for j in range(len(x1)):
            death+=d12*st.norm.pdf(math.sqrt(math.pow(x2[i]-x1[j], 2)+math.pow(y2[i]-y1[j], 2)), 0, sw12)
        if (np.random.random_sample()<death):
            x2_die.append(x2[i])
            y2_die.append(y2[i])
    #plt.plot(x1_die, y1_die, 'mX')
    #plt.plot(x2_die, y2_die, 'cX')


    for i in range(len(x1_die)):
        x1.remove(x1_die[i])
        y1.remove(y1_die[i])

    for i in range(len(x2_die)):
        x2.remove(x2_die[i])
        y2.remove(y2_die[i])

    print(len(x1), len(x2))





plt.plot(x1, y1, 'rx')
plt.plot(x2, y2, 'bx')


plt.show()
