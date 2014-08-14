function [y, k] = vonmises(x, mu, k)
    %kappa = linspace(0,500,10000);
    %[~,pos]=min(abs(1-besseli(1,kappa)./besseli(0,kappa)-sigma.^2));
    %k = kappa(pos);
    y = exp(k * cos(x - mu)) ./ (2 * pi * besseli(0, k));
end