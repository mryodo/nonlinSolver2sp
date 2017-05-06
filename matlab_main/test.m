N=100;
A=1;
r=linspace(0, A, N);
k=pi/A*r;
%v=r;

[~, I]=ht(r, r, k);
[~, J]=iht(r, k, r);
%u=hat(v, r, k, I);
figure;
hold on;
%grid on;
%plot(r, v, 'g');
%plot(r, u, 'r');
%f=ihat(u, k, r, J);
%f=hank(u, N, A)
%plot(r, f, 'b');

%plot(r, besselj(0, r));

%display(f(1)/v(1));
%display(f(50)/v(50));




mu = [0 0];
Sigma = [.1 0; 0 .1];
[X1,X2] = meshgrid(r,r);
u = mvnpdf([X1(:) X2(:)],mu,Sigma);
u = reshape(u,length(r),length(r));

%surf(r, r, F);
Sigma2 = [.2 0; 0 .2];
v = mvnpdf([X1(:) X2(:)],mu,Sigma2);
v = reshape(v,length(r),length(r));

Z=conv2(u, v);
p=Z(1, :);
%plot(r, p, 'b');

%u2=normpdf(r, 0, .1);
%v2=normpdf(r, 0, .2);

u2=u(1, :);
v2=v(1, :);
plot(r, u2, 'g');
plot(r, v2, 'y');

z2=iht(ht(u2, r, k, I) .* ht(v2, r, k, I), k, r, J);

plot(r, z2, 'r');

figure;
plot(r, z2 ./ p);

