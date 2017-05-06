function res=conv_dim(u, v, N, A, dim, I, J)
    if dim == 1
        res=conv(u, v, 'same');
    end
    if dim == 2
        r=linspace(0, A, N);
        k=pi/A*r;
        res=iht(ht(u, r, k, I) .* ht(v, r, k, I), k, r, J);
    end
    if dim == 3
        r=linspace(0, A, N);
        res=4*pi*conv((u.*r), v, 'same');
    end
end