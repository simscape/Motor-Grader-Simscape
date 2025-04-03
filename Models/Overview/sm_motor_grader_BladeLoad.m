%% Motor Grader Blade Ground Load Model
% 
% <<sm_motor_grader_BladeLoad_Overview.png>>
%
% This example models the ground loads on a motor grader blade.  The
% ground loads are deliberately modeled as abstractly as possible to 
% limit the number of parameters to be tuned and so that the simulation
% runs as quickly as possible
%
% (<matlab:web('Motor_Grader_Design_Overview.html') return to Motor Grader Design with Simscape Overview>)
%
% Copyright 2025 The MathWorks, Inc.

%% Model
%
% <matlab:open_system('sm_motor_grader_BladeLoad'); Open Model>

open_system('sm_motor_grader_BladeLoad')

ann_h = find_system('sm_motor_grader_BladeLoad','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i = 1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off')
end

%% Motor Grader Blade Model
%
% The blade is modeled by directly referencing the CAD geometry using the
% File Solid block. The blade connects to the side shift actuator and the
% bracket that holds the blade.
% 
% The forces on the blade from the ground can be configured in the Ground
% Forces subsystem.  It can be configured to have no loads from the ground,
% only vertical forces, or load from scraping against the terrain.
%
% <matlab:open_system('sm_motor_grader_BladeLoad');open_system('sm_motor_grader_BladeLoad/Blade','force'); Open Subsystem>

set_param('sm_motor_grader_BladeLoad/Blade','LinkStatus','none')
open_system('sm_motor_grader_BladeLoad/Blade','force')

%% Ground Forces on Blade
%
% This subsystem applies a custom force to the blade.
%
% * Subsystem Calculate Blade load calculates the force to apply at the
% frames connected to the L and R ports.
% * The External Force blocks apply the force at frames connected at the L
% and R ports
% * The Variable Cylinder blocks provide a visual indication of each force
% applied by varying the size of a cylinder.  
%
% 
% <matlab:open_system('sm_motor_grader_BladeLoad');open_system('sm_motor_grader_BladeLoad/Blade/Ground%20Forces/Loads','force'); Open Subsystem>

set_param('sm_motor_grader_BladeLoad/Blade/Ground Forces/Loads','LinkStatus','none')
open_system('sm_motor_grader_BladeLoad/Blade/Ground Forces/Loads','force')

%% Simulation Results: Blade Edge Above Ground
%
% The plots below show the loads applied at the ends of the blade. During
% the test, the blade is moved forward slowly and it is rotated about its
% own vertical axis. The blade starts slightly above the ground and its
% vertical axis is tipped slightly forward from vertical.  As a result,
% only one end is below ground at any time and only one force is non-zero.

set_param([bdroot '/Transform Orient Blade Geometry'],'TranslationCartesianOffset','[0.2844 0 0.3+0.05]');
set_param([bdroot '/Blade'],'popup_blade_ground_contact','Loads');
sim('sm_motor_grader_BladeLoad')
sm_motor_grader_plot11bladegroundloads(logsout_motor_grader_BladeLoad);


%% Simulation Results: Blade Edge Below Ground
%
% The plots below show the loads applied at the ends of the blade. During
% the test, the blade is moved forward slowly and it is rotated about its
% own vertical axis. The blade starts slightly below the ground and its
% vertical axis is tipped slightly forward from vertical.  As a result,
% the total force is always non-zero and varies with the relative angle of
% the blade to its forward motion.

set_param([bdroot '/Transform Orient Blade Geometry'],'TranslationCartesianOffset','[0.2844 0 0.3-0.05]');
sim('sm_motor_grader_BladeLoad')
sm_motor_grader_plot11bladegroundloads(logsout_motor_grader_BladeLoad);

%%

%clear all
close all
bdclose all
