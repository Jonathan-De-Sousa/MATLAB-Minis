function rho = solve_rho(N, valrho, q)
% Computes fluid density associated with each particle

rho = zeros(1,N);

for i = 0:(N-1)
    for j = 0:(N-1)
        if q(i*N+j+1) < 1
            rho(i+1) = rho(i+1) + valrho*(1-q(i*N+j+1)^2)^3;
        end
    end
end

end