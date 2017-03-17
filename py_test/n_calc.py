import numpy as np
from y_calc import y_calc

def n_calc(D11, D12, D22, w11, w12, w21, w22, d11, d12, d21, d22, b1, b2, d1, d2, h, A, N, dim)
    left=np.array([b1-d1, b2-d2]);
    y11=y_calc(w11, D11, d11, h, N, A, dim);
    y12=y_calc(w12, D12, d12, h, N, A, dim);
    y21=y_calc(w21, D12, d21, h, N, A, dim);
    y22=y_calc(w22, D22, d22, h, N, A, dim);
    right=np.array([[y11 y12], [y21 y22]]);
    res=np.linalg.solve(right, left)
    return res[0], res[1]


