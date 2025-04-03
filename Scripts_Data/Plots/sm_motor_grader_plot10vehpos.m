function fig_h=sm_motor_grader_plot10vehpos(logsoutRes)
% Code to plot simulation results from sm_motor_grader_mech
%% Plot Description:
%
% The plot below shows the wheel speeds during the maneuver.  The
% rotational wheel speeds are scaled by the unloaded radius so they can be
% compared with the translational speed of the vehicle.

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

% Get simulation results
simlog_px = [];
simlog_py = [];
if(~isempty(find(strcmp(fieldnames(logsoutRes.get('Grader').Values.Vehicle),'World'))))
    simlog_xVeh  = logsoutRes.get('Grader').Values.Vehicle.World.x.Data;
    simlog_yVeh  = logsoutRes.get('Grader').Values.Vehicle.World.y.Data;
end
tco = get(gca,'defaultAxesColorOrder');

% Plot results
if(~isempty(simlog_xVeh))
    plot(simlog_xVeh, simlog_yVeh, 'LineWidth', 1,'DisplayName','Vehicle')
end
axis equal

ylabel('Y Position (m)')
xlabel('X Position (m)')
title('Vehicle Position')
grid on
box on
finalPosStr = sprintf('Final Position:  x = %3.2f, y=%3.2f',simlog_xVeh(end),simlog_yVeh(end));
text(0.05,0.05,finalPosStr,'Units','normalized','Color',[0.6 0.6 0.6])

