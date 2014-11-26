function ds = dsselect(ds,varargin)

if isempty(ds)
    return;
end
ds = ds(dsselectidx(ds,varargin{:}),:);
