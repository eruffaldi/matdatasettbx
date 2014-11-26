function [ ds ] = dsrename( ds, innames, outnames)

v = get(ds,'VarNames');
s = cell2struct(outnames,innames,2);
for I=1:length(v)
    if isfield(s,v{I})
        v{I} = s.(v{I});
    end
end
ds  = set(ds,'VarNames',v);