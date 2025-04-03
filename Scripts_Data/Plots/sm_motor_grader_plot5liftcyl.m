function fig_h=sm_motor_grader_plot5liftcyl(logsoutRes)
% Code to plot simulation results from sm_motor_grader_mech
%% Plot Description:
%
% The plot below shows the extension and force of the lift cylinders.

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
    cmdPosL = [];
else
    cmdPosL = logsoutRes.get('Cmd').Values.pLiftL;
    cmdPosR = logsoutRes.get('Cmd').Values.pLiftR;
end

% Get simulation results
simlog_lift    = logsoutRes.get('Grader').Values.Vehicle.Frame.Lift;
simlog_t       = simlog_lift.LiftL.p.Time;
simlog_pLiftL  = simlog_lift.LiftL.p.Data;
simlog_pLiftR  = simlog_lift.LiftR.p.Data;
simlog_fLiftL  = simlog_lift.LiftL.force.Data;
simlog_fLiftR  = simlog_lift.LiftR.force.Data;
%simlog_pCircle = simlog_lift.CircleShift.p.Data;

tco = get(gca,'defaultAxesColorOrder');

% Plot results
ah(1) = subplot(2,1,1);
if(~isempty(cmdPosL))
    plot(cmdPosL.Time, cmdPosL.Data, 'k--', 'LineWidth', 2,'DisplayName','Command L')
    hold on
    plot(cmdPosR.Time, cmdPosR.Data, 'k--', 'LineWidth', 2,'DisplayName','Command R')
end
plot(simlog_t, simlog_pLiftL, 'Color',tco(1,:), 'LineWidth', 1,'DisplayName','LiftL')
hold on
plot(simlog_t, simlog_pLiftR, '-.','Color',tco(2,:), 'LineWidth', 1,'DisplayName','LiftR')
hold off
title('Lift Cylinder Extension')
ylabel('Extension (m)')
grid on
legend('Location','Best');

ah(2) = subplot(2,1,2);
plot(simlog_t, simlog_fLiftL, 'LineWidth', 1,'DisplayName','LiftL')
hold on
plot(simlog_t, simlog_fLiftR, 'LineWidth', 1,'DisplayName','LiftR')
hold off
title('Lift Cylinder Force')
ylabel('Force (N)')
xlabel('Time (s)');
grid on

linkaxes(ah,'x')

%
%text(0.05,0.05,'Wheel Speeds estimated with unloaded radius','Units','normalized','Color',[0.6 0.6 0.6])

