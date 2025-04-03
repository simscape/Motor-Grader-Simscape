%% Motor Grader: Powertrain
% 
% <<sm_motor_grader_Overview.png>>
%
% This example models a motor grader. The motor grader has an articulated
% chassis, four driven wheels on its rear frame, a fully actuated drawbar
% and blade, and a front axle with lean and steer cylinders. 
%
% This documentation exercises different powertrain models, including
% several continuously variable transmission (CVT) options, as well as
% abstract options with ideal torque sources driving the input shaft to the
% driveline or applying torque directly to the wheels.
%
% (<matlab:web('Motor_Grader_Design_Overview.html') return to Motor Grader Design with Simscape Overview>)
%
% Copyright 2025 The MathWorks, Inc.

%% Model
%
% <matlab:open_system('sm_motor_grader'); Open Model>

open_system('sm_motor_grader')

ann_h = find_system('sm_motor_grader','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i = 1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off')
end

%% Motor Grader Model
%
% The motor grader model consists of the actuation system, powertrain, and
% the vehicle chassis with drawbar and blade.  The surface upon which the
% vehicle drives can be selected as well.
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader','force')

%% Vehicle Model
%
% The vehicle model contains the articulated chassis with a hinge
% connecting the rear frame and the main frame which holds the drawbar and
% blade. Four wheels on the rear frame and two wheels on the front frame
% ride over the selected surface.  The powertrain can be connected to all of
% the wheels depending upon which model is selected.
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader/Vehicle','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader/Vehicle','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader/Vehicle','force')

%% Frame Model
%
% The frame is connected to the components that control the positioning of
% the blade, including the lift assembly, drawbar, and the circle. The
% actuation system is connected to five actuators that control the position
% of the blade.
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader/Vehicle/Frame','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader/Vehicle/Frame','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader/Vehicle/Frame','force')

%% Powertrain: Torque at Wheels
%
% The model below shows ideal torque sources that apply torque to each
% wheel.  This abstract model does not attempt to capture powertrain
% behavior, it is a very simple model that simply acts to get the vehicle
% to travel at the target speed.  Minimizing computation in the powertrain
% system lets the model run faster.
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader/Powertrain/Torque4','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','Wheels')
set_param('sm_motor_grader', 'SimulationCommand', 'update')
set_param('sm_motor_grader/Motor Grader/Powertrain','LinkStatus','none')
set_param('sm_motor_grader/Motor Grader/Powertrain/Torque4','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader/Powertrain/Torque4','force')

%% Powertrain: Torque at Driveline
%
% The model below shows an ideal torque source that applies torque to the
% input shaft of the mechanical driveline.  This abstract model assumes the
% engine and CVT perform as required and lets the investigation focus on
% the driveline and on the tire-ground interaction.
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader/Powertrain/Torque1','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','Driveline')
set_param('sm_motor_grader', 'SimulationCommand', 'update')
set_param('sm_motor_grader/Motor Grader/Powertrain/Torque1','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader/Powertrain/Torque1','force')

%% Powertrain: Driveline
%
% The model below represents the mechanical connection between the output
% of the transmission and the four driven wheels.  Differentials at the
% front and rear enable the engine to power both wheels and for those
% wheels to turn at different rates when the vehicle is in a turn.
% Compliance elements abstractly model shaft deflection in the driveline.
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader/Powertrain/Torque1/Driveline','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader/Powertrain/Torque1/Driveline','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader/Powertrain/Torque1/Driveline','force')

%% Powertrain: CVT Abstract
%
% The model below is an abstract representation of a continuously variable
% transmission (CVT). The transmission of power between the engine and the
% drivetrain is via a variable ratio gear. This abstract model can be used
% to determine requirements for a CVT even before a technology for the CVT
% has been chosen. A CVT enables the engine to spin at a near constant
% speed while the vehicle speed and load from the power take-off shaft
% varies.
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader/Powertrain/CVT/Transmission/Abstract','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','CVT Abstract')
set_param('sm_motor_grader', 'SimulationCommand', 'update')
set_param('sm_motor_grader/Motor Grader/Powertrain/CVT','LinkStatus','none')
set_param('sm_motor_grader/Motor Grader/Powertrain/CVT/Transmission/Abstract','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader/Powertrain/CVT/Transmission/Abstract','force')

%% Powertrain: CVT Electrical
%
% The model below represents an electrical continuously variable
% transmission (CVT). The transmission of power between the engine and the
% drivetrain is via electrical connections between two electric machines. A
% controller adjusts the torque requests to the motor and generator to
% achieve a target speed ratio. This ensures that the engine can spin at a
% near constant speed while the vehicle speed and load from the power
% take-off shaft varies.
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader/Powertrain/CVT/Transmission/Electrical','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','CVT Electrical')
set_param('sm_motor_grader', 'SimulationCommand', 'update')
set_param('sm_motor_grader/Motor Grader/Powertrain/CVT','LinkStatus','none')
set_param('sm_motor_grader/Motor Grader/Powertrain/CVT/Transmission/Electrical','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader/Powertrain/CVT/Transmission/Electrical','force')

%% Powertrain: CVT Hydrostatic
%
% The model below represents a hydrostatic continuously variable
% transmission (CVT). The transmission of power between the engine and the
% drivetrain is via a hydraulic pump and motor.  The displacement of the
% pump determines the ratio between the speed of the engine shaft and
% driveshaft. This ensures that the engine can spin at a near constant
% speed while the vehicle speed and load from the power take-off shaft
% varies.
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader/Powertrain/CVT/Transmission/Hydrostatic','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','CVT Hydrostatic')
set_param('sm_motor_grader', 'SimulationCommand', 'update')
set_param('sm_motor_grader/Motor Grader/Powertrain/CVT','LinkStatus','none')
set_param('sm_motor_grader/Motor Grader/Powertrain/CVT/Transmission/Hydrostatic','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader/Powertrain/CVT/Transmission/Hydrostatic','force')

%% Powertrain: CVT Power Split
%
% The model below represents a power split hydromechanical continuously
% variable transmission (CVT). Parallel hydraulic and mechanical paths
% ensure that the engine can spin at a near constant speed while the
% vehicle speed and load from the power take-off shaft varies.  
%
% <matlab:open_system('sm_motor_grader');open_system('sm_motor_grader/Motor%20Grader/Powertrain/CVT/Transmission/Power%20Spli%20Hydromech','force'); Open Subsystem>

set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','CVT Power Split HM')
set_param('sm_motor_grader', 'SimulationCommand', 'update')
set_param('sm_motor_grader/Motor Grader/Powertrain/CVT','LinkStatus','none')
set_param('sm_motor_grader/Motor Grader/Powertrain/CVT/Transmission/Power Split Hydromech','LinkStatus','none')
open_system('sm_motor_grader/Motor Grader/Powertrain/CVT/Transmission/Power Split Hydromech','force')

%% Simulation Results: Grading Test, Grid, Wheels
% The grading test is run with torque applied to the wheels.  The test is
% conducted open loop, where the steering commands do not take into account
% the location or orientation of the grader.

set_param('sm_motor_grader/Motor Grader','popup_actuator_model','Position')
set_param('sm_motor_grader/Motor Grader','popup_actuator_model_lift','Position')
set_param('sm_motor_grader/Motor Grader','popup_blade_ground_contact','Loads');
set_param('sm_motor_grader/Motor Grader','popup_ground_contact','Magic Formula');
set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','Wheels');
set_param([bdroot '/Inputs'],'test_source','Data');
set_param([bdroot '/Motor Grader'],'popup_surface_type','Grid');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader')

sm_motor_grader_plot1whlspd(logsout_sm_motor_grader,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
sm_motor_grader_plot7steercyl(logsout_sm_motor_grader);

%% Simulation Results: Grading Test, Grid, Driveline
% The grading test is run with torque applied at the input shaft to the
% driveline. The test is conducted open loop, where the steering commands do
% not take into account the location or orientation of the grader.

set_param('sm_motor_grader/Motor Grader','popup_actuator_model','Position')
set_param('sm_motor_grader/Motor Grader','popup_actuator_model_lift','Position')
set_param('sm_motor_grader/Motor Grader','popup_blade_ground_contact','Loads');
set_param('sm_motor_grader/Motor Grader','popup_ground_contact','Magic Formula');
set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','Driveline');
set_param([bdroot '/Inputs'],'test_source','Data');
set_param([bdroot '/Motor Grader'],'popup_surface_type','Grid');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader')

sm_motor_grader_plot1whlspd(logsout_sm_motor_grader,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
sm_motor_grader_plot7steercyl(logsout_sm_motor_grader);

%% Simulation Results: Grading Test, Grid, CVT Abstract
% The grading test is run with the powertrain modeled as an engine
% and an abstract CVT model. The test is conducted open loop, where the
% steering commands do not take into account the location or orientation of
% the grader.

set_param('sm_motor_grader/Motor Grader','popup_actuator_model','Position')
set_param('sm_motor_grader/Motor Grader','popup_actuator_model_lift','Position')
set_param('sm_motor_grader/Motor Grader','popup_blade_ground_contact','Loads');
set_param('sm_motor_grader/Motor Grader','popup_ground_contact','Magic Formula');
set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','CVT Abstract');
set_param([bdroot '/Inputs'],'test_source','Data');
set_param([bdroot '/Motor Grader'],'popup_surface_type','Grid');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader')

sm_motor_grader_plot1whlspd(logsout_sm_motor_grader,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
sm_motor_grader_plot7steercyl(logsout_sm_motor_grader);

%% Simulation Results: Grading Test, Grid, CVT Electrical
% The grading test is run with the powertrain modeled as an engine
% and an electrial CVT model. The test is conducted open loop, where the
% steering commands do not take into account the location or orientation of
% the grader.

set_param('sm_motor_grader/Motor Grader','popup_actuator_model','Position')
set_param('sm_motor_grader/Motor Grader','popup_actuator_model_lift','Position')
set_param('sm_motor_grader/Motor Grader','popup_blade_ground_contact','Loads');
set_param('sm_motor_grader/Motor Grader','popup_ground_contact','Magic Formula');
set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','CVT Electrical');
set_param([bdroot '/Inputs'],'test_source','Data');
set_param([bdroot '/Motor Grader'],'popup_surface_type','Grid');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader')

sm_motor_grader_plot1whlspd(logsout_sm_motor_grader,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
sm_motor_grader_plot7steercyl(logsout_sm_motor_grader);

%% Simulation Results: Grading Test, Grid, CVT Hydrostatic
% The grading test is run with the powertrain modeled as an engine and a
% hydrostatic CVT model. The test is conducted open loop, where the steering
% commands do not take into account the location or orientation of the
% grader.

set_param('sm_motor_grader/Motor Grader','popup_actuator_model','Position')
set_param('sm_motor_grader/Motor Grader','popup_actuator_model_lift','Position')
set_param('sm_motor_grader/Motor Grader','popup_blade_ground_contact','Loads');
set_param('sm_motor_grader/Motor Grader','popup_ground_contact','Magic Formula');
set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','CVT Hydrostatic');
set_param([bdroot '/Inputs'],'test_source','Data');
set_param([bdroot '/Motor Grader'],'popup_surface_type','Grid');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader')

sm_motor_grader_plot1whlspd(logsout_sm_motor_grader,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
sm_motor_grader_plot7steercyl(logsout_sm_motor_grader);

%% Simulation Results: Grading Test, Grid, CVT Power Split
% The grading test is run with with the powertrain modeled as an engine and
% an power split hydromechanical CVT. The test is conducted open loop, where
% the steering commands do not take into account the location or
% orientation of the grader.

set_param('sm_motor_grader/Motor Grader','popup_actuator_model','Position')
set_param('sm_motor_grader/Motor Grader','popup_actuator_model_lift','Position')
set_param('sm_motor_grader/Motor Grader','popup_blade_ground_contact','Loads');
set_param('sm_motor_grader/Motor Grader','popup_ground_contact','Magic Formula');
set_param('sm_motor_grader/Motor Grader','popup_powertrain_config','CVT Power Split HM');
set_param([bdroot '/Inputs'],'test_source','Data');
set_param([bdroot '/Motor Grader'],'popup_surface_type','Grid');
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');
sim('sm_motor_grader')

sm_motor_grader_plot1whlspd(logsout_sm_motor_grader,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
sm_motor_grader_plot7steercyl(logsout_sm_motor_grader);

%%

%clear all
close all
bdclose all
