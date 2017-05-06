N1=dlmread('N1hmD1_04.txt');
N2=dlmread('N2hmD1_04.txt');

sw1=linspace(0.001, 0.15, 100);
sw2=linspace(0.001, 0.15, 100);
N=5000;

count=0;
    for i=1:100
        for j=1:100
            if mask(i,j,N1)>25
                count=count+1;
            end
        end
    end
 display(count);
 
 st=0;
while check(N1)
    for i=100:-1:1
        for j=100:-1:1
            if (mask(i,j,N1)>25)
                [p,q]=find(i,j,N1);
                if (p>0)
                    D11=zeros(1, N);
                    D12=zeros(1, N);
                    D22=zeros(1, N);
                    N1_st=0;
                    N2_st=0;
                    [N1_st, N2_st, D11_st, D12_st, D22_st]=sol(N1_st, N2_st, D11, D12, D22, sw1(p), sw2(q));
                    [N1(i,j), N2(i,j), ~, ~, ~]=sol(N1_st, N2_st, D11_st, D12_st, D22_st, sw1(i), sw2(j));    
                    st=st+1;
                    display(st);
                end
            end
        end
    end
    if (st>count*2)
        break;
    end
end

% for i=1:100
%     for j=1:100
%         if mask(i,j,N1)>25
%             N1(i,j)=NaN;
%         end
%     end
% end
% 
% [X, Y]=meshgrid(sw1, sw2);
% 
% N1=interp2(X, Y, N1, X, Y);

figure;
surf(sw1, sw2, N1);




function res=mask(x_i,x_j, A)
    B=zeros(102, 102);
    for i_l=1:100
        for j_l=1:100
            B(i_l+1, j_l+1)=A(i_l, j_l);
        end
    end
    for i=1:100
        B(1, i+1)=B(2, i+1);
        B(102, i+1)=B(101, i+1);
        B(i+1, 1)=B(i+1, 2);
        B(i+1, 102)=B(i+1, 101);
    end
    i=x_i+1;
    j=x_j+1;
    temp=abs(B(i,j)-B(i+1,j))+abs(B(i,j)-B(i-1,j))+abs(B(i,j)-B(i,j+1))+abs(B(i,j)-B(i,j-1));
    res=temp/4;
            
end

function res=check(A)
    for i=1:100
        for j=1:100
            if mask(i,j,A)>25
                res=1;
                return
            end
        end
    end
    res=0;
end

function [x, y]=find(i,j,A)
    if (i>1)
        if mask(i-1, j, A)<25
            x=i-1; y=j;
            return;
        end
    end
    if (i<100)
        if mask(i+1, j, A)<25
            x=i+1; y=j;
            return;
        end
    end
    if (j>1)
        if mask(i, j-1, A)<25
            x=i; y=j-1;
            return;
        end
    end
    if (j<100)
        if mask(i, j+1, A)<25
            x=i; y=j+1;
            return;
        end
    end
    x=0; y=0;
end

function [N1, N2, D11, D12, D22]=sol(N1, N2, D11, D12, D22, sw1, sw2)
    N=5000;
    A=2;
    r=linspace(0, A, N);
    h=r(2)-r(1);
    sm1=0.04; sm2=0.06;
    b1=0.4; b2=0.4;
    d1=0.2; d2=0.2;
    d11=0.001; d12=0.001; d21=0.001; d22=0.001;
    m1=b1*normpdf(r, 0, sm1);
    m2=b2*normpdf(r, 0, sm2);             
    al=0.4;
    
            w11=d11*normpdf(r, 0, sw1);
            w12=d12*normpdf(r, 0, sw2);
            w21=d21*normpdf(r, 0, sw2);
            w22=d22*normpdf(r, 0, sw1);       
           
    [N1, N2, D11, D12, D22, ~]=solver(N1, N2, D11, D12, D22, w11, w12, w21, w22, d11, d12, d21, d22, m1, m2, b1, b2, d1, d2, h, A, al, N, 1);            
end


