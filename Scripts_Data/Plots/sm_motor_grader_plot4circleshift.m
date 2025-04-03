function fig_h=sm_motor_grader_plot4circleshift(logsoutRes)
% Code to plot simulation results from sm_motor_grader_mech
%% Plot Description:
%
% The plot below shows the extension and force of the circle shift cylinder.

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
    cmdPos = logsoutRes.get('Cmd').Values.pCircleShift;
end

% Get simulation results
simlog_circleshift   = logsoutRes.get('Grader').Values.Vehicle.Frame.Lift.CircleShift;
simlog_t       = simlog_circleshift.p.Time;
simlog_pCirc  = simlog_circleshift.p.Data;
simlog_fCirc  = simlog_circleshift.force.Data;

tco = get(gca,'defaultAxesColorOrder');

% Plot results
ah(1) = subplot(2,1,1);
if(~isempty(cmdPos))
    plot(cmdPos.Time, cmdPos.Data, 'k--', 'LineWidth', 2,'DisplayName','Command')
    hold on
end
plot(simlog_t, simlog_pCirc, 'Color',tco(1,:), 'LineWidth', 1,'DisplayName','Measured')
hold off
title('Circle Shift Cylinder Extension')
ylabel('Extension (m)')
grid on
legend('Location','Best');

ah(2) = subplot(2,1,2);
plot(simlog_t, simlog_fCirc, 'LineWidth', 1,'DisplayName','Force')
hold off
title('Circle Shift Cylinder Force')
ylabel('Force (N)')
xlabel('Time (s)');
grid on

linkaxes(ah,'x')

%
%text(0.05,0.05,'Wheel Speeds estimated with unloaded radius','Units','normalized','Color',[0.6 0.6 0.6])

