function [rh, D] = sp1_interest()
    rad_2d_norm = @(r, s)(normpdf(r, 0, s) .* normpdf(zeros(size(r)), 0, s));
    
    N = 3001;
    A = 2;
    a = 0.4;

    b = 1; dd = 0.01; d = 0;
    
    rh = linspace(0, A, N);
    kh = pi/A * rh;
    h = rh(2:end) - rh(1:end-1);
    h = ([0 h] + [h 0])/2;
    
    [~, I] = ht(rh, rh, kh);
    [~, J] = iht(rh, kh, rh);
    
    sigma_m=[0.01 0.9 0.01 0.9 0.5 1.01 0.2 0.8 0.5 0.1];
    sigma_w=[0.01 0.01 0.9 0.9 0.5 1.01 0.8 0.2 0.1 0.1];
    Z=zeros(length(sigma_m), length(sigma_w));
    y = NaN;
    for i=2:2
        D=zeros(1, N);
       
        for j=2:2
           if (i==j) 
            m = @(x)(rad_2d_norm(x, sigma_m(i)));
            w = @(x)(rad_2d_norm(x, sigma_w(j)));
            [rh, D, y, err] = solve_iter_sym(D, b, d, dd, w, m, h, rh, kh, I, J, a, 500);
            Z(i, j)=(b-d)/y;
            
                dlmwrite('N.txt', Z(i,j));
                dlmwrite('D.txt', D);
                dlmwrite('sm.txt', sigma_m(i));
                dlmwrite('sw.txt', sigma_w(j));
                dlmwrite('d.txt', d);
                dlmwrite('b.txt', b);
                dlmwrite('dd.txt', dd);
                dlmwrite('dots.txt', N);
                dlmwrite('area.txt', A);
                dlmwrite('alph.txt', a);
                plot(rh, D);
                %fclose('all');
            %disp([num2str((i-1)*length(sigma_m)+j), '/', num2str(length(sigma_m)*length(sigma_w)), ' ', num2str(y)]);
           end
        end
    end
end

function [rh, D, y, err] = solve_iter_sym(D, b, d, dd, w, m, h, rh, kh, I, J, a, max_iter)
    w = dd * w(rh);
    m = b * m(rh);
    
    y = sum(2 * pi * h .* rh .* w .* D) + dd;
    prev_err = Inf;
    
    for iter=1:max_iter
        z = y/(b - d);
        D = recalc_nonlinear_comb(z, m, w, b, d, dd, D, a, rh, kh, I, J);
        y_new = sum(2 * pi * h .* rh .* w .* D) + dd;
        err = abs(y_new - y);
        if ((err < 1e-8) || (err > prev_err) || isnan(err))
            if ((err > prev_err) || isnan(err))
                y = NaN;
            end
            return
        end
        prev_err = err;
        y = y_new;
    end
end

function c = htconv(a, b, rh, kh, I, J)
    c = iht(ht(a, rh, kh, I) .* ht(b, rh, kh, I), kh, rh, J);
end

function D = recalc_nonlinear_comb(z, m, w, b, d, dd, D, a, rh, kh, I, J)
        first = z * m - w +  htconv(m, D, rh, kh, I, J) - a/(2*z) * ((D + 2) .* htconv(w, D, rh, kh, I, J) + htconv(D, w .* D, rh, kh, I, J));
        second = w + b - a/2 * (b - d - dd/z);
        D = first ./ second;
end