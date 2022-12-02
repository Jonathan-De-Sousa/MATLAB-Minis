function p = solve_p(N, k, rho, valp)
% Computes the fluid pressure associated with each particle

for i = 0:(N-1)
    p(i+1) = k*rho(i+1) + valp;
end

end