function [ ds ] = dsapplyfun( fx, ds, fromname,toname)
% [ ds ] = dsapplyfun( fx, ds, fromname,toname)
%
% Basic equivalent:
%	ds.toname = fx(ds
% Applies agiven function to a full ds. Necessary for embedding in inline
if iscell(fromname)
	xfromname = fromname;
	if nargin < 4
        xtoname = xfromname;
    else
		xtoname = toname;
	end
	for J=1:length(xfromname)
		fromname = xfromname{J};
		if iscell(xtoname)
			toname = xtoname{J};
		else
			if xtoname(1) == '*'
				toname = [fromname  xtoname(2:end)];
			else
				toname = [fromname  xtoname];
			end
		end	
		if nargin(fx) == 2
			ds.(toname) = fx(ds.(fromname),ds);
		else
			ds.(toname) = fx(ds.(fromname));
		end
	end
else
	if nargin < 4
		toname = fromname;
	else
		if toname(1) == '*'
			toname = [fromname  toname(2:end)];
		end
	end
if nargin(fx) == 2
    ds.(toname) = fx(ds.(fromname),ds);
else
    ds.(toname) = fx(ds.(fromname));
end
end