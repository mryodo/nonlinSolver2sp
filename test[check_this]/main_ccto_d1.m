function main_ccto_d1()
    N=512;
    A=2;
    r=linspace(0, A, N);
    h=r(2)-r(1);
    sm1=0.04; sm2=0.1;
    b1=0.4; b2=0.4;
    d1=0.2; d2=0.2;
    d11=0.001; d12=0.0005; d21=0.001; d22=0.001;
    sw11=0.04; sw22=0.04;
    sw12=0.04; sw21=0.04;
    
    m1=b1*normpdf(r, 0, sm1);
    
    
    w11=d11*normpdf(r, 0, sw11);
    
    w21=d21*normpdf(r, 0, sw21);
    w22=d22*normpdf(r, 0, sw22);
    
    al=0.4;
    N1=0;
    N2=0;
    
    d12=linspace(0.0009, 0.0012, 100);
    %sm2=linspace(0.000001, 0.2, 100);
    
    sm2=0.1;
    
    N1_ans=zeros(length(d12), 1);
    N2_ans=zeros(length(d12), 1);
    for i=1:length(d12)
        %for j=1:length(sm2)
            m2=b2*normpdf(r, 0, sm2);
            w12=d12(i)*normpdf(r, 0, sw12);
            
            D11=zeros(1, N);
            D12=zeros(1, N);
            D22=zeros(1, N);
            N1=0;
            N2=0;
            
            [N1, N2, ~, ~, ~, ~]=solver(N1, N2, D11, D12, D22, w11, w12, w21, w22, d11, d12(i), d21, d22, m1, m2, b1, b2, d1, d2, h, A, al, N, 1);
            N1_ans(i)=N1;
            N2_ans(i)=N2;
            display(i);
        %end
    end
    dlmwrite('SHITN1cctoD1_04_d_test_2.txt', N1_ans);
    dlmwrite('SHITN2cctoD1_04_d_test_2.txt', N2_ans);
    figure;
    hold on;
    grid on;
    plot(d12, N1_ans);
    plot(d12, N2_ans);
    
end
