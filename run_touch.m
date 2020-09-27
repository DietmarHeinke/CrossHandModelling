%nr_trials = [10, 40, 50, 100, 100, 100, 100, 100, 10, 10, 10, 10, 10, 10];
nr_trials = 10 + zeros( 1, 40);
acc_count1 = [];
acc_count2 = [];
acc_count3 = [];
w = randn(12,1)/1000;
prior = [];
y_tot = [];
noise_var = 0.7;
for (n=nr_trials)
    cond = [-1 1];
    accuracy=[0 0 0];
    input = 0;
    for (i=1:n)
        body_space = randi(2);
        if (body_space==1)
            I_L=1;
            I_R=0;
            input = normrnd(-1,noise_var);
        else
            I_L=0;
            I_R=1;
            input = normrnd(1,noise_var);
        end
        
        x=rand;
        if x<0.8
          select=1;
        else
          select=2;
        end

        crossed = cond(select);
        [wo,correct,y_exp, y_pred]=touch2(input,I_L,I_R,crossed,w);
        w=wo;
        accuracy(1)=accuracy(1)+correct(1);
        accuracy(2)=accuracy(2)+correct(2);
        accuracy(3)=accuracy(3)+correct(3);
        condition = [body_space, y_exp];
        prior = cat(1,prior,condition);
       
    end
    y = [y_pred, proba_touch2(input,prior), y_exp, crossed];
    y_tot = cat(1,y_tot,y);
        
    acc_count1=[acc_count1 accuracy(1)/n];
    acc_count2=[acc_count2 accuracy(2)/n];
    acc_count3=[acc_count3 accuracy(3)/n];
end
i= 1:length(nr_trials);
figure
plot(i, acc_count1)
plot_title = title('Final accuracy score after training for n iterations (stage 1)');
x_label = xlabel('session');
y_label = ylabel('accuracy');
xticklabels(i)
ylim([0 1.2])

figure
plot(i, acc_count2)
title('Final accuracy score after training for n iterations (stage 2)')
xlabel('number of training iterations') 
ylabel('accuracy')
xticklabels([10, 50, 100, 200, 300, 400, 500, 600])
ylim([0 1.2])

figure
plot(i, acc_count3)
title('Final accuracy score after training for n iterations (stage 3)')
xlabel('number of training iterations') 
ylabel('accuracy')
xticklabels([10, 50, 100, 200, 300, 400, 500, 600])
ylim([0 1.2])

ind = y_tot(:,6) == -1;
y_tot = y_tot(ind,:);
i= 1:length(y_tot(:,1));
figure
plot(i, y_tot(:,4))
hold on
plot(i, y_tot(:,1))
scatter(i, y_tot(:,5),40,'v','g')
hold off
ylim([-1.2 1.7])
legend('quick model', 'slow model - stg 1', 'expected')

ind = y_tot(:,6) == -1;
y_tot = y_tot(ind,:);
i= 1:length(y_tot(:,1));
figure
plot(i, y_tot(:,4))
hold on
plot(i, y_tot(:,2))
scatter(i, y_tot(:,5),40,'v','g')
hold off
ylim([-1.2 1.7])
legend('quick model', 'slow model - stg 2', 'expected')

ind = y_tot(:,6) == -1;
y_tot = y_tot(ind,:);
i= 1:length(y_tot(:,1));
figure
plot(i, y_tot(:,4))
hold on
plot(i, y_tot(:,3))
scatter(i, y_tot(:,5),40,'v','g')
hold off
ylim([-1.2 1.7])
legend('quick model', 'slow model - stg 3', 'expected')
