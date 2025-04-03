%% Define ditch backside grading maneuver

% Trajectory for driver model
Maneuver.Trajectory.x.Value = [linspace(0,0.9,10) linspace(1,20,20) linspace(21,60,  40) linspace(61,140,80)  linspace(141,160,20) linspace(161,200,40)];
Maneuver.Trajectory.y.Value = [linspace(0,0  ,10) linspace(0, 0,20) linspace( 0,1.5, 40) linspace(1.5,1.5,80) linspace(1.5,  0,20) linspace(0,    0,40)]*2;
Maneuver.Trajectory.z.Value = Maneuver.Trajectory.y.Value*0;
Maneuver.Trajectory.aYaw.Value = atan2(Maneuver.Trajectory.y.Value,Maneuver.Trajectory.x.Value);
Maneuver.Trajectory.xTrajectory.Value = sqrt(Maneuver.Trajectory.x.Value.^2+Maneuver.Trajectory.y.Value.^2);
Maneuver.Trajectory.vx.Value = Maneuver.Trajectory.y.Value*0+5;

% Parameters for driver model
Maneuver.xPreview.x.Value = [0 5 10];
Maneuver.xPreview.v.Value = [0 5 10];
Maneuver.xMaxLat.Value = 3;
Maneuver.vMinTarget.Value = 5;
Maneuver.vGain.Value = 1;

% Heights for visualization (based on terrain)
Maneuver.Trajectory.zbank.Value = interp2(SceneData.bank.x_vec+125,SceneData.bank.y_vec,SceneData.bank.z_mat',Maneuver.Trajectory.x.Value,Maneuver.Trajectory.y.Value)+1e-2;
Maneuver.Trajectory.zgrid.Value = Maneuver.Trajectory.y.Value*0+1e-2;
Maneuver.Trajectory.zterrain.Value = interp2(SceneData.terrain.x,SceneData.terrain.y,SceneData.terrain.h',Maneuver.Trajectory.x.Value,Maneuver.Trajectory.y.Value)+1e-2;
