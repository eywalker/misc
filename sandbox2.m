beta = linspace(-pi/2, pi/2, 1000);
area=@(alpha, beta, r, v_perp) (r * sqrt((v_perp./cos(beta) .* sin(beta-alpha)).^2 + (1/r * v_perp./cos(beta) .* cos(beta-alpha)).^2))

v_perp = 1;

alpha = linspace(-pi/2, pi/2, 100);

beta_hat = zeros(size(alpha));

for idxA = 1:length(alpha):
    a = alpha(idxA);
    
end