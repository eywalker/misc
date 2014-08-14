function y = tiltRect(alpha, beta, r, s, d)
    theta = beta - alpha;
    delta_x = abs(d ./ cos(beta) .* cos(theta));
    delta_y = abs(d ./ cos(beta) .* sin(theta));
    da = max(0, r * s - delta_x);
    db = max(0, s - delta_y);
    y = r*s^2 - da .* db;
end