function [pop]=initialise(popsize, stringlength, a, b, fun, option)
%%% Description: initialize population
%%% Different functions have different initialized population
%%% Popsize presents the population size
%%% stringlenrth is the length of chromesome which is used to present single
%%%value
%%% a,b is the range of variable
%%% fun is function values
%%% option=1,4,6 corresponds to M1, M4, M6 functions in the slides

if option==1 || option==4
    pop=round(rand(popsize, stringlength+2));
    for i=1:popsize
        pop(i, stringlength+1)=sum(2.^(size(pop(:,1:stringlength),2)-1:-1:0).*pop(i,1:stringlength))*(b-a)/(2.^stringlength-1)+a;
        pop(i, stringlength+2)= fun(pop(i, stringlength+1));
    end
else
    pop=round(rand(popsize, 2*stringlength+3));
    for i=1:popsize
        pop(i, 2*stringlength+1)=sum((2.^(size(pop(:,1:stringlength),2)-1:-1:0)).*pop(i,1:stringlength))*(b-a)/(2.^stringlength-1)+a;
        pop(i, 2*stringlength+2)=sum(2.^(size(pop(:,1:stringlength),2)-1:-1:0).*pop(i,stringlength+1:2*stringlength))*(b-a)/(2.^stringlength-1)+a;
        pop(i, 2*stringlength+3)= fun(pop(i, 2*stringlength+1),pop(i, 2*stringlength+2));
    end
end

%%%%%%%%%%%%%%%%%
%End of function
%%%%%%%%%%%%%%%%%