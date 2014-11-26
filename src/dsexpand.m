function [ dso ] = dsexpand( ds, expandedfield, keyfields,indexfield)
% dsexpand( ds, expandedfield, keyfields,indexfield)
%
% Given a dataset containing nested dataset in (ds.expandedfield), it extracts
% all the context and makes one row for every row in the nested. Only
% keyfields of the higher level are being kept.
%
% 
if nargin < 2 || isempty(expandedfield)
    expandedfield = 'value';
end

if nargin < 3 || isempty(keyfields)
    keyfields = dslabels(ds,1);
    keyfields = srmfield(keyfields,{expandedfield,'getdata'});
    keyfields = fields(keyfields);
end

if nargin < 4
    indexfield = [];
end

kisc = iscell(ds.(expandedfield));
% first count items
if kisc
    counts = cellfun(@length,ds.(expandedfield));
    N = sum(counts);
else
    counts = 1;
    N = length(ds);
end

% 1) selectedfields
% 2) content of expanded
% 3) 
if kisc
    v = ds.(expandedfield){find(counts > 0,1,'first')};
    efields = dslabels(v,0);
    for K=1:length(efields)
        if isfield(keyfields,efields{K})
            keyfields= rmfield(keyfields,efields{K});
        end
    end
    contentfields = efields
else
    v = ds.(expandedfield)(1,:);
    keyfields = {};
    contentfields = {};
end


% special case!
if kisc & all(counts == 1)
    R = 1;
    SI = zeros(N,1);
    'special'
    dso = ds(:,keyfields);

    dsr = dataset();
    for I=1:length(ds)
        I
        if kisc
            dsr = [dsr;ds.(expandedfield){I}];
        else
            dsr = [dsr;ds.(expandedfield)(I,:)];
        end
    end
    dso = [dso, dsr];
%     
%     for F=1:length(contentfields)
%         vv = v.(contentfields{F});
%         if iscell(vv) || isobject(vv)
%             dso.(contentfields{F}) = cell(N,1);
%         else
%             dso.(contentfields{F}) = zeros(N,size(vv,2));
%         end
%     end
% 
%     for I=1:length(ds)
%         v = ds.(expandedfield){I}; % just one row
%         for F=1:length(contentfields)
%             vv = v.(contentfields{F});
%             if iscell(vv) 
%                 dso.(contentfields{F})(I) = vv;
%             elseif isobject(vv)
%                 dso.(contentfields{F})(I) = {vv};
%             else
%                 dso.(contentfields{F})(I,:) = vv;
%             end
%         end
%     end

    if isempty(indexfield) == 0
        dso.(indexfield) = (1:N)';
    end

else

    % build count
    if kisc
         vv = ds.(expandedfield){1};
         if isa(vv,'dataset')
            % full dataset by enlarging..
            N = sum(cellfun(@length,ds.(expandedfield)));
            dsoi = zeros(N,1);
            K= 1;
			dso = [];
             for I=1:length(ds)
                    v = ds.(expandedfield){I};
					dso = [dso; v];
                    NN = size(v,1);
                    dsoi(K:K+NN-1,:) = repmat(I,NN,1);
                    K = K + NN;
             end  
			dso.index_ = dsoi;
         else
             % simple a cell array or a double
             N = sum(cellfun(@(x) size(x,1),ds.(expandedfield)));
             M = length(double(vv(1,:)));
             dsoc = zeros(N,M);
             dsoi = zeros(N,1);
             K= 1;
             for I=1:length(ds)
                    v = ds.(expandedfield){I};
                    NN = size(v,1);
                    dsoi(K:K+NN-1,:) = repmat(I,NN,1);
                    dsoc(K:K+NN-1,:) = v;
                    K = K + NN;
             end        
			dso = dataset([dsoi,{'index_'}]);
			dso.(expandedfield) = dsoc;
         end
    else
        M = size(ds.(expandedfield),2);
        dsoi = zeros(N,1);
        dsoc = zeros(N,M);
         K= 1;
         for I=1:length(ds)
                v = ds.(expandedfield)(I,:);
                NN = size(v,1);
                dsoi(K:K+NN-1,:) = repmat(I,NN,1);
                dsoc(K:K+NN-1,:) = v;
                K = K + NN;
         end        
		dso = dataset([dsoi,{'index_'}]);
		dso.(expandedfield) = dsoc;
    end

	% if any keyfields, then merge them by using index_ field
	if isempty(keyfields) == 0    
		 ds = ds(:,keyfields);
		 ds.index_ = (1:length(ds))';
		 dso = join(dso,ds,'index_');
	 end
	 
end


function r = srmfield(ff,cv)

a = isfield(ff,cv);
r = rmfield(ff,cv(a));