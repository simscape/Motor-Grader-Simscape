function sm_motor_grader_config_initLinkBarHole(sys,motGradParams)

switch motGradParams.saddlePin.initEngagedHole
    case -3, initHoleName = 'Left 3';
    case -2, initHoleName = 'Left 2';
    case -1, initHoleName = 'Left 1';
    case  0, initHoleName = 'Center';
    case  1, initHoleName = 'Right 1';
    case  2, initHoleName = 'Right 2';
    case  3, initHoleName = 'Right 3';
end

set_param(sys,'popup_initial_hole',initHoleName)
        