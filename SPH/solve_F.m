function [ax,ay] = solve_F(N, rho, rx, ry, q, p, g, vx, vy, valFp, valFv)
% Computes the pressure, viscous, and gravitational forces, Fp*, Fv* and Fg
% respectively, and acceleration, a*, experienced by each perticle.
% * = x or y, for the two directional components of quantities.

% Initialise arrays
Fpx = zeros(1,N); % x-direction pressure force
Fpy = zeros(1,N); % y-direction pressure force
Fvx = zeros(1,N); % x-direction viscous force
Fvy = zeros(1,N); % y-direction viscous force
Fg = zeros(1,N); % gravitational force
ax = zeros(1,N); % x-direction acceleration
ay = zeros(1,N); % y-direction acceleration

for i = 0:(N-1)
    for j = 0:(N-1)
        if i~= j && q(i*N+j+1) < 1
            inv_rhoj = 1/rho(j+1);
            Fpx(i+1) = Fpx(i+1) + valFp*((p(i+1)+p(j+1))*inv_rhoj)*...
                rx(i*N+j+1)*(1-q(i*N+j+1))^2/q(i*N+j+1);
            Fpy(i+1) = Fpy(i+1) + valFp*((p(i+1)+p(j+1))*inv_rhoj)*...
                ry(i*N+j+1)*(1-q(i*N+j+1))^2/q(i*N+j+1);
            Fvx(i+1) = Fvx(i+1) + valFv*(q(i*N+j+1)-1)*...
                (vx(i+1) - vx(j+1))*inv_rhoj;
            Fvy(i+1) = Fvy(i+1) + valFv*(q(i*N+j+1)-1)*...
                (vy(i+1) - vy(j+1))*inv_rhoj;
        end
    end
    Fg(i+1) = -rho(i+1)*g;
    ax(i+1) = (Fpx(i+1)+Fvx(i+1))/rho(i+1);
    ay(i+1) = (Fpy(i+1)+Fvy(i+1)+Fg(i+1))/rho(i+1);
end

end