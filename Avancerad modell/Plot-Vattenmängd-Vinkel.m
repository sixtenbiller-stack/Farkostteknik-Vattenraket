clear all;
close all;

Matningar = 200;

flaskVolym = 1.5/1000;
projektionsArea = ((0.0881/2)^2)*pi;
torrMassa = 0.107;
munstycksArea = ((0.0205/2)^2)*pi;
flaskTryck = 7*100000;
atmTryck = 1 * 100000;
vattenVolym = 0:((1.5/1000)/Matningar):1.5/1000; %Är i kubikmeter...
rhoVatten = 1000;
cdLuft = 0.75;
cd = 0.98;
startVinkel = 0:((pi/2)/Matningar):pi/2;

resultatmatris = zeros(Matningar);

x = 1;
y = 1;
for vinkel = startVinkel
    for vatten = vattenVolym
        y0 = [0;0;0;0;vatten;flaskTryck];
        tspan = [0,5];
        [t,resultat] = ode45(@(t,y) Solver(t,y,munstycksArea, cd, rhoVatten, atmTryck, flaskVolym, torrMassa, cdLuft, projektionsArea, vinkel), tspan, y0);
        
        [~,indexMaxh] = max(resultat(:,2));

        [~, relIndex] = min(abs(resultat(indexMaxh:end, 2)));

        indexMarken = relIndex + indexMaxh - 1;
        xvarde = resultat(indexMarken,1)
        resultatmatris(x,y) = xvarde;
        y = y+1;
    end
    y = 1;
    x = x+1;
end

[VattenGrid, VinkelGrid] = meshgrid(vattenVolym, startVinkel);

% Plotta ytan med de faktiska fysikaliska värdena
surf(VattenGrid, VinkelGrid, resultatmatris);

% Formatera axlarna med rätt enheter
xlabel('Vattenvolym (m^3)');
ylabel('Startvinkel (rad)');
zlabel('Horisontellt avstånd (m)');

pbaspect([1 1 1]);

grid on;
