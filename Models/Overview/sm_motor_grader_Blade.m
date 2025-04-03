%% Motor Grader Blade Actuation
% 
% <<sm_motor_grader_Blade_Overview.png>>
%
% This example models the tilt and shift actuators for the blade of a motor
% grader. This simple test harness omits the rest of the complexity of the
% motor grader. The actuation system can be driven using prescribed motion
% to determine the required actuator size.  Ideal actuators can be used to
% begin the process of tuning controllers.
%
% (<matlab:web('Motor_Grader_Design_Overview.html') return to Motor Grader Design with Simscape Overview>)
%
% Copyright 2025 The MathWorks, Inc.

%% Model
%
% <matlab:open_system('sm_motor_grader_Blade'); Open Model>

open_system('sm_motor_grader_Blade')

ann_h = find_system('sm_motor_grader_Blade','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i = 1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off')
end

%% Motor Grader Blade Model
%
% This system models the blade and the bracket that holds the blade.  One
% actuator can tilt the bracket holding the blade about its lateral axis.
% The other actuator shifts the blade along its lateral axis with respect
% to the bracket.
%
% <matlab:open_system('sm_motor_grader_Blade');open_system('sm_motor_grader_Blade/Blade','force'); Open Subsystem>

set_param('sm_motor_grader_Blade/Blade','LinkStatus','none')
open_system('sm_motor_grader_Blade/Blade','force')

%% Simulation Results: Grading Test
%
% The plots below show the results of the grading test with the blade
% bracket sitting on a test harness.  The blade bracket can only tilt.
%
% *Position Actuation*
%
% In the first set of plots, prescribed motion is used for all actuation
% systems. The required force to reach these positions is calculated by the
% simulation.

set_param('sm_motor_grader_Blade/Blade','popup_actuator_model','Position')
set_param('sm_motor_grader_Blade/Actuator Shift','LabelModeActiveChoice','Position')
set_param('sm_motor_grader_Blade/Actuator Tilt','LabelModeActiveChoice','Position')
set_param('sm_motor_grader_Blade/Blade','popup_blade_ground_contact','None');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader_Blade')

sm_motor_grader_plot2bladeshift(logsout_sm_motor_grader_Blade);
sm_motor_grader_plot3bladetilt(logsout_sm_motor_grader_Blade);

%%
% *Shaft Actuation*
%
% The same test is run again, this time applying force and torque at the
% actuators.  This closed-loop actuation with abstract actuators enables us
% to start the process of tuning the controllers and identifying
% requirements for bandwidth and sensor accuracy.

set_param('sm_motor_grader_Blade/Blade','popup_actuator_model','Shaft')
set_param('sm_motor_grader_Blade/Actuator Shift','LabelModeActiveChoice','Shaft')
set_param('sm_motor_grader_Blade/Actuator Tilt','LabelModeActiveChoice','Shaft')
set_param('sm_motor_grader_Blade/Blade','popup_blade_ground_contact','None');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader_Blade')

sm_motor_grader_plot2bladeshift(logsout_sm_motor_grader_Blade);
sm_motor_grader_plot3bladetilt(logsout_sm_motor_grader_Blade);


%% Simulation Results: Blade Test
%
% The plots below show a test where the tilt and shift actuators are both
% active in a simple text cycle.
%
% *Position Actuation*
%
% In the first set of plots, prescribed motion is used for all actuation
% systems. The required force to reach these positions is calculated by the
% simulation.

set_param('sm_motor_grader_Blade/Blade','popup_actuator_model','Position')
set_param('sm_motor_grader_Blade/Actuator Shift','LabelModeActiveChoice','Position')
set_param('sm_motor_grader_Blade/Actuator Tilt','LabelModeActiveChoice','Position')
set_param('sm_motor_grader_Blade/Blade','popup_blade_ground_contact','None');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'BladeMotionTest');
sim('sm_motor_grader_Blade')

sm_motor_grader_plot2bladeshift(logsout_sm_motor_grader_Blade);
sm_motor_grader_plot3bladetilt(logsout_sm_motor_grader_Blade);

%%
% *Shaft Actuation*
%
% The same test is run again, this time applying force and torque at the
% actuators.  This closed-loop actuation with abstract actuators enables us
% to start the process of tuning the controllers and identifying
% requirements for bandwidth and sensor accuracy.

set_param('sm_motor_grader_Blade/Blade','popup_actuator_model','Shaft')
set_param('sm_motor_grader_Blade/Actuator Shift','LabelModeActiveChoice','Shaft')
set_param('sm_motor_grader_Blade/Actuator Tilt','LabelModeActiveChoice','Shaft')
set_param('sm_motor_grader_Blade/Blade','popup_blade_ground_contact','None');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'BladeMotionTest');
sim('sm_motor_grader_Blade')

sm_motor_grader_plot2bladeshift(logsout_sm_motor_grader_Blade);
sm_motor_grader_plot3bladetilt(logsout_sm_motor_grader_Blade);


%%

%clear all
close all
bdclose all
