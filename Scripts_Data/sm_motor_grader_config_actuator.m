function sm_motor_grader_config_actuator(blk,actType)
%{
tiltActPth   = [mdl '/Motor Grader/Vehicle/Frame/Blade/Tilt Actuator/Actuator'];
shiftActPth  = [mdl '/Motor Grader/Vehicle/Frame/Blade/Shift Actuator/Actuator'];
circleActPth = [mdl '/Motor Grader/Vehicle/Frame/LiftAssembly/Circle Shift Actuator/Actuator'];
articActPth  = [mdl '/Motor Grader/Vehicle/Articulation Cyl/Actuator'];
liftLActPth  = [mdl '/Motor Grader/Vehicle/Frame/LiftAssembly/Saddle L/Actuator'];
liftRActPth  = [mdl '/Motor Grader/Vehicle/Frame/LiftAssembly/Saddle R/Actuator'];
steerLActPth = [mdl '/Motor Grader/Vehicle/Frame Front/Steer Cylinder L/Actuator'];
steerRActPth = [mdl '/Motor Grader/Vehicle/Frame Front/Steer Cylinder R/Actuator'];
leanLActPth  = [mdl '/Motor Grader/Vehicle/Frame Front/Lean Cylinder L/Actuator'];
leanRActPth  = [mdl '/Motor Grader/Vehicle/Frame Front/Lean Cylinder R/Actuator'];
pinionActPth = [mdl '/Motor Grader/Vehicle/Frame/Drawbar/Actuator'];


actSet     = {...
    'Tilt',tiltActPth;...
    'Shift',shiftActPth;...
    'Circle',circleActPth;...
    'Articulation',articActPth;...
    'LiftL',liftLActPth;...
    'LiftR',liftRActPth;...
    'SteerL',steerLActPth;...
    'SteerR',steerRActPth;...
    'LeanL',leanLActPth;...
    'LeanR',leanRActPth;...
    'Pinion',pinionActPth};

actSub = [mdl '/Motor Grader/Actuation'];
%}

%if(~startsWith(actName,'Lift'))
    actInd = strcmp(actSet(:,1),actName);
    set_param(actSet{actInd,2},'LabelModeActiveChoice',actType);
%end

if(strcmp(actType,'Position'))
    set_param([actSub '/Actuator ' actName],'Commented','on');
else
    set_param([actSub '/Actuator ' actName],'Commented','off');
end

end






