function ds = dssetparam(ds,name,value)
%
% Sets a parameter stored in a dataset using the UserData field as a
% structure
%
% ds = dssetparam(ds,name,value);
%
% Emanuele Ruffaldi - PERCRO SSSA 2012
%
% See Also: dsgetparam
if isstruct(ds)
    if isfield(ds,'UserData')
        g = ds.UserData;
    else
        g = [];
    end
else
    g = get(ds,'UserData');
end

if iscell(name)
   assert(iscell(value),'Requires cell in value');
   assert(size(name) == size(value),'Matching size');
   for I=1:length(name)
       g.(name{I}) = value{I};
   end
else
    g.(name) = value;
end
if isstruct(ds)
    ds.UserData = g;
else
    ds = set(ds,'UserData',g);    
end
