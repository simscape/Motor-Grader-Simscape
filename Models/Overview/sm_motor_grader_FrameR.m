%% Motor Grader Rear Frame
% 
% <<sm_motor_grader_FrameR_Overview.png>>
%
% This example models the rear frame of a motor grader.  An abstract
% torque source drives the wheels.
%
% (<matlab:web('Motor_Grader_Design_Overview.html') return to Motor Grader Design with Simscape Overview>)
%
% Copyright 2025 The MathWorks, Inc.

%% Model
%
% <matlab:open_system('sm_motor_grader_FrameR'); Open Model>

open_system('sm_motor_grader_FrameR')

ann_h = find_system('sm_motor_grader_FrameR','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i = 1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off')
end

%% Rear Frame Model
%
% The rear frame models the inertia for the drive unit for the rear wheels,
% including the power source for the powertrain. The connection between the
% wheels and the powertrain are the 1D mechanical ports FL, FR, RL, and RR.
% The mechanical connection between the wheels, including the components
% such as differentials, is handled within the powertrain subsystem.
%
% <matlab:open_system('sm_motor_grader_FrameR');open_system('sm_motor_grader_FrameR/Frame%20Rear','force'); Open Subsystem>

set_param('sm_motor_grader_FrameR/Frame Rear','LinkStatus','none')
open_system('sm_motor_grader_FrameR/Frame Rear','force')

%% Powertrain: Torque at Wheels
%
% The model below shows ideal torque sources that apply torque to each
% wheel.  This abstract model does not attempt to capture powertrain
% behavior, it is a very simple model that simply acts to get the vehicle
% to travel at the target speed.  Minimizing computation in the powertrain
% system lets the model run faster.
%
% <matlab:open_system('sm_motor_grader_FrameR');open_system('sm_motor_grader_FrameR/Powertrain/Torque4','force'); Open Subsystem>

set_param('sm_motor_grader_FrameR/Powertrain','popup_powertrain_config','Wheels')
set_param('sm_motor_grader_FrameR', 'SimulationCommand', 'update')
set_param('sm_motor_grader_FrameR/Powertrain','LinkStatus','none')
set_param('sm_motor_grader_FrameR/Powertrain/Torque4','LinkStatus','none')
open_system('sm_motor_grader_FrameR/Powertrain/Torque4','force')

%% Powertrain: Torque at Driveline
%
% The model below shows an ideal torque source that applies torque to the
% input shaft of the mechanical driveline.  This abstract model assumes the
% engine and CVT perform as required and lets the investigation focus on
% the driveline and on the tire-ground interaction.
%
% <matlab:open_system('sm_motor_grader_FrameR');open_system('sm_motor_grader_FrameR/Powertrain/Torque1','force'); Open Subsystem>

set_param('sm_motor_grader_FrameR/Powertrain','popup_powertrain_config','Driveline')
set_param('sm_motor_grader_FrameR', 'SimulationCommand', 'update')
set_param('sm_motor_grader_FrameR/Powertrain/Torque1','LinkStatus','none')
open_system('sm_motor_grader_FrameR/Powertrain/Torque1','force')

%% Powertrain: Driveline
%
% The model below represents the mechanical connection between the output
% of the transmission and the four driven wheels.  Differentials at the
% front and rear enable the engine to power both wheels and for those
% wheels to turn at different rates when the vehicle is in a turn.
% Compliance elements abstractly model shaft deflection in the driveline.
%
% <matlab:open_system('sm_motor_grader_FrameR');open_system('sm_motor_grader_FrameR/Powertrain/Torque1/Driveline','force'); Open Subsystem>

set_param('sm_motor_grader_FrameR/Powertrain/Torque1/Driveline','LinkStatus','none')
open_system('sm_motor_grader_FrameR/Powertrain/Torque1/Driveline','force')


%% Tire: Spherical
%
% This tire model uses the Spatial Contact Force block to model normal and
% friction forces between the tire and the ground.  The geometry of the
% tire is abstractly represented as a sphere to minimize computation. A
% generic force law is used in the Spatial Contact Force block.  Custom
% force laws can be integrated with this block where the block measures
% quantities such as relative location, velocity, and tangential velocity
% so that you can calculate the forces and torques on the wheel.
%
% <matlab:open_system('sm_motor_grader_FrameR');open_system('sm_motor_grader_FrameR/Frame%20Rear/Wheel%20FL/Contact/Sphere','force'); Open Subsystem>

set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Sphere');
set_param('sm_motor_grader_FrameR', 'SimulationCommand', 'update')
set_param('sm_motor_grader_FrameR/Frame Rear/Wheel FL/Contact/Sphere','LinkStatus','none')
open_system('sm_motor_grader_FrameR/Frame Rear/Wheel FL/Contact/Sphere','force')

%% Tire: Magic Formula
%
% This tire model uses the Magic Formula Tire Force and Torque block to
% model forces and torques acting between the tire and the ground.  The
% geometry of the tire is abstractly represented as a ring in the central
% plane of the tire. The Magic Formula Tire equations are used to calculate
% the forces and torques.  See also the Custom Tire Force and Torque block
% for custom tire models.
%
% <matlab:open_system('sm_motor_grader_FrameR');open_system('sm_motor_grader_FrameR/Frame%20Rear/Wheel%20FL/Contact/Magic%20Formula','force');Open Subsystem>

set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Magic Formula');
set_param('sm_motor_grader_FrameR', 'SimulationCommand', 'update')
set_param('sm_motor_grader_FrameR/Frame Rear/Wheel FL/Contact/Magic Formula','LinkStatus','none')
open_system('sm_motor_grader_FrameR/Frame Rear/Wheel FL/Contact/Magic Formula','force')

%% Tire: Point Cloud
%
% This tire model uses the Spatial Contact Force block to model normal and
% friction forces between the tire and the ground.  The geometry of the
% tire is represented as a point cloud which permits arbitrary tire profiles. A
% generic force law is used in the Spatial Contact Force block.  Custom
% force laws can be integrated with this block where the block measures
% quantities such as relative location, velocity, and tangential velocity
% so that you can calculate the forces and torques on the wheel. The
% performance of this block depends heavily on the number and location of
% the points in the point cloud.
%
% <matlab:open_system('sm_motor_grader_FrameR');open_system('sm_motor_grader_FrameR/Frame%20Rear/Wheel%20FL/Contact/Point%20Cloud','force'); Open Subsystem>

set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Point Cloud');
set_param('sm_motor_grader_FrameR', 'SimulationCommand', 'update')
set_param('sm_motor_grader_FrameR/Frame Rear/Wheel FL/Contact/Point Cloud','LinkStatus','none')
open_system('sm_motor_grader_FrameR/Frame Rear/Wheel FL/Contact/Point Cloud','force')

%% Simulation Results: Spherical Tires
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Spatial Contact Force
% block with sphere geometry for the tire was used.

set_param('sm_motor_grader_FrameR/Powertrain','popup_powertrain_config','Wheels')
set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Sphere')
sim('sm_motor_grader_FrameR')

[~, resSp] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Simulation Results: Magic Formula Tires
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Magic Formula Tire was used.

set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Magic Formula')
sim('sm_motor_grader_FrameR')

[~, resMF] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Simulation Results: Point Cloud Tires, Cylinder
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Spatial Contact Force
% block with point cloud geometry for the tire was used.  The point cloud
% distributes the points evenly on a cylinder whose surface is at a single
% fixed radius at the surface of the tire.

set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Point Cloud')
motGradParams.tire.ptcld = motGradParams.tire.ptcld_cyl;
sim('sm_motor_grader_FrameR')

[~, resCy] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Simulation Results: Point Cloud Tires, Outer Tread
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Spatial Contact Force
% block with point cloud geometry for the tire was used.  The points in the
% point cloud were extracted from the CAD geometry for the tire and only
% includes points outside a specified radius.


set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Point Cloud')
motGradParams.tire.ptcld = motGradParams.tire.ptcld_loc;
sim('sm_motor_grader_FrameR')

[~, resTr] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Simulation Results: Point Cloud Tires, Convex Hull
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Spatial Contact Force
% block with point cloud geometry for the tire was used.  The points in the
% point cloud were extracted from the CAD geometry for the tire and only
% includes points on the surface of a convex hull for the tire.


set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Point Cloud')
motGradParams.tire.ptcld = motGradParams.tire.ptcld_hull;
sim('sm_motor_grader_FrameR')

[~, resHu] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Comparison of Results for Tire Models
%
% This plot shows the speed of the front left wheel on the rear frame with
% each of the different tire models.  The point cloud tires show
% oscillations in speed.  The point cloud tires capture the rugged profile
% of the tire, and on hard surfaces these vibrations will be transmitted
% back through the driveline system.

figure
plot(resSp.t,resSp.vRFL,'LineWidth',1,'DisplayName','Sphere');
hold on
plot(resMF.t,resMF.vRFL,'LineWidth',1,'DisplayName','Magic Formula');
plot(resCy.t,resCy.vRFL,'LineWidth',1,'DisplayName','Cylinder');
plot(resHu.t,resHu.vRFL,'LineWidth',1,'DisplayName','Hull');
plot(resTr.t,resTr.vRFL,'LineWidth',1,'DisplayName','Tread');
hold off
ylabel('Speed (m/s)')
xlabel('Time (s)')
title('Wheel Speeds and Vehicle Speed')
grid on
legend('Location','Best');
box on
axis([7.5 9.5 5.2 6.2])

%% Simulation Results: Driveline
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Magic Formula Tire was
% used and the wheels are connected via a mechanical driveline with front
% and rear differentials.

set_param('sm_motor_grader_FrameR/Powertrain','popup_powertrain_config','Driveline')
set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Magic Formula')
sim('sm_motor_grader_FrameR')

[~, resMFDr] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Simulation Results: CVT Abstract
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Magic Formula Tire was
% used and the wheels are connected via a mechanical driveline with front
% and rear differentials and powered by an engine via an abstract CVT.

set_param('sm_motor_grader_FrameR/Powertrain','popup_powertrain_config','CVT Abstract')
set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Magic Formula')
sim('sm_motor_grader_FrameR')

[~, resMFAb] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Simulation Results: CVT Electrical
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Magic Formula Tire was
% used and the wheels are connected via a mechanical driveline with front
% and rear differentials and powered by an engine via an electrical CVT.

set_param('sm_motor_grader_FrameR/Powertrain','popup_powertrain_config','CVT Electrical')
set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Magic Formula')
sim('sm_motor_grader_FrameR')

[~, resMFEl] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Simulation Results: CVT Hydrostatic
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Magic Formula Tire was
% used and the wheels are connected via a mechanical driveline with front
% and rear differentials and powered by an engine via an hydrostatic CVT.

set_param('sm_motor_grader_FrameR/Powertrain','popup_powertrain_config','CVT Hydrostatic')
set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Magic Formula')
sim('sm_motor_grader_FrameR')

[~, resMFHy] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Simulation Results: CVT Power Split
%
% The results below were generated by a simulation with a simple
% acceleration and deceleration.  In this test, the Magic Formula Tire was
% used and the wheels are connected via a mechanical driveline with front
% and rear differentials and powered by an engine via a power split
% hydromechanical CVT.

set_param('sm_motor_grader_FrameR/Powertrain','popup_powertrain_config','CVT Power Split HM')
set_param('sm_motor_grader_FrameR/Frame Rear','popup_ground_contact','Magic Formula')
sim('sm_motor_grader_FrameR')

[~, resMFPS] = sm_motor_grader_plot1whlspd(logsout_sm_motor_grader_FrameR,motGradParams.groundContact.tireRad,motGradParams.groundContact.tireRad);
text(0.05,0.95,[num2str(length(tout)) ' Steps'],'Units','normalized','Color',[0.6 0.6 0.6])

%% Comparison of Results for Powertrain Models
%
% This plot shows the speed of the front left wheel on the rear frame with
% each of the different transmission models.  The shift changes in the
% power-split transmission are visible, as are the responsiveness of the
% control system for each type of CVT.

figure
plot(resMFDr.t,resMFDr.vRFL,'LineWidth',1,'DisplayName','Driveline');
hold on
plot(resMFAb.t,resMFAb.vRFL,'LineWidth',1,'DisplayName','CVT Abstract');
plot(resMFEl.t,resMFEl.vRFL,'LineWidth',1,'DisplayName','CVT Electrical');
plot(resMFHy.t,resMFHy.vRFL,'LineWidth',1,'DisplayName','CVT Hydrostatic');
plot(resMFPS.t,resMFPS.vRFL,'LineWidth',1,'DisplayName','CVT Power Split');
hold off
ylabel('Speed (m/s)')
xlabel('Time (s)')
title('Wheel Speeds and Vehicle Speed')
grid on
legend('Location','Best');
box on

%%

%clear all
close all
bdclose all
