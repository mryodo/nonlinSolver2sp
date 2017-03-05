import numpy as np
import scipy.stats as st
from math import *
import numpy as np
import matplotlib
#matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.animation as manimation


fig = plt.figure()
ax = plt.axes(xlim=(-1, 1), ylim=(-1, 1))
l1, = ax.plot([], [], 'rx')
l2, = ax.plot([], [], 'bx')

def init():
    l1.set_data([], [])
    l2.set_data([], [])
    return l1, l2,


def normpdf(x, mu, sigma):
    u = (x-mu)/abs(sigma)
    y = (1/(sqrt(2*pi)*abs(sigma)))*exp(-u*u/2)
    return y


A=1
N=200

sm1=0.4 
sm2=0.6
b1=0.3 
b2=0.3
d1=0.2
d2=0.2
d11=0.01 
d12=0.01 
d21=0.01 
d22=0.01
sw11=0.3
sw22=0.15
sw12=0.4 
sw21=0.1

x1, y1= np.random.uniform(-1, 1, (N, 2)).T
x2, y2= np.random.uniform(-1, 1, (N, 2)).T
x1=np.ndarray.tolist(x1)
x2=np.ndarray.tolist(x2)
y1=np.ndarray.tolist(y1)
y2=np.ndarray.tolist(y2)


def generate_harm(xx, yy, x1, y1, x2, y2, d1, d11, sw11, d21, sw21):
    death=d1
    for j in range(len(x1)):
        death+=d11*normpdf(sqrt(pow(xx-x1[j], 2)+pow(yy-y1[j], 2)), 0, sw11)
    for j in range(len(x2)):
        death+=d21*normpdf(sqrt(pow(xx-x2[j], 2)+pow(yy-y2[j], 2)), 0, sw21)
    return death

death1=[0]*N
death2=[0]*N

for i in range(N):
    death1[i]=generate_harm(x1[i], y1[i], x1, y1, x2, y2, d1, d11, sw11, d21, sw21)
    death2[i]=generate_harm(x2[i], y2[i], x2, y2, x1, y1, d2, d22, sw22, d12, sw12)



def birth(x,y,b,sm, x2,y2,d1,d11,sw11,d21,sw21):
    x_gen=[]
    y_gen=[]
    d_gen=[]
    for i in range(len(x)):
        if (np.random.random_sample()<b):
            mean=[0, 0]
            cov=[[sm*sm,0],[0,sm*sm]]
            dx, dy=np.random.multivariate_normal(mean, cov, (1,1)).T
            x_gen.append((x[i]+dx[0,0]+A)%(2*A)-A)
            y_gen.append((y[i]+dy[0,0]+A)%(2*A)-A)
            d_gen.append(generate_harm(x[i]+dx[0,0],y[i]+dy[0,0],x,y,x2,y2,d1,d11,sw11,d21,sw21))
    return x_gen, y_gen, d_gen

def upd_on_death(xx, yy, x1, y1, x2, y2, d11, sw11, d12, sw12, death1, death2):
    for i in range(len(x1)):
        if not((x1[i]==xx) and (y1[i]==yy)):
            death1[i]-=d11*normpdf(sqrt(pow(xx-x1[i], 2)+pow(yy-y1[i], 2)), 0, sw11)
    for i in range(len(x2)):
        death2[i]-=d12*normpdf(sqrt(pow(xx-x2[i], 2)+pow(yy-y2[i], 2)), 0, sw12)



def step(x1, y1, x2, y2, death1, death2, b1, sm1, b2, sm2, d1, d2, d11, sw11, d12, sw12, d21, sw21, d22, sw22):
    x_gen, y_gen, d_gen=birth(x1, y1, b1, sm1, x2, y2, d1, d11, sw11, d21, sw21)
    x1.extend(x_gen)
    y1.extend(y_gen)
    death1.extend(d_gen)

    x_gen, y_gen, d_gen=birth(x2, y2, b2, sm2, x1, y1, d2, d22, sw22, d12, sw12)
    x2.extend(x_gen)
    y2.extend(y_gen)
    death2.extend(d_gen)
    
    elim1=[]
    elim1_x=[]
    elim1_y=[]
    elim1_d=[]
    elim2=[]
    elim2_x=[]
    elim2_y=[]
    elim2_d=[]

    for i in range(len(x1)):
        if (np.random.random_sample()<death1[i]):
            elim1.append(i)
            elim1_x.append(x1[i])
            elim1_y.append(y1[i])


    for i in range(len(x2)):
        if (np.random.random_sample()<death2[i]):
            elim2.append(i)
            elim2_x.append(x2[i])
            elim2_y.append(y2[i])


    for i in elim1:
        upd_on_death(x1[i], y1[i], x1, y1, x2, y2, d11, sw11, d12, sw12, death1, death2)

    for i in elim2:
        upd_on_death(x2[i], y2[i], x2, y2, x1, y1, d22, sw22, d21, sw21, death2, death1)

    for i in elim1:
        elim1_d.append(death1[i])
    for i in elim2:
        elim2_d.append(death2[i])
    
    for i in range(len(elim1)):
        #print(i, len(elim1_x), len(x1))
        x1.remove(elim1_x[i])
        y1.remove(elim1_y[i])
        death1.remove(elim1_d[i])

    for i in range(len(elim2)):
        x2.remove(elim2_x[i])
        y2.remove(elim2_y[i])
        death2.remove(elim2_d[i])
    
    return x1, y1, x2, y2, death1, death2

def animate(k):
    global x1, y1, x2, y2, death1, death2, b1, sm1, b2, sm2, d1, d2, d11, sw11, d12, sw12, d21, sw21, d22, sw22 
    x1, y1, x2, y2, death1, death2 = step(x1, y1, x2, y2, death1, death2, b1, sm1, b2, sm2, d1, d2, d11, sw11, d12, sw12, d21, sw21, d22, sw22)
    print(len(x1), len(x2), k)

    l1.set_data(x1, y1)
    l2.set_data(x2, y2)

    return l1, l2,

anim = manimation.FuncAnimation(fig, animate, init_func=init,
                               frames=50, blit=True)

anim.save('basic_animation_FUN_long_D.mp4', fps=3, extra_args=['-vcodec', 'libx264'])


#plt.show()
