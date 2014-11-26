function r = dsgetparam(ds,name,defa)
%
% Returns a parameter stored in a dataset using the UserData field as a
% structure
%
% out = dsgetparam(ds); % returns the whole structure
%
% out = dsgetparam(ds,name [,defa])
%
% Emanuele Ruffaldi - PERCRO SSSA 2012
%
% See Also: dssetparam
if isstruct(ds)
    if isfield(ds,'UserData')
        g = ds.UserData;
    else
        g = struct();
    end
else
    g = get(ds,'UserData');
end

if nargin == 1
    r = g;
else
    if nargin < 3
        r = g.(name); % error if missing
    elseif isfield(g,name) % defa if missing
        r = g.(name);
    else
        r = defa;
    end
end
