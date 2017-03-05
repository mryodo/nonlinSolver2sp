function sp1_int_Cor()
    N=3001;
    A=2;
    r=linspace(0, A, N);
    h=r(2)-r(1);
    
    sigma_m=[0.012 0.9 0.01 0.9 0.5 1.01 0.2 0.3 0.5 0.1];
    sigma_w=[0.012 0.01 0.9 0.9 0.5 1.01 0.8 0.01 0.1 0.1];
    
    b1=0.4; b2=0;
    d1=0.2; d2=0;
    d11=0.001; d12=0; d21=0; d22=0;
    w12=zeros(1, N);
    w21=zeros(1, N);
    w22=zeros(1, N);
    m2=zeros(1, N);
    al=0.4;
    N1=0;
    N2=0;
    
    for i=10:10
       
       m1=b1*normpdf(r, 0, sigma_m(i));
       w11=d11*normpdf(r, 0, sigma_w(i));
            
            D11=zeros(1, N);
            D12=zeros(1, N);
            D22=zeros(1, N);
            N1=0;
            N2=0;
            
            [N1_ans, ~, D11, ~, ~, ~]=solver(N1, N2, D11, D12, D22, w11, w12, w21, w22, d11, d12, d21, d22, m1, m2, b1, b2, d1, d2, h, A, al, N, 2);
            dlmwrite('N.txt', N1_ans);
                dlmwrite('D.txt', D11);
                dlmwrite('sm.txt', sigma_m(i));
                dlmwrite('sw.txt', sigma_w(i));
                dlmwrite('d.txt', d1);
                dlmwrite('b.txt', b1);
                dlmwrite('dd.txt', d11);
                dlmwrite('dots.txt', N);
                dlmwrite('area.txt', A);
                dlmwrite('alph.txt', al);
                plot(r, D11);
      
    end
    
end
