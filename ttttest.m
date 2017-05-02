d12=linspace(0, 0.0015, 150);
sm2=linspace(0.00001, 0.2, 150);

  N1_ans=zeros(length(d12), length(sm2));
    N2_ans=zeros(length(d12), length(sm2));
  N1_ans=dlmread('N1cctoD1_04_d.txt');
    N2_ans=dlmread('N2cctoD1_04_d.txt');
    figure;
    hold on;
    grid on;
    surf(d12, sm2, N1_ans);
    surf(d12, sm2, N2_ans);