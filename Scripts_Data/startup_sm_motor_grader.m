% Load Vehicle Parameters
sm_motor_grader_params
sm_motor_grader_params_vis
HMPST = sm_motor_grader_params_cvt(motGradParams);

% Load Scene Parameters
sm_motor_grader_scenes

% Load Camera Parameters
Camera =  sm_vehicle_camera_frames_grader;

% Load Maneuver Parameters
IDatabase = sm_motor_grader_define_init;
Init = IDatabase.Flat;
sm_car_gen_driver_database
Driver = DDatabase.Grading.Motor_Grader;
sm_motor_grader_manv_ditch_backside

% Open and Configure Model
open_system('sm_motor_grader')
set_param([bdroot '/Motor Grader'],'popup_actuator_model','Position')
set_param([bdroot '/Motor Grader'],'popup_actuator_model_lift','Position')
[activeTestCmds,motGradParams,stopTime] = sm_motor_grader_define_test(motGradParams,'GradingTest');

% Open Overview Documentation
web('Motor_Grader_Design_Overview.html');
