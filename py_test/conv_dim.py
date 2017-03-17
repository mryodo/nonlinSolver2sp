import numpy as np
from math import *
from hankel import hankel

def conv_dim(u, v, N, A, dim, I, J)
    if (dim == 1):
        return np.convolve(u, v, 'same')
    if (dim == 2):
        r=linspace(0, A, N)
        k=pi/A*r
        res=iht(ht(u, r, k, I) .* ht(v, r, k, I), k, r, J)
    if (dim == 3):
        r=np.linspace(0, A, N)
        return 4*pi*np.convolve(np.multiply(u, r), v, 'same')
