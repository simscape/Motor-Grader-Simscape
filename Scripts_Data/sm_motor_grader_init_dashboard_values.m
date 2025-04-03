function sm_motor_grader_init_dashboard_values(sys,motGradParams)

%% Propulsion and Steering Dashboard
% Check for propulsion and steering dashboard blocks
% Propulsion and steering sliders are not in LiftAssembly.slx model
% Set values, but do not try to set sliders.
slider_vs = Simulink.findBlocks(gcs,'Name','Slider Vehicle Speed');
if(~isempty(slider_vs))
    set_param([sys '/Slider Vehicle Speed'],'Limits',[-motGradParams.drivetrain.topSpeed -1 motGradParams.drivetrain.topSpeed])
    set_param([sys '/Slider Lean'],'Limits',[motGradParams.wheelLean.lowerBound -1 motGradParams.wheelLean.upperBound])
    set_param([sys '/Slider Steer'],'Limits',[motGradParams.steer.lowerBound -1 motGradParams.steer.upperBound])
    set_param([sys '/Slider Articulation'],'Limits',[motGradParams.articulation.lowerBound -1 motGradParams.articulation.upperBound])
    set_param([sys '/Slider Lift L'],'Limits',[0 -1 motGradParams.bladeLift.stroke])
    set_param([sys '/Slider Lift R'],'Limits',[0 -1 motGradParams.bladeLift.stroke])
end

set_param([sys '/Vehicle Speed'],'Value','0');
set_param([sys '/Lean'],'Value',num2str(motGradParams.wheelLean.initPos));
set_param([sys '/Steer'],'Value',num2str(motGradParams.steer.initPos));
set_param([sys '/Articulation'],'Value',num2str(motGradParams.articulation.initPos));
set_param([sys '/Lift L'],'Value',num2str(motGradParams.bladeLift.leftInitPos));
set_param([sys '/Lift R'],'Value',num2str(motGradParams.bladeLift.rightInitPos));

%% Lift Assembly Dashboard
set_param([sys '/Circle Shift'],'Value',num2str(motGradParams.circleShift.initPos));
set_param([sys '/Circle Pos'],'Value',num2str(motGradParams.circleRot.initPos));
set_param([sys '/Blade Tilt'],'Value',num2str(motGradParams.bladeTilt.initPos));
set_param([sys '/Blade Shift'],'Value',num2str(motGradParams.bladeSideShift.initPos));

set_param([sys '/Slider Circle Shift'],'Limits',[0 -1 motGradParams.circleShift.stroke])
set_param([sys '/Slider Circle Pos'],'Limits',[motGradParams.circleRot.minPos -1 motGradParams.circleRot.maxPos])
set_param([sys '/Slider Blade Shift'],'Limits',[0 -1 motGradParams.bladeSideShift.stroke])
set_param([sys '/Slider Blade Tilt'],'Limits',[0 -1 motGradParams.bladeTilt.stroke])


