function [q, rx, ry] = solve_q(x, y, inv_h, N)

for i = 0:(N-1)
    xi = x(i+1);
    yi = y(i+1);
    for j = 0:(N-1)
        rx(i*N+j+1) = xi - x(j+1);
        ry(i*N+j+1) = yi - y(j+1);
        q(i*N+j+1) = sqrt((rx(i*N+j+1))^2+(ry(i*N+j+1))^2)*inv_h;
    end
end

end
