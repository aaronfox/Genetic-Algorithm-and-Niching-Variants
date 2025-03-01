function [child]=mutation(parent, a, b, fun, option, stringlength, pm)
%%% Description: mutation algorithm
%%% parent is the parent population
%%% [a,b] is the range of real values
%%% option=1,4,6 corresponds to M1, M4, M6 functions in the slides
%%% stringlenrth is the length of chromesome which is used to present single
%%%value
%%% pm is the probability of mutation

if option==1 || option==4
    if (rand<pm)
        mpoint=round(rand*(stringlength-1))+1;
        child=parent;
        child(mpoint)=abs(parent(mpoint)-1);
        child(:, stringlength+1)=sum(2.^(size(child(:,1:stringlength),2)-1:-1:0).*child(:,1:stringlength))*(b-a)/ (2.^stringlength-1)+a;
        child(:, stringlength+2)=fun(child(:, stringlength+1));
    else
        child=parent;
    end
else
    if (rand<pm)
        mpoint=round(rand*(stringlength-1))+1;
        child=parent;
        child(mpoint)=abs(parent(mpoint)-1);
        child(stringlength + mpoint)=abs(parent(stringlength + mpoint)-1);
        child(:, 2*stringlength+1)=sum(2.^(size(child(:,1:stringlength),2)-1:-1:0).*child(:,1:stringlength))*(b-a)/ (2.^stringlength-1)+a;
        child(:, 2*stringlength+2)=sum(2.^(size(child(:,1:stringlength),2)-1:-1:0).*child(:,stringlength+1:2*stringlength))*(b-a)/ (2.^stringlength-1)+a;

        child(:, 2*stringlength+3)=fun(child(:, 2*stringlength+1), child(:, 2*stringlength+2));
    else
        child=parent;
    end
end

%%%%%%%%%%%%%%%%%%%
%End of function
%%%%%%%%%%%%%%%%%%%