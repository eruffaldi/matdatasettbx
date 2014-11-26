% converts a dataset to a cell
%
% Emanuele Ruffaldi 2012
function c = ds2cell(ds)

q = get(ds,'VarNames');
n = 0;
for I=1:length(q)
    n = n + size(ds.(q{I}),2); 
end
c = cell(size(ds,1),n);
n = 1;
for I=1:length(q)
    w = ds.(q{I});
    k = size(w,2);
    if iscell(w)        
        c(:,n:n+k-1) = w;
    else
        w = num2cell(w);
        c(:,n:n+k-1) = w;
    end
    n = n + k;
end
    
