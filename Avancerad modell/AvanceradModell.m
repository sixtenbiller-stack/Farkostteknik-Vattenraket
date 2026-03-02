clear all;
close all;

%antalSteg = 10000

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
startTemp = 293.15;

tspan = [0,5];

[t,resultat] = solverController(munstycksArea,cd,rhoVatten,atmTryck,flaskVolym,torrMassa,cdLuft,projektionsArea,startVinkel,startTemp, flaskTryck, tspan, vattenVolym);

%Själva solvern som löser diff ekvationerna

plot(resultat(:,1), resultat(:,2));
axis equal;
difft = diff(t);
diffax = diff(resultat(:,3));
diffay = diff(resultat(:,4));
magAcc = (sqrt((diffax.^2) + (diffay.^2)))./difft;
figure;
plot(t,[magAcc;0]);

%tid = linsepace(0,5,antalSteg);
%dt = diff(tid);

%y=[
%    0,
%    0,
%    0,
%    0,
%    vattenVolym,
%    flaskTryck
%    ]
%Solver(t,y,munstycksArea,cd,rhoVatten,atmTryck,flaskVolym,torrMassa,cdLuft,projektionsArea,startVinkel)

%resultatVektor = [];
%tidigareIteration = 0
%for t = dt
%dydt = solver(t,y,munstycksArea,cd,rhoVatten,atmTryck,flaskVolym,torrMassa,cdLuft,projektionsArea,startVinkel)
%tidigareIteration = dydt .* t;
%resultatVektor = [resultatVektor]
%end


%axis equal;
grid on;
