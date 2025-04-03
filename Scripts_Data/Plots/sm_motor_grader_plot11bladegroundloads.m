function fig_h=sm_motor_grader_plot11bladegroundloads(logsoutRes)
% Code to plot simulation results from sm_motor_grader_mech
%% Plot Description:
%
% The plot below shows the loads on the blade due to contact with the ground.

% Copyright 2025 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
figString = ['h1_' mfilename];
% Only create a figure if no figure exists
figExist = 0;
fig_hExist = evalin('base',['exist(''' figString ''',''var'')']);
if (fig_hExist)
    figExist = evalin('base',['ishandle(' figString ') && strcmp(get(' figString ', ''type''), ''figure'')']);
end
if ~figExist
    fig_h = figure('Name',figString);
    assignin('base',figString,fig_h);
else
    fig_h = evalin('base',figString);
end

figure(fig_h)
clf(fig_h)

logNames = logsoutRes.getElementNames;
if(isempty(find(strcmp(logNames,'Cmd'), 1)))
    cmdPos = [];
else
    cmdPos = logsoutRes.get('Cmd').Values.pShift;
end

% Get simulation results
simlog_t       = logsoutRes.get('Grader').Values.Vehicle.Frame.Blade.Blade.fLoadBladeL.Time;
simlog_fLoadL  = squeeze(logsoutRes.get('Grader').Values.Vehicle.Frame.Blade.Blade.fLoadBladeL.Data);
simlog_fLoadR  = squeeze(logsoutRes.get('Grader').Values.Vehicle.Frame.Blade.Blade.fLoadBladeR.Data);

tco = get(gca,'defaultAxesColorOrder');

% Plot results
plot(simlog_t, simlog_fLoadL, 'Color',tco(1,:), 'LineWidth', 1,'DisplayName','Left')
hold on
plot(simlog_t, simlog_fLoadR,'--', 'Color',tco(2,:), 'LineWidth', 1,'DisplayName','Right')
title('Ground Loads on Blade Ends')
ylabel('Force (N)')
grid on
legend('Location','Best')

