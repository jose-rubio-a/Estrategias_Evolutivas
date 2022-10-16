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
lambda = 20;

x = zeros(D,mu+lambda);
sigmas = zeros(D,mu+lambda);
fitness = zeros(1,mu+lambda);

f_plot = zeros(1,G);

for i=1:mu
    x(:,i) = xl+(xu-xl).*rand(D, 1);
    sigmas(:,i) = 0.1*rand(D,1);
end 

for g=1:G
    for k=1:lambda
        %Seleccion
        r1 = randi([1 mu]);
        r2 = r1;

        while r2==r1
            r2 = randi([1 mu]);
        end

        % Recombinacion
        %Sexual discreta
%         for j=1:D
%             if randi([0 1])
%                 x(j,mu+k) = x(j,r1);
%                 sigmas(j,mu+k) = sigmas(j,r1);
%             else
%                 x(j,mu+k) = x(j,r2);
%                 sigmas(j,mu+k) = sigmas(j,r2);
%             end
%         end

        %Sexual Intermadia
        x(:,mu+k) = (x(:,r1)+x(:,r2))/2;
        sigmas(:,mu+k) = (sigmas(:,r1)+sigmas(:,r2))/2;

        r = normrnd(0,sigmas(:,mu+k));
        x(:,mu+k) = x(:,mu+k) + r;

        %Sexual Global
%         for j=1:D
%             r1 = randi([1 mu]);
% 
%             x(j,mu+k) = x(j,r1);
%             sigmas(j,mu+k) = sigmas(j,r1);
%         end
    end

    for i=1:mu+lambda
        fitness(i) = f(x(1,i), x(2,i));
    end

    [~,i] = sort(fitness);

    x = x(:,i);
    sigmas = sigmas(:,i);
    fitness = fitness(i);

    f_plot(g) = f(x(1,1), x(2,1));
    Plot_Contour(f,x(:,1:mu),xl,xu);
end

xb = x(:,1);

figure
Plot_Surf(f,xb,xl,xu);
disp(["Minimo global en: x=" num2str(xb(1)) ", y=" num2str(xb(2)) ", F(x, y)=" num2str(f(xb(1), xb(2)))])

figure
plot(f_plot);