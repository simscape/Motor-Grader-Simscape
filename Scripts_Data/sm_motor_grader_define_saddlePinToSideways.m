
[activeTestCmds2,motGradParams2,stopTime2] = sm_motor_grader_define_test(motGradParams,'BladeOutSidewaysTest');
[activeTestCmds1,motGradParams1,stopTime1] = sm_motor_grader_define_test(motGradParams,'SaddlePinMoveTest');

elementList = getElementNames(activeTestCmds1);

for e_i = 1:length(elementList)
    endTime1(e_i) = activeTestCmds1{e_i}.Time(end);
    endTime2(e_i) = activeTestCmds2{e_i}.Time(end);
end
maxTime1 = max(setdiff(endTime1,60));
maxTime2 = max(setdiff(endTime2,60));

for e_i = 1:length(elementList)
    activeTestCmds1{e_i}.Time(end) = maxTime1;
    activeTestCmds2{e_i}.Time(end) = maxTime2;
end

stopTime1 = maxTime1;
stopTime2 = maxTime2;

for e_i = 1:length(elementList)
    ds.Time = [activeTestCmds1{e_i}.Time; activeTestCmds2{e_i}.Time+activeTestCmds1{e_i}.Time(end)+10];
    ds.Data = [activeTestCmds1{e_i}.Data; activeTestCmds2{e_i}.Data];
    activeTestCmds1{e_i} = ds;
end

activeTestCmds = activeTestCmds1;
stopTime = stopTime1 + stopTime2+10;

idx_nHole = find(strcmp(activeTestCmds.getElementNames,'nHoleLink'));
activeTestCmds{idx_nHole}.Data  =[0 0 10 10 3 3 3 3]';
idx_pLiftL = find(strcmp(activeTestCmds.getElementNames,'pLiftL'));
activeTestCmds{idx_pLiftL}.Data  =[0.4 0.4 1.05 1.05 0.95 0.95 0.95 0.95 0.05 0.05 1.05 1.05]';
idx_pLiftR = find(strcmp(activeTestCmds.getElementNames,'pLiftR'));
activeTestCmds{idx_pLiftR}.Data  =[0.4 0.4 0.6  0.6   0.025  0.025  0.025  0.025 1.00 1.00 0.00 0.00]';
idx_mLiftL = find(strcmp(activeTestCmds.getElementNames,'mLiftL'));
idx_mLiftR = find(strcmp(activeTestCmds.getElementNames,'mLiftR'));
fcnCmds.Time = [0  2 2.1 23.9 24 stopTime]';
fcnCmds.Data = [0  0   1    1  0        0]';
activeTestCmds{idx_mLiftL} = fcnCmds;
activeTestCmds{idx_mLiftR} = fcnCmds;
motGradParams = motGradParams1;
