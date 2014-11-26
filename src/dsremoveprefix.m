function [ ds ] = dsremoveprefix( ds, fieldprefix )
% Given a dataset it removes prefix by fields

q = get(ds,'VarNames');
for I=1:length(q)
    l = q{I};
    if length(l) > length(fieldprefix) && strcmp(l(1:length(fieldprefix)),fieldprefix)
        q{I} = l(length(fieldprefix)+1:end);
    end
end

ds = set(ds,'VarNames',q);