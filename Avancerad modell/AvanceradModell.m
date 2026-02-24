clear all;
close all;

flaskVolym = 1.5/1000;
projektionsArea = ((0.0881/2)^2)*pi;
torrMassa = 0.107;
munstycksArea = ((0.0205/2)^2)*pi;
flaskTryck = 7*100000;
atmTryck = 1 * 100000;
vattenVolym = 0.5/1000;
rhoVatten = 1000;
cdLuft = 0.75;
cd = 0.98;
startVinkel = pi/4;

y0 = [0;0;0;0;vattenVolym;flaskTryck];

tspan = [0,5];

%Själva solvern som löser diff ekvationerna
[t,resultat] = ode45(@(t,y) Solver(t,y,munstycksArea, cd, rhoVatten, atmTryck, flaskVolym, torrMassa, cdLuft, projektionsArea, startVinkel), tspan, y0);
plot(resultat(:,1), resultat(:,2));

axis equal;
grid on;
