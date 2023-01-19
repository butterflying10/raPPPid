function output_txt = vis_customdatatip(obj,event_obj)
% Display the position of the data cursor with relevant information
%
% INPUT:
%   obj          Currently not used (empty)
%   event_obj    Handle to event object
% OUTPUT:
%   output_txt   Data cursor text string (string or cell array of strings).
% 
%
% This function belongs to raPPPid, Copyright (c) 2023, M.F. Glaner
% *************************************************************************

if isempty(event_obj.Target.DisplayName)
    output_txt = 'no info';
    return
end


% get position of click (x-value = time [sod], y-value = depends on plot)
pos = get(event_obj,'Position');
sod = pos(1);
value = pos(2);

% calculate epoch from sod (attention: missing epochs are not considered!)
epoch = find(event_obj.Target.XData == sod, 1, 'first');

% calculate time of day from sod
[~, hour, min, sec] = sow2dhms(sod);
% create string with time of day
str_time = [sprintf('%02.0f', hour), ':', sprintf('%02.0f', min), ':', sprintf('%02.0f', sec)];

% create cell with strings as output (which will be shown when clicking)
i = 1;
sat = event_obj.Target.DisplayName;       % name of clicked line e.g. satellite
sat = strrep(sat, 'data', 'PRN: ');
output_txt{i} = sat;
i = i + 1;
output_txt{i} = ['Time: ',  str_time];                  % time of day
i = i + 1;
output_txt{i} = ['Epoch: ', sprintf('%.0f', epoch)];    % epoch
i = i + 1;
output_txt{i} = ['Value: ', sprintf('%.3f', value)];   % value

end