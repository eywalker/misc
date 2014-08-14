alphas = linspace(-pi/2, pi/2, 100);
beta = linspace(-pi/2, pi/2, 100);

%r = 5; % side ratio of rectangle
s = 1000; % scale
d = 400; % distance between corresponding bars
delta2 = 0.03; % pixels/area
k = 9; % possible number of intensities

figure;
rs=[1,2,5];
colors = lines;
for idxR = 1:length(rs)
    r = rs(idxR);

    beta_hat = zeros(size(alphas));
    for i = 1:length(alphas)
        alpha = alphas(i);
        bdistr = tiltRect(alpha, beta, r, s, d);
        pb = k.^(-delta2 * bdistr.^0.4);
        beta_hat(i)=pb * beta' ./ sum(pb);
    end
    hold on;
    plot(alphas, beta_hat, 'color', colors(idxR, :));
    axis([-pi/2, pi/2, -pi/2, pi/2]);
end