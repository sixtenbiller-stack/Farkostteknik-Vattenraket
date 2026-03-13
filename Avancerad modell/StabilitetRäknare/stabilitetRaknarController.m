clear all;
close all;
fenArea = (10/100)*(6/100);
mittPunktFenor = 3.5/100;
noskonMassa = 200/1000;
stabilitetRaknare(fenArea,mittPunktFenor,noskonMassa)

%Om värdet är positivt innebär det att raketen är stabil (tror jag).
%Ju mer positivt, ju bättre stabilitet borde det vara.
%Är det negatvit kommer den vara instabil och flippa i luften (under
%cruising-fasen vid ca 15m/s).