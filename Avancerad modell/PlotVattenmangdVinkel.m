%Detta script är en kopia/utbyggnad av AvanceradModell.m
%med funktionalitet för att plotta uppskjutningsvinkel
%och vattenmängd mot horisontellt uppnådd längd.

clear all;
close all;

Matningar = 100; %Antalet olika vinklar och vattenmängder som provas

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

%Itererar genom vinklar och vattenmängder och lagrar resultaten i
%resultatmatris
for vinkel = startVinkel
    for vatten = vattenVolym
        y0 = [0;0;0;0;vatten;flaskTryck];
        tspan = [0,5];
        %Själva solvern (löser diff ekvationerna)
        [t,resultat] = ode45(@(t,y) Solver(t,y,munstycksArea, cd, rhoVatten, atmTryck, flaskVolym, torrMassa, cdLuft, projektionsArea, vinkel), tspan, y0);
        
        %Hittar indexet för maxhöjd under färden i syfte
        %att man ska kunna hitta när den träffar marken
        %efter maxhöjden (annars returnerar den startpositionen)
        [~,indexMaxh] = max(resultat(:,2));

        %Hittar var raketen träffar marken
        [~, relIndex] = min(abs(resultat(indexMaxh:end, 2)));

        %Lägger ihop offsetarna för att få mätpunkter sedan start
        indexMarken = relIndex + indexMaxh - 1;
        xvarde = resultat(indexMarken,1)
        resultatmatris(x,y) = xvarde;
        y = y+1;
    end
    y = 1;
    x = x+1;
end


%Delar upp mtävärdena för att kunna göra en surf
[VattenGrid, VinkelGrid] = meshgrid(vattenVolym, startVinkel);

surf(VattenGrid, VinkelGrid, resultatmatris);

xlabel('Vattenvolym (m^3)');
ylabel('Startvinkel (rad)');
zlabel('Horisontellt avstånd (m)');

%För att surfen ska se ut som en kub, med lika skalor
pbaspect([1 1 1]);

grid on;
