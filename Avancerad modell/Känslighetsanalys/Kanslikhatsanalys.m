clear all;
close all;

fel = 0.1 % i decimalform
flaskVolym = 1.5/1000;
projektionsArea = ((0.0881/2)^2)*pi;
torrMassa = 0.107;
munstycksArea = ((0.0205/2)^2)*pi;
flaskTryck = 7*100000;
atmTryck = 1 * 100000;
vattenVolym = 6.9000e-04;
rhoVatten = 1000;
cdLuft = 0.75;
cd = 0.98;
startVinkel = 0.6597;

y0 = [0;0;0;0;vattenVolym;flaskTryck];
tspan = [0,5];

p = [flaskVolym,projektionsArea,torrMassa,munstycksArea,flaskTryck,atmTryck,vattenVolym,rhoVatten,cdLuft,cd,startVinkel]
pnamn = ["flaskVolym","projektionsArea","torrMassa","munstycksArea","flaskTryck","atmTryck","vattenVolym","rhoVatten","cdLuft","cd","startVinkel"]
n = length(p)

for i= 1:n
    p_plus = p
    p_minus = p

    p_plus(i) = (1+fel) * p(i)
    p_minus(i) = (1-fel) * p(i)

    p2 = [p_plus; p; p_minus]
    figure('Name',pnamn(i),'NumberTitle','off')
    for j = 1:3
    %Själva solvern som löser diff ekvationerna
    [t,resultat] = ode45(@(t,y) Solver2(t,y,p2(j,:)), tspan, y0);
    
    farg = ["g","b","r"]
    hold on
    grid on
    plot(resultat(:,1), resultat(:,2),farg(j));
    end
    
end

%[t,resultat] = ode45(@(t,y) Solver(t,y,munstycksArea, cd, rhoVatten, atmTryck, flaskVolym, torrMassa, cdLuft, projektionsArea, startVinkel), tspan, y0);

axis equal;
grid on;
