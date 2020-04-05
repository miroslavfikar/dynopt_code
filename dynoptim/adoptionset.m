function ad = adoptionset(varargin)
   p = inputParser;
   addParameter(p,'processjac',strings(0:3),@isstring);
   addParameter(p,'objfunjac',strings(0:3),@isstring);
   addParameter(p,'confunjac',strings(0:3),@isstring);
   addParameter(p, 'keep', false, @(x)validateattributes(x, {'logical'}, {'scalar'}))
   addParameter(p, 'jacuser', false, @(x)validateattributes(x, {'logical'}, {'scalar'}))
   addParameter(p, 'generate', true, @(x)validateattributes(x, {'logical'}, {'scalar'}))
   addParameter(p, 'processjacuser', false, @(x)validateattributes(x, {'logical'}, {'scalar'}))
   addParameter(p, 'objfunjacuser', false, @(x)validateattributes(x, {'logical'}, {'scalar'}))
   addParameter(p, 'confunjacuser', false, @(x)validateattributes(x, {'logical'}, {'scalar'}))
   parse(p,varargin{:});

   if p.Results.jacuser
     ad.processd = @processd;
     ad.objfund = @objfund;
     ad.confund = @confund;
     ad.keep = false;
     ad.generate = false;
     ad.processjacuser = true;
     ad.objfunjacuser = true;
     ad.confunjacuser = true;
   else
     ad.processjacuser = p.Results.processjacuser;
     ad.processd = @processd;
     if ~isempty(p.Results.processjac)
       ad.processd = str2func(p.Results.processjac);
       ad.processjacuser = true;
     end
     ad.objfunjacuser = p.Results.objfunjacuser;
     ad.objfund = @objfund;
     if ~isempty(p.Results.objfunjac)
       ad.objfund = str2func(p.Results.objfunjac);
       ad.objfunjacuser = true;
     end
     ad.confunjacuser = p.Results.confunjacuser;
     ad.confund = @confund;
     if ~isempty(p.Results.confunjac)
       ad.confund = str2func(p.Results.confunjac);
       ad.confunjacuser = true;
     end
     ad.keep = p.Results.keep;
     ad.generate = p.Results.generate;
   end
end
