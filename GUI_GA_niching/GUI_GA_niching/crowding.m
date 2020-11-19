function newpop=crowding(pop, sizepop, stringlength, a, b, fun, option)
%%% Description: crowding selection methods

if option==1 || option==4
    newpop=pop;
    for i=1:ceil(sizepop/2)
        p1= newpop(i,:);
        p2= newpop(i+1,:);
        [c1, c2]=crossover(p1, p2, a, b, option, fun, stringlength, 1);
        c11=mutation(c1, a, b, fun, option, stringlength, 1);
        c22=mutation(c2, a, b, fun, option, stringlength, 1);
        if abs(p1(:, stringlength+1)-c11(:, stringlength+1))+abs(p2(:, stringlength+1)-c22(:, stringlength+1))...
            <= abs(p1(:, stringlength+1)-c22(:, stringlength+1))+ abs(p2(:, stringlength+1)-c11(:, stringlength+1))
            if fun(c11(:, stringlength+1))>fun(p1(:, stringlength+1))
                newpop(i,:)=c11;
            end
            if fun(c22(:, stringlength+1))> fun(p2(:, stringlength+1))
                newpop(i+1,:)=c22;
            end
        else
            if fun(c22(:, stringlength+1))> fun(p1(:, stringlength+1))
                newpop(i,:)=c22;
            end
            if fun(c11(:, stringlength+1))> fun(p2(:, stringlength+1))
                newpop(i+1,:)=c11;
            end
        end
    end
else
    newpop=pop;
    for i=1:ceil(sizepop/2)
        p1= newpop(i,:);
        p2= newpop(i+1,:);
        [c1, c2]=crossover(p1, p2, a, b, option, fun, stringlength, 1);
        c11=mutation(c1, a, b, fun, option, stringlength, 1);
        c22=mutation(c2, a, b, fun, option, stringlength, 1);
        if norm(p1(:, 2*stringlength+1:2*stringlength+2)-c11(:, 2*stringlength+1:2*stringlength+2))+...
                norm(p2(:,  2*stringlength+1:2*stringlength+2)-c22(:,  2*stringlength+1:2*stringlength+2))...
            <= norm(p1(:, 2*stringlength+1:2*stringlength+2)-c22(:, 2*stringlength+1:2*stringlength+2))+...
            norm(p2(:, 2*stringlength+1:2*stringlength+2)-c11(:,  2*stringlength+1:2*stringlength+2))
            if fun(c11(:, 2*stringlength+1),c11(:, 2*stringlength+2))>fun(p1(:, 2*stringlength+1),p1(:, 2*stringlength+2))
                newpop(i,:)=c11;
            end
            if fun(c22(:, 2*stringlength+1),c22(:, 2*stringlength+2))> fun(p2(:, 2*stringlength+1),p2(:, 2*stringlength+2))
                newpop(i+1,:)=c22;
            end
        else
            if fun(c22(:, 2*stringlength+1),c22(:, 2*stringlength+2))> fun(p1(:, 2*stringlength+1),p1(:, 2*stringlength+2))
                newpop(i,:)=c22;
            end
            if fun(c11(:, 2*stringlength+1),c11(:, 2*stringlength+2))> fun(p2(:, 2*stringlength+1),p2(:, 2*stringlength+2))
                newpop(i+1,:)=c11;
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%
%End of function
%%%%%%%%%%%%%%%%%%%