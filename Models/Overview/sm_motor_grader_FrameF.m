%% Motor Grader Front Axle
% 
% <<sm_motor_grader_FrameF_Overview.png>>
%
% This example models the front axle of a motor grader.  The model includes
% the actuators that lean and steer the front wheels.  The actuators can move 
% using prescribed motion to determine the amount of force the actuators
% need to provide.  Abstract actuator models can be used to begin tuning
% the control system.
%
% (<matlab:web('Motor_Grader_Design_Overview.html') return to Motor Grader Design with Simscape Overview>)
%
% Copyright 2025 The MathWorks, Inc.

%% Model
%
% <matlab:open_system('sm_motor_grader_FrameF'); Open Model>

open_system('sm_motor_grader_FrameF')

ann_h = find_system('sm_motor_grader_FrameF','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i = 1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off')
end

%% Motor Grader Front Axle Model
%
% The front frame controls the steering and lean angle of the front wheels.
% The steering actuators point the wheels along the path the front axle
% should follow.  That combined with the articulation angle controls the
% path of the vehicle.  The lean cylinders control the angle the wheels
% lean towards or away from the frame.  This permits the wheels to provide
% better traction and resist the forces from the load on the blade that
% will drag the grader off course.  Lean also helps the grader stay on the
% desired path when the grader is driving along a steep slope. The pivot
% permits the axle to rotate about its longitudinal axis, keeping both
% wheels on the ground when on uneven terrain.
%
% The R and L ports permit the wheels to connect to the powertrain in the
% event the design has powered front wheels.
%
% <matlab:open_system('sm_motor_grader_FrameF');open_system('sm_motor_grader_FrameF/Frame%20Front','force'); Open Subsystem>

set_param('sm_motor_grader_FrameF/Frame Front','LinkStatus','none')
open_system('sm_motor_grader_FrameF/Frame Front','force')

%% Simulation Results: Grading Test
%
% The plots below show the performance of the lean and steer cylinders
% while executing the grading test on the front axle only.  The front axle
% can move up and down and roll about its longitudinal axis.
%
% *Position Actuation*
%
% In the first set of plots, prescribed motion is used for all actuation
% systems. The required force to reach these positions is calculated by the
% simulation.

set_param('sm_motor_grader_FrameF/Frame Front','popup_actuator_model','Position');
set_param('sm_motor_grader_FrameF/Actuation','popup_actuator_model','Position');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader_FrameF')

sm_motor_grader_plot6leancyl(logsout_sm_motor_grader_FrameF);
sm_motor_grader_plot7steercyl(logsout_sm_motor_grader_FrameF);

%%
% *Shaft Actuation*
%
% The same test is run again, this time applying force and torque at the
% actuators.  This closed-loop actuation with abstract actuators enables us
% to start the process of tuning the controllers and identifying
% requirements for bandwidth and sensor accuracy.

set_param('sm_motor_grader_FrameF/Frame Front','popup_actuator_model','Shaft');
set_param('sm_motor_grader_FrameF/Actuation','popup_actuator_model','Shaft');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader_FrameF')

sm_motor_grader_plot6leancyl(logsout_sm_motor_grader_FrameF);
sm_motor_grader_plot7steercyl(logsout_sm_motor_grader_FrameF);

%%

%clear all
close all
bdclose all
