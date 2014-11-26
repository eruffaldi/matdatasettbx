function r = dshasparam(dd,p)

s = get(dd,'UserData');
r = isfield(s,p);
