%% Extracting Point Cloud from STL Geometry: Tire
% 
% This example shows MATLAB commands to obtain coordinates for the point
% cloud that is used to detect collision between the wheels and the ground
% terrain. The STL file for the tire is read into MATLAB, and then a
% few commands are used to extract just the points that are useful for the
% contact and friction force calculation.
%
% The code used in the example is <matlab:edit('sm_motor_grader_ptcld_tiretread.m') sm_motor_grader_ptcld_tiretread.m>. 
% 
% (<matlab:web('Motor_Grader_Design_Overview.html') return to Motor Grader Overview>)
%
% Copyright 2025 The MathWorks, Inc


%% Read in the STL file, plot mesh
%
% The <matlab:doc('stlread') stlread> and <matlab:doc('trimesh') trimesh> commands are very useful for working with STL
% files.

stlFile = 'WheelAndTire.STL';
wheel_stl_points = stlread(stlFile);

figure(1)
trimesh(wheel_stl_points,'EdgeColor',[0.6 0.6 0.6])
axis equal
box on
title('STL Mesh')
xlabel('x')
ylabel('y')
zlabel('z')
view(-45,30)

%% Find offset
xOffset = (max(wheel_stl_points.Points(:,1))+min(wheel_stl_points.Points(:,1)))/2;
yOffset = (max(wheel_stl_points.Points(:,2))+min(wheel_stl_points.Points(:,2)))/2;
zOffset = (max(wheel_stl_points.Points(:,3))+min(wheel_stl_points.Points(:,3)))/2;

% Create new triangulation based on centered points
% Must use original points, not unique points
wheel_stl_points_new  = wheel_stl_points.Points-[xOffset yOffset zOffset];
wheel_stl_new         = triangulation(wheel_stl_points.ConnectivityList,wheel_stl_points_new(:,1),wheel_stl_points_new(:,2),wheel_stl_points_new(:,3));

%% Filter Points Based on Location
%
% As the data is all in x-y-z coordinates, we could look for points on the
% edge of the wheel on the tips of the fins.  With STL files, you sometimes
% need to eliminate duplicate points using the MATLAB command
% <matlab:doc('unique') unique>.  The code below finds points on the wheel 
% edge that are outside a specified radius.

wheel_stl_points_unique = unique(wheel_stl_points.Points,'Rows');
wheel_stl_points_unique = wheel_stl_points_unique-[xOffset yOffset zOffset];

% Calculate radius of all points
radialDims = [2 3];
point_radius = sqrt(wheel_stl_points_unique(:,radialDims(1)).^2 + wheel_stl_points_unique(:,radialDims(2)).^2);

% Eliminate points within the exclusion radius
exclRad = 836;
edge_points = wheel_stl_points_unique(point_radius>=exclRad,:,:);

close(1)
figure(2)
trimesh(wheel_stl_new,'EdgeColor',[0.6 0.6 0.6])
hold on
plot3(edge_points(:,1),edge_points(:,2),edge_points(:,3),'bo')
axis equal
box on
hold off
title('Points Outside Minimum Radius (Iso View)')
text(0.04,0.9,[num2str(size(edge_points,1)) ' Points'],'Units','normalized','Color','b')
view(-45,30)

figure(3)
trimesh(wheel_stl_new,'EdgeColor',[0.6 0.6 0.6])
hold on
plot3(edge_points(:,1),edge_points(:,2),edge_points(:,3),'bo')
axis equal
box on
hold off
title('Points Outside Minimum Radius (Right View)')
text(0.03,0.05,[num2str(size(edge_points,1)) ' Points'],'Units','normalized','Color','b')
view(90,0)

%% 
% We can also eliminate points that are too close to at least two other
% points. This thins out dense clouds of points where the CAD geometry has sharp curves
edge_points_thin = removeClosePoints(edge_points, 3.75);

figure(4)
trimesh(wheel_stl_new,'EdgeColor',[0.6 0.6 0.6])
hold on
plot3(edge_points(:,1),edge_points(:,2),edge_points(:,3),'bo')
plot3(edge_points_thin(:,1),edge_points_thin(:,2),edge_points_thin(:,3),'ro','MarkerFaceColor','red')
axis equal
box on
hold off
title('Points Outside Minimum Radius, Thinned (Iso View)')
text(0.03,0.9,[num2str(size(edge_points_thin,1)) ' Points'],'Units','normalized','Color','r')
view(-45,30)

%% Filter Points Using Convex Hull
%
% A method which is useful is extracting the points that form a
% convex hull. This is the smallest set of points that completely contains
% the shape, which for our wheel is useful. The resulting set would work
% for modeling contact between the wheel and the ground, but has many more
% points than we need for relatively smooth terrain.  
%
% Obtaining this set of points uses <matlab:doc('delaunayTriangulation')
% delaunayTriangulation> and <matlab:doc('convexHull') convexHull>.

wheel_stl_points_tri = delaunayTriangulation(wheel_stl_points_new);
cvh_inds  = convexHull(wheel_stl_points_tri);

% Eliminate duplicates
pc = unique([wheel_stl_points_tri.Points(cvh_inds,1),...
    wheel_stl_points_tri.Points(cvh_inds,2),...
    wheel_stl_points_tri.Points(cvh_inds,3)],'rows');

% Eliminate inner points
pc_rads = sqrt(pc(:,radialDims(1)).^2 + pc(:,radialDims(2)).^2);
edge_hull_points = pc(pc_rads>=800,:);

close(4)
figure(5)
trimesh(wheel_stl_new,'EdgeColor',[0.6 0.6 0.6])
hold on
plot3(pc(:,1),...
    pc(:,2),...
    pc(:,3),'b.')
axis equal
box on
hold off
title('Points Using Convex Hull')
text(0.04,0.9,[num2str(size(pc,1)) ' Points'],'Units','normalized','Color','b')
view(-45,30)

figure(6)
trimesh(wheel_stl_new,'EdgeColor',[0.6 0.6 0.6])
hold on
plot3(edge_hull_points(:,1),...
    edge_hull_points(:,2),...
    edge_hull_points(:,3),'b.')
axis equal
box on
hold off
title('Points Convex Hull, Outside Minimum Radius (Right View)')
view(90,0)
text(0.05,0.05,[num2str(size(edge_hull_points,1)) ' Points'],'Units','normalized','Color','b')

%% 
% We can also eliminate points that are too close to at least two other
% points. This thins out dense clouds of points where the CAD geometry has sharp curves
edge_hull_points_thin = removeClosePoints(edge_hull_points, 3.75);

figure(7)
trimesh(wheel_stl_new,'EdgeColor',[0.6 0.6 0.6])
hold on
plot3(edge_hull_points(:,1),...
    edge_hull_points(:,2),...
    edge_hull_points(:,3),'b.')
plot3(edge_hull_points_thin(:,1),...
    edge_hull_points_thin(:,2),...
    edge_hull_points_thin(:,3),'ro')
axis equal
box on
hold off
title('Points Convex Hull, Outside Minimum Radius, Thinned')
text(0.04,0.9,[num2str(size(edge_hull_points_thin,1)) ' Points'],'Units','normalized','Color','r')
view(-45,30)


%%
%close all
