function fig_h=sm_motor_grader_plot6leancyl(logsoutRes)
% Code to plot simulation results from sm_motor_grader_mech
%% Plot Description:
%
% The plot below shows the extension and force of the lean cylinders.

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
    cmdPosL = logsoutRes.get('Cmd').Values.pLeanL;
    cmdPosR = logsoutRes.get('Cmd').Values.pLeanR;
end


% Get simulation results
simlog_framef  = logsoutRes.get('Grader').Values.Vehicle.FrameF;
simlog_t       = simlog_framef.LeanL.p.Time;
simlog_pLeanL  = simlog_framef.LeanL.p.Data;
simlog_pLeanR  = simlog_framef.LeanR.p.Data;
simlog_fLeanL  = simlog_framef.LeanL.force.Data;
simlog_fLeanR  = simlog_framef.LeanR.force.Data;

tco = get(gca,'defaultAxesColorOrder');

% Plot results
ah(1) = subplot(2,1,1);
if(~isempty(cmdPosL))
    plot(cmdPosL.Time, cmdPosL.Data, 'k--', 'LineWidth', 2,'DisplayName','Command L')
    hold on
    plot(cmdPosR.Time, cmdPosR.Data, 'k--', 'LineWidth', 2,'DisplayName','Command R')
end

plot(simlog_t, simlog_pLeanL, 'Color',tco(1,:), 'LineWidth', 1,'DisplayName','LeanL')
hold on
plot(simlog_t, simlog_pLeanR, '-.','Color',tco(2,:), 'LineWidth', 1,'DisplayName','LeanR')
hold off
title('Lean Cylinder Extension')
ylabel('Extension (m)')
grid on
legend('Location','Best');

ah(2) = subplot(2,1,2);
plot(simlog_t, simlog_fLeanL, 'Color',tco(1,:), 'LineWidth', 1,'DisplayName','LeanL')
hold on
plot(simlog_t, simlog_fLeanR, '-.','Color',tco(2,:), 'LineWidth', 1,'DisplayName','LeanR')
hold off
title('Lean Cylinder Force')
ylabel('Force (N)')
xlabel('Time (s)');
grid on

linkaxes(ah,'x')

%
%text(0.05,0.05,'Wheel Speeds estimated with unloaded radius','Units','normalized','Color',[0.6 0.6 0.6])

