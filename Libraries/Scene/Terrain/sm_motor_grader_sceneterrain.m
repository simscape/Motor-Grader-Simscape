function [terrain_surf] = sm_motor_grader_sceneterrain

% Import raw surface data
fname = "swissalti3d_2019_2609-1192_0.5_2056_5728.tif";
full_surface     = double(imread(fname));

% Reorient so that columns are x (east-west), rows are y (north-south)
full_surface_ori.h = rot90(full_surface,-1);

% Create full x and y grid spacing
grid_spacing = 0.5; % m
full_surface_ori.x = (1:size(full_surface_ori.h,1))*grid_spacing;
full_surface_ori.y = (1:size(full_surface_ori.h,2))*grid_spacing;

% Select portion of surface for orchard by indices
x_inds      =  800:900;
y_inds      =  1400:2000; 

% To use entire surface
%x_inds = 1:size(full_surface,1);
%y_inds = 1:size(full_surface,2);

% Extract portion of surface
% Rotate so surface is along +x
terrain_surf.h = rot90(full_surface_ori.h(x_inds,y_inds),1);
terrain_surf.y = full_surface_ori.x(x_inds);
terrain_surf.x = full_surface_ori.x(y_inds);

x_offset = 10;
terrain_surf.x = terrain_surf.x-min(terrain_surf.x)-x_offset;
terrain_surf.y = terrain_surf.y-min(terrain_surf.y)-(max(terrain_surf.y)-min(terrain_surf.y))/2;
terrain_surf.h = terrain_surf.h-terrain_surf.h(x_offset/grid_spacing+1,(floor(length(x_inds)/2)));

end