function [output] = proba_touch(condition, prior)
%prior(:,1) =  1 (left side) or 2 (right side)
%prior(:,2) = -1 (left hand) or 1 (right hand)

if (condition<0)
    ind = prior(:,1) == 1;
    prior = prior(ind,:);
    p_left = sum(prior(:,2) == -1) / numel(prior(:,2));
    p_right = sum(prior(:,2) == 1) / numel(prior(:,2));
else
    ind = prior(:,1) == 2;
    prior = prior(ind,:);
    p_left = sum(prior(:,2) == -1) / numel(prior(:,2));
    p_right = sum(prior(:,2) == 1) / numel(prior(:,2));
end

if (p_left > p_right)
    output = -1;
else
    output = 1;

end