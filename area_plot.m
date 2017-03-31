N1=dlmread('N1hmD3_08.txt');
N2=dlmread('N2hmD3_08.txt');

N=100;

figure;
hold on;


for i=1:100
    for j=1:100
        
        if (alive(N1(i,j), N2(i,j)) == 3)
            plot(i, j, 'g*');
        else
            plot(i, j, 'b*');
        end
    end
end


function res=alive(a, b)
    eps=0.1;
    res=0;
    if (a<eps) && (b<eps)
        res=0;
    end
    if (a>eps) && (b<eps)
        res=1;
    end
    if (a<eps) && (b>eps)
        res=2;
    end
    if (a>eps) && (b>eps)
        res=3;
    end
end