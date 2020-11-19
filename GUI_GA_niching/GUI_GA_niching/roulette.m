function [ind1 ind2 wind1 wind2]=roulette(oldpop, popsize, stringlength, option)
%%%Description: roulette selection method

if option==1 || option==4
    totalfit=sum(oldpop(:,stringlength+2));
    prob=oldpop(:,stringlength+2)/totalfit;
    probsort=sort(prob, 'descend');
    prob1=cumsum(probsort);
    %prob1=[0;prob1];prob1(end)=[];

    ind11=max(find(prob1>rand(1,1),1, 'first'));
    ind22=max(find(prob1>rand(1,1),1, 'first'));

    ind1=max(find(prob==probsort(ind11)));
    ind2=max(find(prob==probsort(ind22)));

    wind1=max(find(prob==probsort(end),1,'first'));
    wind2=max(find(prob==probsort(end-1),1,'first'));
else
    totalfit=sum(oldpop(:,2*stringlength+3));
    prob=oldpop(:,2*stringlength+3)/totalfit;
    probsort=sort(prob, 'descend');
    prob1=cumsum(probsort);

    ind11=max(find(prob1>rand(1,1),1, 'first'));
    ind22=max(find(prob1>rand(1,1),1, 'first'));

    ind1=max(find(prob==probsort(ind11)));
    ind2=max(find(prob==probsort(ind22)));

    wind1=max(find(prob==probsort(end),1,'first'));
    wind2=max(find(prob==probsort(end-1),1,'first'));
end
clear prob1;

%%%%%%%%%%%%%%%%%%%
%End of function
%%%%%%%%%%%%%%%%%%%