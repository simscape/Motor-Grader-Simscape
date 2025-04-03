%% Pin Link Test, Joint Mode Locked
% 
% <<jointModeTest_Locked_Overview.gif>>
%
% This example shows how to use joint modes to modify the kinematics of a
% mechanism. In this example, a link is connected to a pin using locked
% mode, and it is disconnected from the pin using normal mode. This
% permits the link to change its pivot point about the pin during
% simulation.
%
% Using locked mode to engage the pin as done in this example permits
% engaging under a wider range of conditions, even if the pin is not
% aligned with the hole.  It is easier to change modes than using normal
% mode, but it is wise to confirm that the frames are suitably aligned
% before moving to locked mode.
%
% (<matlab:web('Motor_Grader_Design_Overview.html') return to Motor Grader Design with Simscape Overview>)
%
% Copyright 2025 The MathWorks, Inc.

%% Model
%
% In this model, Bushing Joints connect the link to the pin.  Only one
% Bushing joint at a time will have mode "Locked", constraining the
% link to rotate about the pin in the hole where the pin is engaged. Note
% that the pin is connected to world via a cylindrical joint. In this
% example, both the pin and the link pivot together.

open_system('jointModeTest_Locked')

ann_h = find_system('jointModeTest_Locked','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i = 1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off')
end

%% Simulation Results from Simscape Logging
%
% At the start of the simulation, the pin is engaged with hole C on the
% link.  After the link pivots about hole C, the pin is disengaged from
% hole C by setting the mode of Bushing Hole C to 0 for normal mode.
% The Link is then constrained to World via a Prismatic Joint within the
% Actuator subsystem.  The Prismatic Joint in Actuator was disengaged at
% the start of the simulation, and its mode is set to normal so that the
% Link can be moved to engage the pin at hole A.
%
% The actuator slides the link so that the pin is aligned with hole A.  At
% that point, the actuator joint is disengaged and the mode of Bushing
% Hole A joint is set to 1 for locked mode.  This engages the pin with hole
% A and the link then pivots about that hole.

sim('jointModeTest_Locked');
open_system('jointModeTest_Locked/Scope');

%%

%clear all
close all
bdclose all
