% Conway's Game of Life
% 
% RULES:
%   - Any live cell with fewer than two live neighbours dies, as if by
%     underpopulation.
%   - Any live cell with two or three live neighbours lives on to the next
%     generation.
%   - Any live cell with more than three live neighbours dies, as if by
%     overpopulation.
%   - Any dead cell with exactly three live neighbours becomes a live cell,
%     as if by reproduction.
%
% Written by Jonathan De Sousa
% Date: 08/07/2021

% clear workspace and screen
clear
clc
close all

%% Problem specification

SIZE = ceil(100); % size/side length of square domain
gens = 500; % number of generations

%% Initial condition

% Initial state (manual)
%IC = input('Enter pre-set initial state: ','s');
IC = 'glider';

switch IC
    % Still lives
    case 'block'
        X = [0,0,1,1];
        Y = [0,1,0,1];
    case 'bee-hive'
        X = [0,1,2,3,2,1];
        Y = [0,1,1,0,-1,-1];
    case 'loaf'
        X = [0,1,2,3,3,2,1];
        Y = [0,1,1,0,-1,-2,-1];
    case 'boat'
        X = [0,1,2,1,0];
        Y = [0,0,-1,-2,-1];
    case 'tub'
        X = [-1,0,1,0];
        Y = [0,1,0,-1];
    
    % Oscillators
    case 'blinker'
        X = [0,0,0];
        Y = [-1,0,1];
    case 'toad'
        X = [0,1,2,1,2,3];
        Y = [0,0,0,1,1,1];
    case 'beacon'
        X = [-2,-2,-1,0,1,1];
        Y = [1,2,2,-1,-1,0];
    case 'pulsar'
        X = [-4,-3,-2,2,3,4,-6,-1,1,6,-6,-1,1,6,-6,-1,1,6,-4,-3,-2,2,3,4,...
            -4,-3,-2,2,3,4,-6,-1,1,6,-6,-1,1,6,-6,-1,1,6,-4,-3,-2,2,3,4];
        Y = [6,6,6,6,6,6,4,4,4,4,3,3,3,3,2,2,2,2,1,1,1,1,1,1,...
            -1,-1,-1,-1,-1,-1,-2,-2,-2,-2,-3,-3,-3,-3,-4,-4,-4,-4,...
            -6,-6,-6,-6,-6,-6];
    case 'pentadecathlon'
        X = [0,0,-1,1,0,0,0,0,-1,1,0,0];
        Y = [-4,-3,-2,-2,-1,0,1,2,3,3,4,5];
        
    % Spaceships
    case 'glider'
        X = [-1,0,1,-1,0];
        Y = [1,0,0,-1,-1];
    case 'LWSS'
        X = [-1,0,-2,-1,0,1,-2,-1,1,2,0,1];
        Y = [2,2,1,1,1,1,0,0,0,0,-1,-1];
    case 'MWSS'
        X = [0,-2,2,3,-2,3,-1,0,1,2,3];
        Y = [2,1,1,0,-1,-1,-2,-2,-2,-2,-2];
    case 'HWSS'
        X = [-2,-1,0,1,2,3,-3,3,3,-3,2,-1,0];
        Y = [2,2,2,2,2,2,1,1,0,-1,-1,-2,-2];
end

% Random
%N = 50; % number of live cells
%X = floor(SIZE*rand(1,50)) - SIZE/2;
%Y = floor(SIZE*rand(1,50)) - SIZE/2;

% Translate/transform position
X = X + ceil(SIZE*0.9);
Y = Y + SIZE/2;

%% Boundary condition at the walls

% -----TYPES-----
% death    - cells die past domain edges
% living   - domain edges are surrounded by a wall of live cells
% periodic - cells that go past one edge loop around to opposite edge
% infinite - cells that go past domain edges propagate forever (but are not shown)

BC = 'periodic';

%% Iterate over specified no. of generations

for gg = 1:gens
    figure(1)
    square(SIZE, SIZE/2, SIZE/2, 0, 'k', 1)
    hold on
    square(1, X, Y, 1, 'b', 2)
    axis equal
    pause(1)
    
    % Periodic boundary condition extension (live cells)
    if strcmp(BC,'periodic')
        % Right wall
        if any(X == SIZE) 
            no_lWall = length(find(X == 0));
            X = [X,(SIZE+1)*ones(1,no_lWall)];
            Y = [Y,Y(find(X == 0))];
        end
        % Left wall
        if any(X == 0) 
            no_rWall = length(find(X == SIZE));
            X = [X,(-1)*ones(1,no_rWall)];
            Y = [Y,Y(find(X == SIZE))];
        end
        % Top wall
        if any(Y == SIZE)
            no_bWall = length(find(Y == 0));
            X = [X,X(find(Y == 0))];
            Y = [Y,(SIZE+1)*ones(1,no_bWall)];
        end
        % Bottom wall
        if any(Y == 0)
            no_tWall = length(find(Y == SIZE));
            X = [X,X(find(Y == SIZE))];
            Y = [Y,(-1)*ones(1,no_tWall)];
        end
    end
        
    % Death of live cells by under- and over-population
    count = 1;
    live2dead = zeros(1,length(X));
    for i = 1:length(X)
        diff_X = X - X(i);
        diff_Y = Y - Y(i);
        dist = sqrt(diff_X.^2 + diff_Y.^2);
        dist(i) = [];
        if length(find(dist < 1.4143)) < 2 || length(find(dist < 1.4143)) > 3
            live2dead(count) = i;
            count = count + 1;
        end
    end
    live2dead(count:end) = [];
    
    X_nextgen = X;
    Y_nextgen = Y;
    
    X_nextgen(live2dead) = [];
    Y_nextgen(live2dead) = [];
    
    % Dead cells that could be revived
    [X_dead, Y_dead] = meshgrid(min(X)-1:max(X)+1, min(Y)-1:max(Y)+1);
    
    % Vectorise matrices
    X_dead = X_dead(:)';
    Y_dead = Y_dead(:)';
    
    % Eliminate currently live cells from X/Y_domain
    count = 1;
    live = zeros(1,length(X));
    for i = 1:length(X_dead)
        for j = 1:length(X)
            if X_dead(i) == X(j) && Y_dead(i) == Y(j)
                live(count) = i;
                count  = count + 1;
            end
        end
    end
    
    X_dead(live) = [];
    Y_dead(live) = [];
    
    % Reproduction reviving dead cells
    count = 1;
    dead2live = zeros(length(X_dead));
    for i = 1:length(X_dead)
        diff_X = X - X_dead(i);
        diff_Y = Y - Y_dead(i);
        dist = sqrt(diff_X.^2 + diff_Y.^2);
        if length(find(dist < 1.4143)) == 3
            dead2live(count) = i;
            count = count + 1;
        end
    end
    dead2live(count:end) = [];
    
    X = [X_nextgen,X_dead(dead2live)];
    Y = [Y_nextgen,Y_dead(dead2live)];
    
    switch BC
        case 'death'
            death_BC = union(find(X<0 | X>SIZE), find(Y<0 | Y>SIZE));
            X(death_BC) = [];
            Y(death_BC) = [];
        case 'periodic'
            % Right wall
            if any(X > SIZE)
                rightBC = find(X > SIZE);
                X(rightBC) = X(rightBC) - SIZE;
            end
            % Left wall
            if any(X < 0)
                leftBC = find(X < 0);
                X(leftBC) = X(leftBC) + SIZE;
            end
            % Top wall
            if any(Y > SIZE)
                topBC = find(Y > SIZE);
                Y(topBC) = Y(topBC) - SIZE;
            end
            % Bottom wall
            if any(Y < 0)
                bottomBC = find(Y < 0);
                Y(bottomBC) = Y(bottomBC) + SIZE;
            end
    end
end