function w = dsremovefields(ds,ff)

if isa(ds,'dataset')
    labels = get(ds,'VarNames');
    labels = cell2struct(num2cell(1:length(labels))',labels); 
elseif iscell(ds)
    labels = ds;
    labels = cell2struct(num2cell(1:length(labels))',labels); 
else
    labels = ds;
end
if iscell(ff) == 0
    ff = {ff};
end

labels = rmfield(labels,ff(find(isfield(labels,ff)))); %remove only fields present in labels
w = fields(labels);

if isa(ds,'dataset')
    w = ds(:,w);
end