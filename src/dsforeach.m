function [ dso ] = dsforeach( ops, ds, fieldin, fieldout)

if nargin < 3
    fieldin = '';
end
if nargin < 4
    fieldout = '';
end

dso = [];
if iscell(ops) == 0    
    if isempty(fieldin) 
        % full dataset
        for I=1:length(ds)
            fx = ops;
            v = fx(ds(I,:));
            if isa(v,'dataset')
                v = {v};
            end
            dso = [dso; v];           
        end
    else
        for I=1:length(ds)
            if iscell(ds.(fieldin))
                v = ds.(fieldin){I};
            else
                v = ds.(fieldin)(I,:);
            end
            fx = ops;
            if nargin(fx) == 1
                v = fx(v);
            else
                v = fx(v,ds(I,:));
            end
            if isa(v,'dataset')
                v = {v};
            end
            dso = [dso; v];
         
        end        
    end
    if isempty(fieldout) == 0
        tmp = dso;
        dso = ds;
        dso.(fieldout) = tmp;
    end
else
    if isempty(fieldin)        
        for I=1:length(ds)
            v = ds(I,:);
            for J=1:length(ops)
                v = ops{J}(v);
            end
            if isa(v,'dataset')
                v = {v};
            end
            dso = [dso; v];           
        end
    else
        for I=1:length(ds)
            if iscell(ds.(fieldin))
                v = ds.(fieldin){I};
            else
                v = ds.(fieldin)(I,:);
            end
            for J=1:length(ops)
                if nargin(ops{J}) == 1

                    
                    
                    
                    v = ops{J}(v);
                else
                    v = ops{J}(v,ds(I,:));
                end
            end
            if isa(v,'dataset')
                v = {v};
            end
            dso = [dso; v];
        end        
    end
    if isempty(fieldout) == 0
        tmp = dso;
        dso = ds;
        dso.(fieldout) = tmp;
    end    
end