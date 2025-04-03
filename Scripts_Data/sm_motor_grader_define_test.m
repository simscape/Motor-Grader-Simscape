function [activeTestCmds,motGradParams, stopTime] = sm_motor_grader_define_test(motGradParams,testType)
%% Test Scenario Definitions
% This function contains all model test scenario definitions.
% A separate script calls this function to string the saddle pin move test
% and the blade out sideways test together.
%
% Idle                  No commands 
% CircleRotTest         Rotates circle 
% ArticulationTest      Moves articulation cylinder
% BladeMotionTest       Blade tilt and side shift
% GradingTest           Full test of all functions working together
% DrawbarMotionTest     Blade lift cylinders and circle shift cylinders  
% BladeLiftContactTest  Blade contact with ground
% BladeOutSidewaysTest  Moves the entire drawbar and moldboard assembly to the left
%                       Parameterized for 'RightThree (3)' as the saddle pin
% SaddlePinMoveTest     Moves the saddle pin from the center hole to the hole
%                       defined in motGradParams.saddlePin.targetHole

%% Test Definitions
load('MotGradTestCommands.mat','TestCmds');
activeTestCmds = TestCmds;

%% Standard Settings
% Nominal initial positions
motGradParams.saddlePin.initEngagedHole = 0;
motGradParams = setNominalInit(motGradParams);

% Note: Blade contact off for most tests, needs to be set per model
% Note: Drawbar lift must be force for specific tests

% Set all inputs to nominal values
stopTime = 1; % [s]
activeTestCmds = setNominalVals(activeTestCmds,stopTime,motGradParams);

switch testType
    case 'Idle'
        % No changes to nominal

    case 'CircleRotTest'
        % Circle rotation position
        motGradParams.circleRot.initPos = -45; % [deg]
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(45,2,3,10,motGradParams.circleRot.initPos,motGradParams.circleRot.initPos);
        fcnCmd.Name = 'qCircle';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]
    case 'ArticulationTest'
        % Articulation piston position
        motGradParams.articulation.initPos = motGradParams.articulation.lowerBound; % [m]
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.articulation.upperBound*0.95,2,3,10,motGradParams.articulation.lowerBound*0.99,motGradParams.articulation.lowerBound*0.99);
        fcnCmd.Name = 'pArtic';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]
    case 'BladeMotionTest'
        % Blade tilt piston position
        motGradParams.bladeTilt.initPos = 0; % [m]
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.bladeTilt.stroke,2,3,10,motGradParams.bladeTilt.initPos,motGradParams.bladeTilt.initPos); 
        fcnCmd.Name = 'pTilt';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Blade side shift piston position
        motGradParams.bladeSideShift.initPos = 0; % [m]
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.bladeSideShift.stroke,6,3,10,motGradParams.bladeSideShift.initPos,motGradParams.bladeSideShift.initPos); 
        fcnCmd.Name = 'pShift';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

    case 'GradingTest'
        % Grader velocity
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(5,2,3,40,0,0); 
        fcnCmd.Name = 'vVeh';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Steer position
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        %fcnCmd = createTrapCmd(0.23,8,3,30,motGradParams.steer.initPos,motGradParams.steer.initPos); 
        fcnCmd = createTrapCmd(0.2485,9.5,3,29.1,motGradParams.steer.initPos,motGradParams.steer.initPos); 
        fcnCmd.Name = 'pSteer';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Articulation position
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.articulation.lowerBound,8,3,30,motGradParams.articulation.initPos,motGradParams.articulation.initPos); 
        fcnCmd.Name = 'pArtic';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Lean position
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        %fcnCmd = createTrapCmd(motGradParams.wheelLean.lowerBound,11,2,26,motGradParams.wheelLean.initPos,motGradParams.wheelLean.initPos); 
        fcnCmd = createTrapCmd(motGradParams.wheelLean.upperBound,11,2,26,motGradParams.wheelLean.initPos,motGradParams.wheelLean.initPos); 
        fcnCmd.Name = 'pLean';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Rotate circle into position
        motGradParams.circleRot.initPos = -20; 
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(20,3,1,35,motGradParams.circleRot.initPos,motGradParams.circleRot.initPos);
        fcnCmd.Name = 'qCircle';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        
        % Shift blade left
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(1,14,1,22,motGradParams.bladeSideShift.initPos,motGradParams.bladeSideShift.initPos); 
        fcnCmd.Name = 'pShift';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Left blade lift
        motGradParams.bladeLift.leftInitPos = 0.2;
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        %fcnCmd = createTrapCmd(0.3,15,1,13,motGradParams.bladeLift.leftInitPos,motGradParams.bladeLift.leftInitPos); 
        fcnCmd = createTrapCmd(0.3,15,1,13,motGradParams.bladeLift.leftInitPos,0.1); 
        fcnCmd.Name = 'pLiftL';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Right blade lift
        motGradParams.bladeLift.rightInitPos = 0.2;
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        %fcnCmd = createTrapCmd(0.3,15,1,13,motGradParams.bladeLift.rightInitPos,motGradParams.bladeLift.rightInitPos); 
        fcnCmd = createTrapCmd(0.3,15,1,13,motGradParams.bladeLift.rightInitPos,0.1); 
        fcnCmd.Name = 'pLiftR';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Tilt blade down
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(0.2,16,1,22,motGradParams.bladeTilt.initPos,motGradParams.bladeTilt.initPos); 
        fcnCmd.Name = 'pTilt';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

    case 'DrawbarMotionTest'
        % Left blade lift piston position
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.bladeLift.stroke/2,2,3,13,motGradParams.bladeLift.leftInitPos,motGradParams.bladeLift.leftInitPos); 
        fcnCmd.Name = 'pLiftL';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Right blade lift piston position
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.bladeLift.stroke/2,3,3,12,motGradParams.bladeLift.rightInitPos,motGradParams.bladeLift.rightInitPos); 
        fcnCmd.Name = 'pLiftR';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Circle shift piston position
        %motGradParams.circleShift.initPos = 0; % [m]
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.circleShift.stroke/3,7,3,13,motGradParams.circleShift.initPos,motGradParams.circleShift.initPos); 
        fcnCmd.Name = 'pCircleShift';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

    case 'BladeLiftContactTest'
        % Note: Turn blade contact on for this test, settings in model
        % Note: Drawbar lift cylinders must use shaft actuation (force)
        sm_motor_grader_config_actuator('sm_motor_grader_mech','LiftL','Shaft')
        sm_motor_grader_config_actuator('sm_motor_grader_mech','LiftR','Shaft')

        % Left blade lift piston position
        motGradParams.bladeLift.leftInitPos = 0.2; % [m]
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.bladeLift.stroke,2,3,8,motGradParams.bladeLift.leftInitPos,motGradParams.bladeLift.leftInitPos); 
        fcnCmd.Name = 'pLiftL';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Right blade lift piston position
        motGradParams.bladeLift.rightInitPos = 0.2; % [m]
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.bladeLift.stroke,2,3,8,motGradParams.bladeLift.rightInitPos,motGradParams.bladeLift.rightInitPos); 
        fcnCmd.Name = 'pLiftR';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

    case 'BladeOutSidewaysTest'
        % Note: Pin must start in link bar hole 'RightThree (3)' 
        motGradParams.saddlePin.initEngagedHole = 3;
        motGradParams = setNominalInit(motGradParams);

        motGradParams.circleRot.initPos = -45; % [deg]

        % Maintain blade side shift
        motGradParams.bladeSideShift.initPos = motGradParams.bladeSideShift.stroke; % [m]
        fcnCmd = createConstCmd(motGradParams.bladeSideShift.initPos,20);
        fcnCmd.Name = 'pShift';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Circle shift piston
        paramsStruct.circleShift.initPos = 0.1; % [m]
        fcnCmd = createTrapCmd(0.0,2,3,15,motGradParams.circleShift.initPos,motGradParams.circleShift.initPos);
        fcnCmd.Name = 'pCircleShift';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Retract left lift piston
        fcnCmd = createTrapCmd(0.05,2,3,15,motGradParams.bladeLift.leftInitPos,motGradParams.bladeLift.leftInitPos);
        fcnCmd.Name = 'pLiftL';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Extend right lift piston
        fcnCmd = createTrapCmd(1,2,3,15,motGradParams.bladeLift.rightInitPos,motGradParams.bladeLift.rightInitPos);
        fcnCmd.Name = 'pLiftR';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Rotate circle
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(60,5,3,7,motGradParams.circleRot.initPos,motGradParams.circleRot.initPos);
        fcnCmd.Name = 'qCircle';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

    case 'SaddlePinMoveTest'
        % Note: Drawbar lift must be force for this test, settings in model
        % Note: Turn blade contact on for this test, settings in model
        % Note: Pin must start in link bar hole Center 
        motGradParams.saddlePin.initEngagedHole = 0;
        motGradParams = setNominalInit(motGradParams);

        % Left blade lift piston position
        motGradParams.bladeLift.leftInitPos = 0.4; % [m]
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.bladeLift.stroke,2,3,20,motGradParams.bladeLift.leftInitPos,motGradParams.bladeLift.leftInitPos); 
        fcnCmd.Name = 'pLiftL';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Right blade lift piston position
        motGradParams.bladeLift.rightInitPos = 0.4; % [m]
        % (value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
        fcnCmd = createTrapCmd(motGradParams.bladeLift.stroke,2,3,20,motGradParams.bladeLift.rightInitPos,motGradParams.bladeLift.rightInitPos); 
        fcnCmd.Name = 'pLiftR';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Saddle pin position
        fcnCmd = createTrapCmd(-0.1,5+1.1,1,7+1.1,0,0);
        fcnCmd.Name = 'pPin';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Engaged pin hole
        %fcnCmd = createTrapCmd(10,6,0.01,7,motGradParams.saddlePin.initEngagedHole,motGradParams.saddlePin.targetHole);
        fcnCmd = createTrapCmd(10,4.9+1.1,0.01,7.2+3.1,motGradParams.saddlePin.initEngagedHole,motGradParams.saddlePin.targetHole);
        fcnCmd.Name = 'nHoleLink';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        % Circle shift piston
        switch motGradParams.saddlePin.targetHole
            case 1
                motGradParams.circleShift.initPos = 0.1;
                motGradParams.circleShift.targetPos = 0.22575;
            case 2
                motGradParams.circleShift.initPos = 0.1;
                motGradParams.circleShift.targetPos = 0.3595;
            case 3
                motGradParams.circleShift.initPos = 0.1;
                motGradParams.circleShift.targetPos = 0.6201;
            case -1
                motGradParams.circleShift.initPos = 0.4;
                motGradParams.circleShift.targetPos = 0.28175;
            case -2
                motGradParams.circleShift.initPos = 0.4;
                motGradParams.circleShift.targetPos = 0.17386;
            case -3
                motGradParams.circleShift.initPos = 0.4;
                motGradParams.circleShift.targetPos = 0.032492;
        end
        fcnCmd = createTrapCmd(motGradParams.circleShift.targetPos,8,3,7,motGradParams.circleShift.initPos,motGradParams.circleShift.targetPos);
        fcnCmd.Name = 'pCircleShift';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
        stopTime = fcnCmd.Time(end); % [s]

        fcnCmd = [];
        fcnCmd.Name = 'mLiftL';
        idxTmpL = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        fcnCmd.Time =[0  2 2.1 stopTime]';
        fcnCmd.Data =[0  0   1  1]';
        activeTestCmds{idxTmpL} = fcnCmd;
        fcnCmd.Name = 'mLiftR';
        idxTmpR = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmpR} = activeTestCmds{idxTmpL};
end

% Set nominal initial conditions
function paramsStruct = setNominalInit(paramsStruct)
    paramsStruct.articulation.initPos = paramsStruct.articulation.centerPos; % [m]
    paramsStruct.steer.initPos = paramsStruct.steer.centerPos; % [m]
    paramsStruct.wheelLean.initPos = paramsStruct.wheelLean.centerPos; % [m]

    if paramsStruct.saddlePin.initEngagedHole == 0
            paramsStruct.circleShift.initPos = 0.1; % [m]
            paramsStruct.bladeLift.leftInitPos = 0.25; % [m]
            paramsStruct.bladeLift.rightInitPos = 0.25; % [m]
    elseif paramsStruct.saddlePin.initEngagedHole == -1
            paramsStruct.circleShift.initPos = 0.1; % [m]
            paramsStruct.bladeLift.leftInitPos = 0.2; % [m]
            paramsStruct.bladeLift.rightInitPos = 0.35; % [m]
    elseif paramsStruct.saddlePin.initEngagedHole == -2
            paramsStruct.circleShift.initPos = 0.1; % [m]
            paramsStruct.bladeLift.leftInitPos = 0.1; % [m]
            paramsStruct.bladeLift.rightInitPos = 0.5; % [m]
    elseif paramsStruct.saddlePin.initEngagedHole == -3
            paramsStruct.circleShift.initPos = 0.1; % [m]
            paramsStruct.bladeLift.leftInitPos = 0.0; % [m]
            paramsStruct.bladeLift.rightInitPos = 1.05; % [m]
    elseif paramsStruct.saddlePin.initEngagedHole == 1
            paramsStruct.circleShift.initPos = 0.2; % [m]
            paramsStruct.bladeLift.leftInitPos = 0.35; % [m]
            paramsStruct.bladeLift.rightInitPos = 0.2; % [m]
    elseif paramsStruct.saddlePin.initEngagedHole == 2
            paramsStruct.circleShift.initPos = 0.15; % [m]
            paramsStruct.bladeLift.leftInitPos = 0.55; % [m]
            paramsStruct.bladeLift.rightInitPos = 0.1; % [m]
    elseif paramsStruct.saddlePin.initEngagedHole == 3
            paramsStruct.circleShift.initPos = 0.15; % [m]
            paramsStruct.bladeLift.leftInitPos = 1.05; % [m] 
            paramsStruct.bladeLift.rightInitPos = 0.0; % [m]
    end
    paramsStruct.bladeSideShift.initPos = 0.5; % [m]
    paramsStruct.bladeTilt.initPos = 0.0; % [m]
    paramsStruct.circleRot.initPos = 0; % [deg]
    paramsStruct.saddlePin.initPos = 0; % [m]
end

% Set nominal values
function activeTestCmds = setNominalVals(activeTestCmds,stopTime,motGradParams)
        % Link bar engaged hole
        fcnCmd = createConstCmd(motGradParams.saddlePin.initEngagedHole,stopTime);
        fcnCmd.Name = 'nHoleLink';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Propulsion velocity 
        fcnCmd = createConstCmd(0,stopTime);
        fcnCmd.Name = 'vVeh';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Wheel lean
        fcnCmd = createConstCmd(motGradParams.wheelLean.initPos,stopTime);
        fcnCmd.Name = 'pLean';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Steer
        fcnCmd = createConstCmd(motGradParams.steer.initPos,stopTime);
        fcnCmd.Name = 'pSteer';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Articulation
        fcnCmd = createConstCmd(motGradParams.articulation.initPos,stopTime);
        fcnCmd.Name = 'pArtic';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Left blade lift
        fcnCmd = createConstCmd(motGradParams.bladeLift.leftInitPos,stopTime);
        fcnCmd.Name = 'pLiftL';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Right blade lift
        fcnCmd = createConstCmd(motGradParams.bladeLift.rightInitPos,stopTime);
        fcnCmd.Name = 'pLiftR';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Circle shift
        fcnCmd = createConstCmd(motGradParams.circleShift.initPos,stopTime);
        fcnCmd.Name = 'pCircleShift';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Blade side shift
        fcnCmd = createConstCmd(motGradParams.bladeSideShift.initPos,stopTime);
        fcnCmd.Name = 'pShift';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Blade tilt
        fcnCmd = createConstCmd(motGradParams.bladeTilt.initPos,stopTime);
        fcnCmd.Name = 'pTilt';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Circle rotation
        fcnCmd = createConstCmd(motGradParams.circleRot.initPos,stopTime);
        fcnCmd.Name = 'qCircle';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Lift Cylinder Mode L
        fcnCmd = createConstCmd(0,stopTime);
        fcnCmd.Name = 'mLiftL';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;

        % Lift Cylinder Mode L
        fcnCmd = createConstCmd(0,stopTime);
        fcnCmd.Name = 'mLiftL';
        idxTmp = find(strcmp(activeTestCmds.getElementNames,fcnCmd.Name));
        activeTestCmds{idxTmp} = fcnCmd;
end

% Create trapezoidal command data
function cmd = createTrapCmd(value,startOffset,rampTime,totalCmdTime,initVal,finalVal)
    cmd = timeseries([ ...
        initVal;
        initVal;
        value;
        value;
        finalVal;
        finalVal], [ ...
        0;
        startOffset;
        startOffset + rampTime;
        startOffset + totalCmdTime - rampTime;
        startOffset + totalCmdTime;
        startOffset + startOffset + totalCmdTime]);
end
% Create constant command data

function cmd = createConstCmd(value,totalCmdTime)
    cmd = timeseries([value; value], [0 totalCmdTime]);
end

end