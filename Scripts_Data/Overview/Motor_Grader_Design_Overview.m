%% Motor Grader Design with Simscape(TM)
%
% <<Motor_Grader_Design_Overview.png>>
% 
% This repository contains models and code to help engineers design
% motor graders. 
%
% * *Size actuators* using prescribed motion for cylinder positions. 
% * *Tune control systems* using abstract actuation systems.
% * *Explore kinematics* of drawbar linkage.
% * *Measure mechanical loads* with abstract models for fast simulation.
% * *Test powertrain architectures* with CVT models, including power split designs.
% * *Develop operator assist* algorithms within Simulink

% Copyright 2025 The MathWorks, Inc.

%%
% *Complete Motor Grader Model*
% 
% # Motor Grader Model: <matlab:open_system('sm_motor_grader') Model>, <matlab:web('sm_motor_grader.html') Documentation>
% # Motor Grader Powertrain: <matlab:web('sm_motor_grader_powertrain.html') Documentation>
%
% *Subsystem Test Models*
%
% # Blade Actuation: <matlab:open_system('sm_motor_grader_Blade') Model>, <matlab:web('sm_motor_grader_Blade.html') Documentation>
% # Blade Loads: <matlab:open_system('sm_motor_grader_BladeLoad') Model>, <matlab:web('sm_motor_grader_BladeLoad.html') Documentation>
% # Front Axle: <matlab:open_system('sm_motor_grader_FrameF') Model>, <matlab:web('sm_motor_grader_FrameF.html') Documentation>
% # Lift Assembly: <matlab:open_system('sm_motor_grader_LiftAssembly') Model>, <matlab:web('sm_motor_grader_LiftAssembly.html') Documentation>
% # Rear Frame: <matlab:open_system('sm_motor_grader_FrameR') Model>, <matlab:web('sm_motor_grader_FrameR.html') Documentation>
% # Drive and Steer: <matlab:open_system('sm_motor_grader_Drive_Steer') Model>, <matlab:web('sm_motor_grader_Drive_Steer.html') Documentation>
% # Simple Lift Assembly: <matlab:open_system('sm_LiftAssembly_simple') Model>
%
% *CVT Test Models*
%
% # Hydromechanical Power Split CVT: <matlab:open_system('ssc_hydromech_power_split_cvt') Model>, <matlab:web('ssc_hydromech_power_split_cvt.html') Documentation>
% # Hydromechanical Power Split CVT with Engine: <matlab:open_system('ssc_hydromech_power_split_cvt_engine') Model>, <matlab:web('ssc_hydromech_power_split_cvt_engine.html') Documentation>
%
% *Workflows*
%
% # Tire Point Cloud from STL: <matlab:web('tire_point_cloud_workflow.html') Documentation>
% # Pin to Link, Joint Mode Normal: <matlab:open_system('jointModeTest_Normal') Model>, <matlab:web('jointModeTest_Normal.html') Documentation>
% # Pin to Link, Joint Mode Locked: <matlab:open_system('jointModeTest_Locked') Model>, <matlab:web('jointModeTest_Locked.html') Documentation>