function [min]=min_AB(a,b)
for i=2:18
    for j=2:22
        if(a(i,j)<b(i,j))
            min(i,j)=a(i,j);
        else
            min(i,j)=b(i,j);
        end
    end
end
