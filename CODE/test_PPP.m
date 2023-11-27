clc;
clear all;
close all;
pwd='D:\studying\raPPPid\WORK';  % ¹¤×÷Â·¾¶

global STOP_CALC
STOP_CALC = 0;

% loading setting.mat
path='..\RESULTS\GRAZ00AUT_R_20200010000_01D_30S_MO\noname_29-Oct-2023_11h12m33s\';
load([path,'settings.mat']);         % get and save it in structure "settings"
save([pwd,   '/', 'settings.mat'], 'settings') 	% save settings as .mat
[~,file,ext] = fileparts(settings.INPUT.file_obs);
% check if settings for processing are valid
valid_settings = checkProcessingSettings(settings, false);
if ~valid_settings
        return
end
% manipulate name of processing (e.g., add GNSS at the beginning)
settings = manipulateProcessingName(settings);
    
% print some information to the command window
fprintf('\n---------------------------------------------------------------------\n');
fprintf('%s%s\n\n','Observation file: ',[file ext]);
    
    
% -+-+-+- CALL MAIN FUNCTION  -+-+-+-
settings_ = PPP_main(settings);         % start processing
% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
% processing is finished:
% update plot-panel of GUI_PPP
path_data4plot = [settings_.PROC.output_dir, '/data4plot.mat'];
fprintf('\n---------------------------------------------------------------------\n');