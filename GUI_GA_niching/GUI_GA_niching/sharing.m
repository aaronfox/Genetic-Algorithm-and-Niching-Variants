function newpop = sharing(pop, sizepop, stringlength, option, sigmash, alpha)
%%% Description: sharing selection method

newpop=pop;
if option==1 || option==4
    
    for i = 1:sizepop
        for j=1:sizepop
        
            d(i,j)=abs(newpop(i,stringlength+1)-newpop(j,stringlength+1));
            if d(i,j)<sigmash & sigmash~=0
                sh(j)=1-(d(i,j)/sigmash)^alpha;
            else
                sh(j)=0;
            end
        end
        newpop(i,stringlength+2)=newpop(i,stringlength+2)/sum(sh);
    end
else
    for i = 1:sizepop
        for j=1:sizepop
        
            d(i,j)=norm(newpop(i,2*stringlength+1:2*stringlength+2)-newpop(j,2*stringlength+1:2*stringlength+2));
            if d(i,j)<sigmash
                sh(j)=1-d(i,j)/sigmash;
            else
                sh(j)=0;
            end
        end
        newpop(i,2*stringlength+3)=newpop(i,2*stringlength+3)/sum(sh);
    end
end
%%%%%%%%%%%%%%%%%%%
%End of function
%%%%%%%%%%%%%%%%%%%