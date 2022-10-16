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
mu = 30;

x = zeros(D,mu+1);
sigmas = zeros(D,mu+1);
fitness = zeros(mu+1);

for i=1:mu
    x(:,i) = xl+(xu-xl).*rand(D, 1);
    sigmas(:,i) = 0.1*rand(D,1);
end 

f_plot = zeros(1,G);

for g=1:G
    %Seleccion
    r1 = randi([1 mu]);
    r2 = r1;

    while r2==r1
        r2 = randi([1 mu]);
    end

    % Recombinacion
    %Sexual discreta
%     for j=1:D
%         if randi([0 1])
%             x(j,mu+1) = x(j,r1);
%             sigmas(j,mu+1) = sigmas(j,r1);
%         else
%             x(j,mu+1) = x(j,r2);
%             sigmas(j,mu+1) = sigmas(j,r2);
%         end
%     end

    x(:,mu+1) = (x(:,r1)+x(:,r2))/2;
    sigmas(:,mu+1) = (sigmas(:,r1)+sigmas(:,r2))/2;

    r = normrnd(0,sigmas(:,mu+1));
    x(:,mu+1) = x(:,mu+1) + r;

    for i=1:mu+1
        fitness(i) = f(x(1,i), x(2,i));
    end

    [~,i] = sort(fitness);

    x = x(:,i);
    sigmas = sigmas(:,i);
    fitness = fitness(i);

    f_plot(g) = f(x(1,1), x(2,1));
    Plot_Contour(f,x,xl,xu);
end

xb = x(:,1);

figure
Plot_Surf(f,xb,xl,xu);
disp(["Minimo global en: x=" num2str(xb(1)) ", y=" num2str(xb(2)) ", F(x, y)=" num2str(f(xb(1), xb(2)))])

figure
plot(f_plot);