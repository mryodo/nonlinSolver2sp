import numpy as np
from math import *


def y_calc(w, C, d, h, N, A, dim):
    if (dim == 1):
        return h*sum(np.multiply(w, C))+d
    if (dim == 2):
        r=np.linspace(0, A, N)
        return 2*pi*h*sum(np.multiply(w, C))+d
    if (dim == 3):
        r=np.linspace(0, A, N)
        return 4*pi*h*sum(np.multiply(w, np.multiply(C, np.multiply(r, r))))+d
