function b = dsisfield(ds,name)
%
% Checks if a dataset contains a given variable, or multiple
%
% bool = dsisfield(ds,name);
%
% Emanuele Ruffaldi - PERCRO SSSA 2012
%
f = get(ds,'VarNames');
a = cell2struct(f,f,2);

if iscell(name)
    b = cellfun(@(x) isfield(a,x),name);
else
    b = isfield(a,name);
end
