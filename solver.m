function [N1, N2, D11, D12, D22, iter]=solver(N1, N2, D11, D12, D22, w11, w12, w21, w22, d11, d12, d21, d22, m1, m2, b1, b2, d1, d2, h, A, al, N, dim)
    eps=1e-8;
    eps2=1e-4;
    max_iter=500;
    y11_old=1; y12_old=1; y21_old=1; y22_old=1; mistake=1;
    n1_old=100000; n2_old=100000; mistake2=1000;
    
    r=linspace(0, A, N);
    k=pi/A*r;
    [~, I]=ht(r, r, k);
    [~, J]=iht(r, k, r);

    iter=0;
    while (mistake>eps) &&  (iter<max_iter) && (mistake2>eps2)
        D12=d12_calc(D12, D11, D22, m1, m2, w11, w12, w21, w22, b1, b2, d1, d2, d11, d12, d21, d22, N1, N2, al, A, N, dim, I, J);
        temp=n_calc(D11, D12, D22, w11, w12, w21, w22, d11, d12, d21, d22, b1, b2, d1, d2, h, A, N, dim);
        N1=temp(1); N2=temp(2);    
        D11=d11_calc(D11, D12, m1, w11, w12, b1, d1, d11, d12, N1, N2, al, A, N, dim, I, J);
        D22=d22_calc(D22, D12, m2, w22, w21, b2, d2, d22, d21, N2, N1, al, A, N, dim, I, J);
        y11=y_calc(w11, D11, d11, h, N, A, dim);
        y12=y_calc(w12, D12, d12, h, N, A, dim);
        y21=y_calc(w21, D12, d21, h, N, A, dim);
        y22=y_calc(w22, D22, d22, h, N, A, dim);
        mistake=abs(y11-y11_old)/y11+abs(y12-y12_old)/y12+abs(y21-y21_old)/y21+abs(y22-y22_old)/y22;
        y11_old=y11; y12_old=y12; y21_old=y21; y22_old=y22;
        iter=iter+1;
        temp=n_calc(D11, D12, D22, w11, w12, w21, w22, d11, d12, d21, d22, b1, b2, d1, d2, h, A, N, dim);
        N1=temp(1); N2=temp(2);    
        mistake2=abs(N1-n1_old)+abs(N2-n2_old);
        n1_old=N1; n2_old=N2;
    end
    
end
