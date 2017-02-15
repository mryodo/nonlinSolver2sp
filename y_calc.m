function res=y_calc(w, C, d, h, N, A, dim)
    % w - весовая функция конкуренции
    % C - корреляционная функция
    % h - шаг сетки
    % N - число узлов сетки
    % A - радиус-размер области
    % dim - размерность
    
    if dim == 1
        res = h*sum(w.*C)+d;
    end
    if dim == 2
        r = linspace(0, A, N);
        res = 2*pi*h*sum(w.*C.*r)+d;
    end
    if dim == 3
        r = linspace(0, A, N);
        res = 4*pi*sum(h.*w.*C.*r.*r)+d;
    end
end