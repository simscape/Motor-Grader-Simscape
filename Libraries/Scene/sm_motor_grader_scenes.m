SceneData.grid.len   = 250;
SceneData.grid.wid   = 40;
SceneData.grid.nsq_x = 25;
SceneData.grid.nsq_y = 4;
SceneData.grid.dep      = 0.02;
SceneData.grid.line_wid = 0.02;
SceneData.grid.line_clr = [1 1 1];
SceneData.grid.line_opc = 1;
SceneData.grid.surf_clr = [1 1 1];
SceneData.grid.surf_opc = 1;

SceneData.bank.qBank = 10; % deg
SceneData.bank.xBank = 2;  % m
SceneData.bank.x_vec = [-0.5 0.5]*SceneData.grid.len;
SceneData.bank.y_vec = [-0.5 0 0.5]*SceneData.grid.wid+SceneData.bank.xBank;
SceneData.bank.z_mat = [0 0 1;0 0 1]*tand(SceneData.bank.qBank)*SceneData.grid.wid/2;
SceneData.bank.clr   = [0.8588 0.7137 0.549];

SceneData.bank.grid.len   = SceneData.grid.len;
SceneData.bank.grid.wid   = SceneData.grid.wid/2;
SceneData.bank.grid.nsq_x = 25;
SceneData.bank.grid.nsq_y = 4/2;
SceneData.bank.grid.dep      = 0.02;
SceneData.bank.grid.line_wid = 0.02;
SceneData.bank.grid.line_clr = [1 1 1];
SceneData.bank.grid.line_opc = 1;
SceneData.bank.grid.surf_clr = SceneData.bank.clr;
SceneData.bank.grid.surf_opc = 1;
SceneData.bank.offset = [0 ...
    SceneData.bank.grid.wid/2+SceneData.bank.xBank ...
    SceneData.bank.grid.wid/2*tand(SceneData.bank.qBank)];

SceneData.park.len   = 20;
SceneData.park.wid   = 20;
SceneData.park.nsq_x = 2;
SceneData.park.nsq_y = 2;
SceneData.park.dep      = 0.02;
SceneData.park.line_wid = 0.02;
SceneData.park.line_clr = [1 1 1];
SceneData.park.line_opc = 1;
SceneData.park.surf_clr = [1 1 1];
SceneData.park.surf_opc = 1;

SceneData.terrain = sm_motor_grader_sceneterrain;
SceneData.terrain.clr = [1 1 1]*0.9;