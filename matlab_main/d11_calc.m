function res=d11_calc(D11, D12, m1, w11, w12, b1, d1, d11, d12, N1, N2, al, A, N, dim, I, J)
    left=((1-al/2)*b1+al/2*(d1+N1*d11+N2*d12))*ones(1,N)+w11;
    right=conv_dim(m1, D11, N, A, dim, I, J)-al/2*N1*((D11+2*ones(1,N)).*conv_dim(w11, D11, N, A, dim, I, J)+conv_dim(w11.*D11, D11, N, A, dim, I, J))-al/2*N2*((D11+2*ones(1,N)).*conv_dim(w12, D12, N, A, dim, I, J)+conv_dim(w12.*D12, D12, N, A, dim, I, J));
    right=right+(1/N1)*m1-w11;
    res=right./left;
end