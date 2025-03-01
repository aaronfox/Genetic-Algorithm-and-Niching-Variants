function [pop Fmax Fmin Faver fun]=genetic(popsize, stringlength, a, b,...
    option, pc, pm, num_iter, crowd, shar, sigmash, alpha,handles)

% popsize is the population size
% stringlength is the length of the binary string to represent a real
% variable
% [a, b] is the function's domain
% option is for the function selection
% option=1: for M1 function
% option=4: for M4 function
% option=6: for M6 function
% pc & pm are the crossover and the mutation probabilities
% num_iter is the number of iterations
% crowd is to specify whether or not to do crowding (1 or 0)
% shar is to specify whether or not to do sharing (1 or 0)
% sigmash, alpha are the parameters for sharing
cla

if option==1 || option==4
    x=a:0.01:b;
    y=a:0.01:b;
else
    x=a:0.5:b;
    y=a:0.5:b;
end
switch option
    case 1
        fun= @(x) sin(5*pi*x)^6;
        axes(handles.axes1);
        h1=plot(x,sin(5*pi*x).^6);
        hold on
    case 4
        fun= @(x) exp(-2*log(2)*((x-0.08)/0.854)^2)*sin(5*pi*(x^0.75-0.05))^6;
        axes(handles.axes1);
        h1=plot(x,exp(-2*log(2)*((x-0.08)/0.854).^2).*sin(5*pi*(x.^0.75-0.05)).^6);
        hold on
    case 6
        for i=1:25
            a1(i)=16*(mod(i-1,5)-2);%%Function defined 
            b1(i)=16*((i-1)/5-2);
%             a1(i)=0.5*i;
%             b1(i)=i;
        end
        fun= @(x,y) 500-(1./(0.002+sum(1./(1+(0:24)+(x-a1).^6+(y-b1).^6))));
        
        for j=1:length(x)
            for k=1:length(y)
                z(j,k)= fun(x(j),y(k));
            end
        end
        axes(handles.axes1);
        h1=surf(x,y,z);
        hold on
end
pop=initialise(popsize, stringlength, a, b, fun, option); %Initialization
if option==1 || option==4
    plot(pop(:,stringlength+1),pop(:,stringlength+2),'r*');
else
    plot3(pop(:,2*stringlength+2),pop(:,2*stringlength+1),pop(:,2*stringlength+3),'w*');
end
for j=1:num_iter
    if crowd==1
        pop=crowding(pop, popsize, stringlength, a, b, fun, option);
    end
    if shar==1
        pop = sharing(pop, popsize, stringlength, option, sigmash, alpha);
    end
    [ind1 ind2 wind1 wind2]=roulette(pop, popsize, stringlength, option);%Selection methods
    pop_temp=pop;
     if option==1 | option==4
        for i=1:popsize
            pop(i,stringlength+2)=fun(pop(i,stringlength+1));
        end
     else
        for i=1:popsize
            pop(i,2*stringlength+3)=fun(pop(i,2*stringlength+1),pop(i,2*stringlength+2));
        end
     end
    
    if option==1 || option==4
        Fmax(j)=max(pop(:,stringlength+2));
        Fmin(j)=min(pop(:,stringlength+2));
        Faver(j)=mean(pop(:,stringlength+2));
    else
        Fmax(j)=max(pop(:,2*stringlength+3));
        Fmin(j)=min(pop(:,2*stringlength+3));
        Faver(j)=mean(pop(:,2*stringlength+3));
    end
    parent1=pop(ind1,:);
    parent2=pop(ind2,:);
    [child1, child2]=crossover(parent1, parent2, a, b, option, fun, stringlength, pc);%crossover

    child1m=mutation(child1, a, b, fun, option, stringlength, pm);%mutation
    child2m=mutation(child2, a, b, fun, option, stringlength, pm);
    
    pop(wind1,:)=child1m;
    pop(wind2,:)=child2m;
    
end
if option==1 || option==4
    xlabel('x');
    ylabel('M(x)');
    plot(pop(:,stringlength+1),pop(:,stringlength+2),'g*');
    hleg1=legend('Function','Initial Optimum','Niche Points','Location','Southeast');
    
    
else
    xlabel('x');
    ylabel('M(x)');
    plot3(pop(:,2*stringlength+2),pop(:,2*stringlength+1),pop(:,2*stringlength+3),'g*');
    title('Function and Population (initial,niched) plot')
    hleg1=legend('Function','Initial Optimum','Niche Points','Location','SoutheastOutside');
    
end

axes(handles.axes2);
plot(Fmax), hold on, plot(Faver,'r-'), hold on, plot(Fmin,'g');
xlabel('Generation')
ylabel('Fitness')
title('Fitness Progress')
legend('Maximum Fitness','Mean Fitness','Minimum Fitness')%,4)

% if crowd==1 
%     name1=strcat('crowding','pc','pm','b');
%     name2=strcat('crowding','pc','pm','f');
% elseif shar==1
%     name1=strcat('sharing','pc','pm','b');
%     name2=strcat('sharing','pc','pm','f');
% end
% 
% saveas(h1,name1,'bmp'); %name is a string
% saveas(h2,name2,'bmp');

end

%%%%%%%%%%%%%%%%%%
%End of function
%%%%%%%%%%%%%%%%%%