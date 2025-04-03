

%% Mass Parameters
% CAT 160 ~20,000 kg

% Major bodies
motGradParams.rearFrame.mass = 10000; % [kg]
motGradParams.rightRearDriveUnit.mass = 500; % [kg]
motGradParams.leftRearDriveUnit.mass = 500; % [kg]
motGradParams.mainFrame.mass = 6000; % [kg]
motGradParams.cab.mass = 200; % [kg]
motGradParams.drawbar.mass = 700; % [kg]
motGradParams.saddle.mass = 50; % [kg]
motGradParams.linkBar.mass = 20; % [kg]
motGradParams.liftCylLink.mass = 20; % [kg]
motGradParams.circleFrame.mass = 400; % [kg]
motGradParams.bladeTiltFrame.mass = 200; % [kg]
motGradParams.blade.mass = 300; % [kg]
motGradParams.circlePinion.mass = 20; % [kg]
motGradParams.saddlePin.mass = 0.5; % [kg]
motGradParams.seat.mass = 20; % [kg]

% Front axle
motGradParams.frontAxle.mass = 200; % [kg]
motGradParams.wheelLeanKnuckle.mass = 80; % [kg]
motGradParams.steerKnuckle.mass = 80; % [kg]

% Wheels
motGradParams.hub.mass = 30; % [kg]
motGradParams.wheel.mass = 150; % [kg]

% Actuators
motGradParams.articulation.cyl.mass = 10; % [kg]
motGradParams.articulation.rod.mass = 10; % [kg]
motGradParams.wheelLean.cyl.mass = 10; % [kg]
motGradParams.wheelLean.rod.mass = 10; % [kg]
motGradParams.steer.cyl.mass = 10; % [kg]
motGradParams.steer.rod.mass = 10; % [kg]
motGradParams.circleShift.cyl.mass = 10; % [kg]
motGradParams.circleShift.rod.mass = 10; % [kg]
motGradParams.bladeTilt.cyl.mass = 10; % [kg]
motGradParams.bladeTilt.rod.mass = 10; % [kg]
motGradParams.bladeLift.cyl.mass = 30; % [kg]
motGradParams.bladeLift.rod.mass = 30; % [kg]
motGradParams.bladeSideShift.cyl.mass = 30; % [kg]
motGradParams.bladeSideShift.rod.mass = 30; % [kg]

%% Saddle pin location
% Initial position of lift cylinders and circle shift cylinder are specific
% to the saddle pin location picked. 3 is setup to work with the
% 'BladeOutSidewaysTest'. The other tests are designed for 'Center' to be
% selected. Selecting a different saddle pin location may or may not require
% additional changes to the initialization.
% -3, -2, -1 = LeftThree, LeftTwo, LeftOne
% 0 = Center
% 1, 2, 3 = RightOne, RightTwo, RightThree
% 10 disengaged
motGradParams.saddlePin.initEngagedHole = 0;

% Saddle pin target location
% Location to move the saddle pin to. Only used for the
% 'SaddlePinMoveTest' case with 0 as the initial hole
% -3, -2, -1 = LeftThree, LeftTwo, LeftOne
% 1, 2, 3 = RightOne, RightTwo, RightThree
motGradParams.saddlePin.targetHole = 3;

% Saddle pin video links
% https://www.youtube.com/watch?v=jddPVc5Z6w8
% https://www.youtube.com/watch?v=sVe67XD-ZzY


%% Function Parameters
% Articulation
motGradParams.articulation.centerPos = 0.1465; % [m]
motGradParams.articulation.stroke = 0.14; % [m] Achieves +/-20* articulation angle
motGradParams.articulation.lowerBound = motGradParams.articulation.centerPos - motGradParams.articulation.stroke/2; % [m]
motGradParams.articulation.upperBound = motGradParams.articulation.centerPos + motGradParams.articulation.stroke/2; % [m]
motGradParams.articulation.maxSpeed = motGradParams.articulation.stroke/2; % [m/s]

motGradParams.articulation.propGain   = 100000000;
motGradParams.articulation.integral   = 500000;
motGradParams.articulation.derivative = 5000000;

% Steering
motGradParams.steer.centerPos = 0.207487; % [m] 0.147 to 0.268
motGradParams.steer.stroke = 0.12; % [m] Achieves +/-35* steering angle
motGradParams.steer.lowerBound = motGradParams.steer.centerPos - motGradParams.steer.stroke/2; % [m]
motGradParams.steer.upperBound = motGradParams.steer.centerPos + motGradParams.steer.stroke/2; % [m]
motGradParams.steer.maxSpeed = motGradParams.steer.stroke/2; % [m/s]

motGradParams.steer.damping = 1000000;

motGradParams.steer.propGain   = 20000000;
motGradParams.steer.integral   = 10000;
motGradParams.steer.derivative = 50;

% Wheel lean
motGradParams.wheelLean.centerPos = 0.166; % [m]
motGradParams.wheelLean.stroke = 0.132; % [m] Achieves +/-20* lean angle
motGradParams.wheelLean.lowerBound = motGradParams.wheelLean.centerPos - motGradParams.wheelLean.stroke/2; % [m]
motGradParams.wheelLean.upperBound = motGradParams.wheelLean.centerPos + motGradParams.wheelLean.stroke/2; % [m]
motGradParams.wheelLean.maxSpeed = motGradParams.wheelLean.stroke/2; % [m/s]

motGradParams.wheelLean.damping = 1000000;

motGradParams.wheelLean.propGain   = 20000000*0.5;
motGradParams.wheelLean.integral   = 1000000;
motGradParams.wheelLean.derivative = 50;

% Blade lift
motGradParams.bladeLift.stroke = 1.2; % [m]
motGradParams.bladeLift.propGain = 5e5; 
motGradParams.bladeLift.integral = 3e6;
motGradParams.bladeLift.derivative = 5e4;

% Blade side shift
motGradParams.bladeSideShift.stroke = 1.3; % [m]
motGradParams.bladeSideShift.damping = 300;

motGradParams.bladeSideShift.propGain = 1000*10*10*0.1*0.5*2*2*2*2; 
motGradParams.bladeSideShift.integral = 500*10;
motGradParams.bladeSideShift.derivative = 5000*0.1*5*2;

% Blade tilt
motGradParams.bladeTilt.stroke     = 0.2; % [m]
motGradParams.bladeTilt.propGain   = 5e5;
motGradParams.bladeTilt.integral   = 3e6;
motGradParams.bladeTilt.derivative = 0;

% Circle shift
motGradParams.circleShift.stroke   = 0.85; % [m]
                                       
motGradParams.circleShift.propGain   = 1000000;
motGradParams.circleShift.integral   = 500*2;
motGradParams.circleShift.derivative = 50;

% Circle rotation
motGradParams.circleRot.maxPos = 90; % [deg]
motGradParams.circleRot.minPos = -90; % [deg]
motGradParams.circleRot.pinionRad = .060; % [m]
motGradParams.circleRot.circleRad = 0.5; % [m]
motGradParams.circleRot.gearRatio = motGradParams.circleRot.circleRad/motGradParams.circleRot.pinionRad;
motGradParams.circleRot.maxSpeed = 45; % [deg/s]
motGradParams.circleRot.damping  = 1; % [deg/s]

motGradParams.circleRot.propGain = 40;
motGradParams.circleRot.integral = 10;
motGradParams.circleRot.derivative = 20;

%% Joint Parameters
motGradParams.sphDampingCoeff = 1e2; % [N*m/(deg/s)]
motGradParams.revDampingCoeff = 1e2; % [N*m/(deg/s)]

motGradParams.posFiltCoeff    = 0.01;

%% Ground Contact
motGradParams.groundContact.tireRad = 1.675/2; % [m]
motGradParams.groundContact.stiffness = 1e6; % [N/m] 3e5
motGradParams.groundContact.damping = 1.5e5; % [N/(m/s)]
motGradParams.groundContact.transRegWidth = 0.01; % [m]
motGradParams.groundContact.muStatic = 0.8;
motGradParams.groundContact.muDynamic = 0.6;
motGradParams.groundContact.velThreshold = 0.1; % [m/s]

%% Drivetrain
motGradParams.drivetrain.topSpeed = 11; % [m/s]

motGradParams.drivetrain.propGain = 10000;
motGradParams.drivetrain.integral = 50;

%% Force on Blade
motGradParams.force.radScale = 0.001/10;
motGradParams.force.lenScale = 0.001*4/10;
motGradParams.force.frcScale = 1000*100;
motGradParams.force.tfilt    = 0.1;
motGradParams.force.cylLenMax = 1.5;
motGradParams.force.cylRadMax = 0.4;

%% Tire - Magic Formula
motGradParams.tire.filename = 'KT_MF_Tool_550_80_R30.tir';
motGradParams.tire.param    = simscape.multibody.tirread(which(motGradParams.tire.filename));

%% Tire - Point Cloud, Parameterized Cylinder
% Generate cylindrical point cloud for front tire
% Save within data structure
nptsCyl = 800;
motGradParams.tire.ptcld_cyl.pts   = Point_Cloud_Data_Cylinder(...
    motGradParams.tire.param.DIMENSION.UNLOADED_RADIUS,...
    motGradParams.tire.param.DIMENSION.WIDTH,nptsCyl,false);

motGradParams.tire.ptcld_cyl.stiffness     = 1e6*0.5*0.01*5*0.5; % [N/m] 3e5
motGradParams.tire.ptcld_cyl.damping       = 1.5e5*1e-3*10*0.01*10; % [N/(m/s)]
motGradParams.tire.ptcld_cyl.transRegWidth = 0.01; % [m]
motGradParams.tire.ptcld_cyl.muStatic      = 0.9;
motGradParams.tire.ptcld_cyl.muDynamic     = 0.9;
motGradParams.tire.ptcld_cyl.velThreshold  = 1; % [m/s]

% Use Point Cloud from cylinder as default
motGradParams.tire.ptcld = motGradParams.tire.ptcld_cyl;

%% Tire - Point Cloud from STL
[ptcld_loc,ptcld_hull] = sm_motor_grader_ptcld_tiretread('WheelAndTire.STL',[2 3],836,800,3.75,3.75,[3 -2 1]);

% Points from convex hull outside of a specified radius with no near neighbors
motGradParams.tire.ptcld_hull.pts           = unique(ptcld_hull/1000,'rows');
stiffRatioHull = size(motGradParams.tire.ptcld_hull.pts,1)/size(motGradParams.tire.ptcld_cyl.pts,1);
motGradParams.tire.ptcld_hull.stiffness     = motGradParams.tire.ptcld_cyl.stiffness*stiffRatioHull; % [N/m]
motGradParams.tire.ptcld_hull.damping       = motGradParams.tire.ptcld_cyl.damping*stiffRatioHull; % [N/(m/s)]
motGradParams.tire.ptcld_hull.transRegWidth = 0.01; % [m]
motGradParams.tire.ptcld_hull.muStatic      = 0.9;
motGradParams.tire.ptcld_hull.muDynamic     = 0.9;
motGradParams.tire.ptcld_hull.velThreshold  = 1; % [m/s]

% Execute this command to use point cloud from convex hull of STL
%motGradParams.tire.ptcld = motGradParams.tire.ptcld_hull;

% All points outside of a specified radius with no near neighbors
motGradParams.tire.ptcld_loc.pts           = unique(ptcld_loc/1000,'rows');
stiffRatioLoc = size(motGradParams.tire.ptcld_loc.pts,1)/size(motGradParams.tire.ptcld_cyl.pts,1);
motGradParams.tire.ptcld_loc.stiffness     = motGradParams.tire.ptcld_cyl.stiffness*stiffRatioLoc; % [N/m]
motGradParams.tire.ptcld_loc.damping       = motGradParams.tire.ptcld_cyl.damping*stiffRatioLoc; % [N/(m/s)]
motGradParams.tire.ptcld_loc.transRegWidth = 0.01; % [m]
motGradParams.tire.ptcld_loc.muStatic      = 0.9;
motGradParams.tire.ptcld_loc.muDynamic     = 0.9;
motGradParams.tire.ptcld_loc.velThreshold  = 1; % [m/s]

% Execute this command to use point cloud based on radius
%motGradParams.tire.ptcld = motGradParams.tire.ptcld_loc;

%% Suspension
% Compliant element needed for tire models that have little to no vertical damping
% This applies to some Magic Formula Tire implementations
motGradParams.suspFA.xeq = 0.015*2/10*0.2*5*10;
motGradParams.suspFA.k   = 2e3*1000*0.5;
motGradParams.suspFA.b   = 1e2*1000*0.5;

motGradParams.suspDrive.xeq = -0.04*2*4*0+0.07;
motGradParams.suspDrive.k   = 1e6*4*0.5;
motGradParams.suspDrive.b   = 1e4*10*10*0.1;
