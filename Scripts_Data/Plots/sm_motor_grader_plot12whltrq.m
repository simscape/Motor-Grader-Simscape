function fig_h=sm_motor_grader_plot12whltrq(logsoutRes,whlRadF,whlRadR)
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
if(isempty(find(strcmp(logNames,'Cmd'), 1)))
    cmdVehSpd = [];
else
    cmdVehSpd = logsoutRes.get('Cmd').Values.vVeh;
end

% Get simulation results
simlog_t = [];
simlog_vRFL = [];
simlog_vRFR = [];
simlog_vRRL = [];
simlog_vRRR = [];
simlog_vFL  = [];
simlog_vFR  = [];
if(~isempty(find(strcmp(fieldnames(logsoutRes.get('Grader').Values.Vehicle),'FrameR'))))
    simlog_t     = logsoutRes.get('Grader').Values.Vehicle.FrameR.Body.Ref.vx.Time;
    simlog_vVeh  = logsoutRes.get('Grader').Values.Vehicle.FrameR.Body.Ref.vx.Data;
    simlog_vRFL  = logsoutRes.get('Grader').Values.Vehicle.FrameR.WhlFL.w.Data;
    simlog_vRFR  = logsoutRes.get('Grader').Values.Vehicle.FrameR.WhlFR.w.Data;
    simlog_vRRL  = logsoutRes.get('Grader').Values.Vehicle.FrameR.WhlRL.w.Data;
    simlog_vRRR  = logsoutRes.get('Grader').Values.Vehicle.FrameR.WhlRR.w.Data;
end
if(~isempty(find(strcmp(fieldnames(logsoutRes.get('Grader').Values.Vehicle),'FrameF'))))
    simlog_t     = logsoutRes.get('Grader').Values.Vehicle.FrameF.WhlL.w.Time;
    simlog_vFL   = logsoutRes.get('Grader').Values.Vehicle.FrameF.WhlL.w.Data;
    simlog_vFR   = logsoutRes.get('Grader').Values.Vehicle.FrameF.WhlR.w.Data;
end
tco = get(gca,'defaultAxesColorOrder');

% Plot results
ah(1) = subplot(2,1,1);
if(~isempty(cmdVehSpd))
    plot(cmdVehSpd.Time, cmdVehSpd.Data, 'k--', 'LineWidth', 1,'DisplayName','Command')
end
hold on
if(~isempty(simlog_vVeh))
    plot(simlog_t, simlog_vVeh, 'b', 'LineWidth', 2,'DisplayName','Vehicle')
    plot(simlog_t, simlog_vRFL*whlRadR, 'Color', tco(3,:),'LineWidth', 1,'DisplayName','RFL')
    plot(simlog_t, simlog_vRFR*whlRadR, 'Color',tco(4,:),'LineWidth', 1,'DisplayName','RFR')
    plot(simlog_t, simlog_vRRL*whlRadR, 'Color',tco(5,:),'LineWidth', 1,'DisplayName','RRL')
    plot(simlog_t, simlog_vRRR*whlRadR, 'Color',tco(6,:),'LineWidth', 1,'DisplayName','RRR')
end
if(~isempty(simlog_vFL))
    plot(simlog_t, simlog_vFL*whlRadF, 'Color',tco(1,:), 'LineWidth', 1,'DisplayName','FL')
    plot(simlog_t, simlog_vFR*whlRadF, 'Color',tco(2,:),'LineWidth', 1,'DisplayName','FR')
end
hold off

ylabel('Speed (m/s)')
title('Wheel Speeds and Vehicle Speed')
grid on
legend('Location','Best');
box on
text(0.1,0.1,'Wheel Speeds estimated with unloaded radius','Units','normalized','Color',[0.6 0.6 0.6])

ah(2) = subplot(2,1,2);
simlog_tDrv  = logsoutRes.get('Grader').Values.Powertrain.trqDrv.Data;
plot(simlog_t, simlog_tDrv, 'LineWidth', 1,'DisplayName','Trans. Output')
hold off

title('Powertrain Torque')
ylabel('Torque (N*m)')
xlabel('Time (s)')
legend('Location','Best');
grid on









