k1 = 1 ./ (3 * pi/180).^2;
k2 = 1 ./ (15 * pi/180).^2;
n = 10000;

s_noise = 10e6; % stdev of noise in degrees (roughly speaking)
k_noise = 1e-10;%1 ./ (s_noise * pi / 180).^2;

x = linspace(-pi, pi, n);

f1 = vonmises(x, 0, k1);
f2 = vonmises(x, 0, k2);


fh1 = repmat(f1, [1, 3]);
fh2 = repmat(f2, [1, 3]);
h = vonmises(x, 0, k_noise);
%h = normpdf(x, 0, s_noise * pi/180);


h1 = conv(fh1, h, 'same');
h2 = conv(fh2, h, 'same');

h1 = h1(n+1:2*n);
h2 = h2(n+1:2*n);

figure;
subplot(2,1,1);
plot(x, h);
subplot(2,1,2);
plot(x, h1-h2);

[~, pos] = min(abs(h1-h2));
title(num2str(x(pos)));
