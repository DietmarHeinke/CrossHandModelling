vr = 0.7;
left = normrnd(-1,vr)
right = normrnd(1,vr);
mu_l = -1;
l = mu_l + sqrt(vr)*randn(1000,1);
histogram(l,20)
hold on
mu_r = 1;
r = mu_r + sqrt(vr)*randn(1000,1);
histogram(r,20)
hold off

