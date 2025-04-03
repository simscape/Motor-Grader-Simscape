function fig_h=sm_motor_grader_plot3bladetilt(logsoutRes)
% Code to plot simulation results from sm_motor_grader_mech
%% Plot Description:
%
% The plot below shows the extension and force of the blade tilt cylinder.

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
    cmdPos = logsoutRes.get('Cmd').Values.pTilt;
end

% Get simulation results
simlog_t       = logsoutRes.get('Grader').Values.Vehicle.Frame.Blade.Shift.p.Time;
simlog_pTilt   = logsoutRes.get('Grader').Values.Vehicle.Frame.Blade.Tilt.p.Data;
simlog_fTilt   = logsoutRes.get('Grader').Values.Vehicle.Frame.Blade.Tilt.force.Data;

tco = get(gca,'defaultAxesColorOrder');

% Plot results
ah(1) = subplot(2,1,1);
if(~isempty(cmdPos))
    plot(cmdPos.Time, cmdPos.Data, 'k--', 'LineWidth', 2,'DisplayName','Command')
    hold on
end
plot(simlog_t, simlog_pTilt, 'Color',tco(1,:), 'LineWidth', 1,'DisplayName','Measured')
hold off
title('Blade Tilt Cylinder Extension')
ylabel('Extension (m)')
grid on

legend('Location','Best')

ah(2) = subplot(2,1,2);
plot(simlog_t, simlog_fTilt, 'LineWidth', 1,'DisplayName','Force')
title('Blade Tilt Cylinder Force')
ylabel('Force (N)')
xlabel('Time (s)');
grid on

linkaxes(ah,'x')

%legend('Location','Best');
%text(0.05,0.05,'Wheel Speeds estimated with unloaded radius','Units','normalized','Color',[0.6 0.6 0.6])

