%nr_trials = [10, 40, 50, 100, 100, 100, 100, 100, 10, 10, 10, 10, 10, 10];
nr_trials = 20 + zeros( 1, 40 );
acc_count = [];
w = randn(12,1)/1000;
prior = [];
y_tot = [];
for (n=nr_trials)
    cond = [-1 1];
    accuracy=0;
    for (i=1:n)
        body_space = randi(2);
        if (body_space==1)
            I_L=1;
            I_R=0;
        else
            I_L=0;
            I_R=1;
        end
        
        x=rand;
        if x<0.8
          select=1;
        else
          select=2;
        end

        crossed = cond(select);
        [wo,correct,y_exp, y_pred]=touch(I_L,I_R,crossed,w);
        w=wo;
        accuracy=accuracy+correct;
        
        condition = [body_space, y_exp];
        prior = cat(1,prior,condition);
       
    end
    y = [y_pred, proba_touch(body_space,prior), y_exp, crossed];
    y_tot = cat(1,y_tot,y);
        
    acc_count=[acc_count accuracy/n];
end
i= 1:length(nr_trials);
figure
plot(i, acc_count)
title('Final accuracy score after training for n iterations')
xlabel('number of training iterations') 
ylabel('accuracy')
xticklabels([10, 50, 100, 200, 300, 400, 500, 600])
ylim([0 1.2])

ind = y_tot(:,4) == -1;
y_tot = y_tot(ind,:);
i= 1:length(y_tot(:,1));
figure
plot(i, y_tot(:,1))
hold on
plot(i, y_tot(:,2))
scatter(i, y_tot(:,3),40,'v','g')
hold off
ylim([-1.2 1.7])
legend('slow model', 'quick model', 'expected')

