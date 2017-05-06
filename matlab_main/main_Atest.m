function main()
    N=1000;
    A=2;
   
    
    al=0.4;
    %k=101:1:110;
    figure;
    hold on;
    A=1:.1:10;
    N1_ans=zeros(1, length(A));
    N2_ans=zeros(1, length(A));
    for i=1:length(A) 
        N=floor(1000*A(i));
    r=linspace(0, A(i), N);
    h=r(2)-r(1);
    sm1=0.06; sm2=0.06;
    b1=0.4; b2=0.4;
    d1=0.2; d2=0.2;
    d11=0.001; d12=0.001; d21=0.001; d22=0.001;
    sw11=0.04; sw22=0.06;
    sw12=0.01; sw21=0.02;
    
    m1=b1*normpdf(r, 0, sm1);
    m2=b2*normpdf(r, 0, sm2);
    
    w11=d11*normpdf(r, 0, sw11);
    w12=d12*normpdf(r, 0, sw12);
    w21=d21*normpdf(r, 0, sw21);
    w22=d22*normpdf(r, 0, sw22);
    
    D11=zeros(1, N);
    D12=zeros(1, N);
    D22=zeros(1, N);
        N1=100;
        N2=100;
        [N1_ans(i), N2_ans(i), D11, D12, D22, mistake, iter]=solver(N1, N2, D11, D12, D22, w11, w12, w21, w22, d11, d12, d21, d22, m1, m2, b1, b2, d1, d2, h, A(i), al, N, 1);
        display(iter);
        r=linspace(0, A(i), N);
        plot(r, D11);
    end
    figure;
    hold on;
    grid on;
    plot(A, N1_ans);
    %plot(k, N2_ans);
end
