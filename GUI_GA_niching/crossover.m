function [child1, child2]=crossover(parent1, parent2, a, b, option, fun, stringlength, pc)
%%% Description: crossover algorithm
%%% parent1, parent2 represents two operators 
%%% [a,b] is the range of real values 
%%% option=1,4,6 corresponds to M1, M4, M6 functions in the slides
%%% stringlenrth is the length of chromesome which is used to present single
%%%value
%%% pc is the probability of crossover

if option==1 || option==4
    if (rand<pc)
        cpoint=round(rand*(stringlength-2))+1;
        child1=[parent1(1:cpoint) parent2(cpoint+1:stringlength)];
        child2=[parent2(1:cpoint) parent1(cpoint+1:stringlength)];
        child1( stringlength+1)=sum(2.^(size(child1(1:stringlength),2)-1:-1:0).*child1(1:stringlength))*(b-a)/(2.^stringlength-1)+a;
        child2( stringlength+1)=sum(2.^(size(child2(1:stringlength),2)-1:-1:0).*child2(1:stringlength))*(b-a)/(2.^stringlength-1)+a;
        child1( stringlength+2)=fun(child1( stringlength+1));
        child2( stringlength+2)=fun(child2( stringlength+1));
    else
        child1=parent1;
        child2=parent2;
    end
else
    if (rand<pc)
        cpoint=round(rand*(stringlength-2))+1;
        child1(1:stringlength)=[parent1(1:cpoint) parent2(cpoint+1:stringlength)];
        child1(stringlength+1:2*stringlength)=[parent1(stringlength+1:stringlength+cpoint) parent2(stringlength+cpoint+1:2*stringlength)];
        child2(1:stringlength)=[parent2(1:cpoint) parent1(cpoint+1:stringlength)];
        child2(stringlength+1:2*stringlength)=[parent2(stringlength+1:stringlength+cpoint) parent1(stringlength+cpoint+1:2*stringlength)];
        
        child1( 2*stringlength+1)=sum(2.^(size(child1(1:stringlength),2)-1:-1:0).*child1(1:stringlength))*(b-a)/(2.^stringlength-1)+a;
        child1( 2*stringlength+2)=sum(2.^(size(child1(1:stringlength),2)-1:-1:0).*child1(stringlength+1:2*stringlength))*(b-a)/(2.^stringlength-1)+a;
       
        child2( 2*stringlength+1)=sum(2.^(size(child2(1:stringlength),2)-1:-1:0).*child2(1:stringlength))*(b-a)/(2.^stringlength-1)+a;
        child2( 2*stringlength+2)=sum(2.^(size(child2(1:stringlength),2)-1:-1:0).*child2(stringlength+1:2*stringlength))*(b-a)/(2.^stringlength-1)+a;
        
        child1( 2*stringlength+3)=fun(child1( 2*stringlength+1),child1( 2*stringlength+2));
        child2( 2*stringlength+3)=fun(child2( 2*stringlength+1),child2( 2*stringlength+2));
    else
        child1=parent1;
        child2=parent2;
    end
end

%%%%%%%%%%%%%%%%%%%
%End of function
%%%%%%%%%%%%%%%%%%%