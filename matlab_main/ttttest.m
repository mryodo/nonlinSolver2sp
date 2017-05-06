d12=linspace(0, 0.0015, 100);
sm2=linspace(0.00001, 0.2, 100);

 
  N1_ans=dlmread('N1cctoD3_04_d.txt');
    N2_ans=dlmread('N2cctoD3_04_d.txt');
    figure;
    hold on;
    grid on;
    surf(sm2, d12, N1_ans);
    surf(sm2, d12, N2_ans);