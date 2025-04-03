function filteredPoints = removeClosePoints(points, distanceThreshold)
    % Function to remove points that are within a specified distance of at least two other points.
    % 
    % Args:
    %     points: An nx3 matrix where each row represents a point in 3D space.
    %     distanceThreshold: The distance threshold for determining closeness.
    %
    % Returns:
    %     filteredPoints: An mx3 matrix of points that are not close to at least two other points.

    n = size(points, 1); % Number of points
    toRemove = false(n, 1); % Logical array to mark points for removal

    % Calculate the pairwise distances between points
    for i = 1:n
        if ~toRemove(i) % Only check points not already marked for removal
            distances = sqrt(sum((points - points(i, :)).^2, 2));
            % Count how many points are within the distance threshold excluding itself
            closePoints = sum(distances < distanceThreshold) - 1;
            % Mark the point for removal if it is close to at least two other points
            if closePoints >= 2
                toRemove(i) = true;
            end
        end
    end

    % Filter out the points marked for removal
    filteredPoints = points(~toRemove, :);
end