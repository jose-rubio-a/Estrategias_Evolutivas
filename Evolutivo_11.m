clear all
close all
clc

f = @(x,y) (x-2).^2+(y-2).^2;
xl = [-5 -5]';
xu = [5 5]';

% f = @(x,y) x.*exp(-x.^2-y.^2);
% xl = [-2 -2]';
% xu = [2 2]';

G = 1000;
D = 2;

sigma = 0.5;

x = xl+(xu-xl).*rand(D, 1);

f_plot = zeros(1,G);

for g=1:G
    r = normrnd(0,sigma,[D 1]);
    y = x + r;

    if f(y(1),y(2)) < f(x(1),x(2))
        x = y;
    end
    f_plot(g) = f(x(1), x(2));
    Plot_Contour(f,[x y],xl,xu);
end

figure
Plot_Surf(f,x,xl,xu);
disp(["Minimo global en: x=" num2str(x(1)) ", y=" num2str(x(2)) ", F(x, y)=" num2str(f(x(1), x(2)))])

figure
plot(f_plot);