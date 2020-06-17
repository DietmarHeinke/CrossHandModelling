function [wo,correct,y_exp, y_pred] = touch(I_L,I_R,crossed,w)
if (crossed==1)
    I_1 = 1;
    I_2 = -1;
else
    I_1 = -1;
    I_2 = 1;
end
alpha = 0.01;
x1 = I_1*w(1) + I_2*w(2);
x2 = I_1*w(3) + I_2*w(4);

y_L = x1*I_L*w(5) + x1*I_R*w(6) + x2*I_L*w(7) + x2*I_R*w(8);
y_R = x1*I_L*w(9) + x1*I_R*w(10) + x2*I_L*w(11) + x2*I_R*w(12);

y_exp = crossed * (I_L - I_R);
if (y_exp == -1 && y_L > y_R)
    w(5) = w(5) + alpha*x1*I_L;
    w(6) = w(6) + alpha*x1*I_R;
    w(7) = w(7) + alpha*x2*I_L;
    w(8) = w(8) + alpha*x2*I_R;
    w(1) = w(1) + alpha*(I_1*I_L*w(5) + I_1*I_R*w(6));
    w(2) = w(2) + alpha*(I_2*I_L*w(5) + I_2*I_R*w(6));
    w(3) = w(3) + alpha*(I_1*I_L*w(7) + I_1*I_R*w(8));
    w(4) = w(4) + alpha*(I_2*I_L*w(7) + I_2*I_R*w(8));
    correct=1;
end
if (y_exp == -1 && y_R > y_L)
    w(9) = w(9) - alpha*x1*I_L;
    w(10) = w(10) - alpha*x1*I_R;
    w(11) = w(11) - alpha*x2*I_L;
    w(12) = w(12) - alpha*x2*I_R;
    w(1) = w(1) - alpha*(I_1*I_L*w(9) + I_1*I_R*w(10));
    w(2) = w(2) - alpha*(I_2*I_L*w(9) + I_2*I_R*w(10));
    w(3) = w(3) - alpha*(I_1*I_L*w(11) + I_1*I_R*w(12));
    w(4) = w(4) - alpha*(I_2*I_L*w(11) + I_2*I_R*w(12));
    correct=0;
end
if (y_exp == 1 && y_L > y_R)
    w(5) = w(5) - alpha*x1*I_L;
    w(6) = w(6) - alpha*x1*I_R;
    w(7) = w(7) - alpha*x2*I_L;
    w(8) = w(8) - alpha*x2*I_R;
    w(1) = w(1) - alpha*(I_1*I_L*w(5) + I_1*I_R*w(6));
    w(2) = w(2) - alpha*(I_2*I_L*w(5) + I_2*I_R*w(6));
    w(3) = w(3) - alpha*(I_1*I_L*w(7) + I_1*I_R*w(8));
    w(4) = w(4) - alpha*(I_2*I_L*w(7) + I_2*I_R*w(8));
    correct=0;
end
if (y_exp == 1 && y_R > y_L)
    w(9) = w(9) + alpha*x1*I_L;
    w(10) = w(10) + alpha*x1*I_R;
    w(11) = w(11) + alpha*x2*I_L;
    w(12) = w(12) + alpha*x2*I_R;
    w(1) = w(1) + alpha*(I_1*I_L*w(9) + I_1*I_R*w(10));
    w(2) = w(2) + alpha*(I_2*I_L*w(9) + I_2*I_R*w(10));
    w(3) = w(3) + alpha*(I_1*I_L*w(11) + I_1*I_R*w(12));
    w(4) = w(4) + alpha*(I_2*I_L*w(11) + I_2*I_R*w(12));
    correct=1;
end
wo=[];
for (i=1:12)
    wo = [wo w(i)];
end
if (y_L > y_R)
    y_pred = -1;
else
    y_pred = 1;
end