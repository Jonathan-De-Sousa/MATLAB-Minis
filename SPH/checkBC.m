function [x, y, vx, vy] = checkBC(N, h, e, x, y, vx, vy)
% Enforces solid wall boundary conditions of the unit box

for i = 0: (N-1)
    % Left wall
    if x(i+1) <= h
        x(i+1) = h;
        vx(i+1) = -e*vx(i+1);
    % Right wall
    elseif x(i+1) >= (1-h)
        x(i+1) = 1-h;
        vx(i+1) = -e*vx(i+1);
    end
    % Bottom wall
    if y(i+1) <= h
        y(i+1) = h;
        vy(i+1) = -e*vy(i+1);
    % Top wall
    elseif y(i+1) >= (1-h)
        y(i+1) = 1-h;
        vy(i+1) = -e*vy(i+1);
    end
end

end
