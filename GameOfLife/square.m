function square(slength, xcentre, ycentre, fillc, colour, LineWidth)
% square(length, xcentre, ycentre, fillc, colour, LineWidth) plots a square. 
%
% INPUTS: slength   - length of each side
%         xcentre   - array of x-coordinates of square's centre
%         ycentre   - array of y-coordinates of square's centre
%         fillc     - colour fill of square: 1 = YES; [other number] = NO
%         colour    - colour to fill square
%         LineWidth - line thickness of sides
% 
% Written by Jonathan De Sousa
% Date: 08/07/2021

X = [xcentre'-slength/2, xcentre'+slength/2, xcentre'+slength/2,...
    xcentre'-slength/2, xcentre'-slength/2];
Y = [ycentre'-slength/2, ycentre'-slength/2, ycentre'+slength/2,...
    ycentre'+slength/2, ycentre'-slength/2];

if length(xcentre) > 2
    hold on
end

if fillc == 1
    for i = 1:length(xcentre)
        fill(X(i,1:end), Y(i,1:end), colour)
    end
else
    for i = 1:length(xcentre)
        plot(X(i,1:end), Y(i,1:end), [colour, '-'], 'LineWidth', LineWidth);
    end
end
hold off