function [wo,correct,y_exp, y_pred] = touch2(input,I_L,I_R,crossed,w)
noise_var = 0.7;
if (crossed==1)
    I_1 = 1;
    I_2 = -1;
else
    I_1 = -1;
    I_2 = 1;
end
y_pred = [];
correct = [];
for (i=1:3)
    
    alpha = 0.001;
    x1 = I_1*w(1) + I_2*w(2);
    x2 = I_1*w(3) + I_2*w(4);

    y_L = x1*input*w(5) + x2*input*w(6);
    y_R = x1*input*w(7) + x2*input*w(8);

    y_exp = crossed * (I_L - I_R);
    if (y_exp == -1 && y_L > y_R)
        w(5) = w(5) + alpha*x1*input;
        w(6) = w(6) + alpha*x2*input;
        w(1) = w(1) + alpha*(I_1*input*w(5));
        w(2) = w(2) + alpha*(I_2*input*w(5));
        w(3) = w(3) + alpha*(I_1*input*w(6));
        w(4) = w(4) + alpha*(I_2*input*w(6));
        correct=[correct 1];
    end
    if (y_exp == -1 && y_R > y_L)
        w(7) = w(7) - alpha*x1*input;
        w(8) = w(8) - alpha*x2*input;
        w(1) = w(1) - alpha*(I_1*input*w(7));
        w(2) = w(2) - alpha*(I_2*input*w(7));
        w(3) = w(3) - alpha*(I_1*input*w(8));
        w(4) = w(4) - alpha*(I_2*input*w(8));
        correct=[correct 0];
    end
    if (y_exp == 1 && y_L > y_R)
        w(5) = w(5) - alpha*x1*input;
        w(6) = w(6) - alpha*x2*input;
        w(1) = w(1) - alpha*(I_1*input*w(5));
        w(2) = w(2) - alpha*(I_2*input*w(5));
        w(3) = w(3) - alpha*(I_1*input*w(6));
        w(4) = w(4) - alpha*(I_2*input*w(6));
        correct=[correct 0];
    end
    if (y_exp == 1 && y_R > y_L)
        w(7) = w(7) + alpha*x1*input;
        w(8) = w(8) + alpha*x2*input;
        w(1) = w(1) + alpha*(I_1*input*w(7));
        w(2) = w(2) + alpha*(I_2*input*w(7));
        w(3) = w(3) + alpha*(I_1*input*w(8));
        w(4) = w(4) + alpha*(I_2*input*w(8));
        correct=[correct 1];
    end
    
    if (y_L > y_R)
        y_pred = [y_pred -1];
    else
        y_pred = [y_pred 1];
    end

    if (I_L==1)
        input = (input + normrnd(-1,noise_var))/2;
    else
        input = (input + normrnd(1,noise_var))/2;
    end
end
wo=[];
for (i=1:8)
    wo = [wo w(i)];
end