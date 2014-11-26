function rs = dsselectidx(ds,varargin)
% Dataset Expression Selector
%
% This could have been improved by means of using logicals or limiting
% searc to fields
%
% idxs = dsselectidx(ds, field1, value1, field2, value2 ....)
%
% Different fields are ANDed
% If value is a matrix then value are ORed
%
% idxs = dsselectidx(ds, 'group',1,'sessionidx',2)
% idxs = dsselectidx(ds, 'group',1,'sessionidx',[2,10])
%
%
% equiv to SELECT * from table where ....
% or better "Query By Example"
%
% Emanuele Ruffaldi (C) 2011 PERCRO Scuola Superiore S.Anna

if isempty(ds)
    rs = [];
    return;
end

rs = [];
for J=1:2:nargin-1
    n = varargin{J};
    v = varargin{J+1};
    if iscell(ds.(n))
        q = [];
        if iscell(v)
            for K=1:length(v)
                if ischar(ds.(n){1})
                    q = union(q,find(strcmp(v{K},ds.(n))));
                else
                    error(['Unsupported Cell Content for field: ',n]);
                end
            end
        else
                    q = union(q,find(strcmp(v,ds.(n))));
        end
    else
        q = [];
        for K=1:length(v)
            q = union(q,find(ds.(n) == v(K)));
        end
    end
    if J == 1
        rs = q;
    else
        rs = intersect(q,rs);
        if isempty(rs)
            rs = [];
            return;
        end
    end
end
