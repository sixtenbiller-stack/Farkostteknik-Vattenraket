function [t,resultat] = solverController(munstycksArea,cd,rhoVatten,atmTryck,flaskVolym,torrMassa,cdLuft,projektionsArea,startVinkel,startTemp, flaskTryck, tspan, vattenVolym)
resultat = [];
if vattenVolym > 0
    y0 = [0;0;0;0;vattenVolym;flaskTryck];
    [t,resultat] = ode15s(@(t,y) Solver(t,y,munstycksArea, cd, rhoVatten, atmTryck, flaskVolym, torrMassa, cdLuft, projektionsArea, startVinkel), tspan, y0);
    
    indexNollstalle = find(diff(sign(resultat(:,5))) ~= 0,1, 'first');
    y0L = resultat(indexNollstalle,:);
    tryck = resultat(indexNollstalle,6);
    if isempty(indexNollstalle)
        return
    end
else
    y0L = [0;0;0;0;vattenVolym;flaskTryck];
    tryck = flaskTryck;
    t = 0;
    indexNollstalle = 1;
end

[tL,resultatLuft] = ode15s(@(tL,yL) solverLuft(tL,yL,munstycksArea,cd,rhoVatten,atmTryck,flaskVolym,torrMassa,cdLuft,projektionsArea,startVinkel,startTemp,tryck), tspan, y0L);
if ~isempty(resultat)
    resultat = [resultat(1:indexNollstalle,:);resultatLuft];
else
    resultat = resultatLuft;
end
t = [t(1:indexNollstalle,:);tL+t(indexNollstalle)];
end