function luftVridmoment = stabilitetRaknare(fenArea,mittPunktFenor,noskonMassa)

flaskLangd = 0.29;
flaskBredd = 0.1;
flaskArea = flaskLangd*flaskBredd;
flaskMassa = 0.03;


cdFena = 1.17;
cdFlaska = 1.1;
kartongDensitet = 780;
fenMassa = (fenArea*30/1000)*kartongDensitet*4;

massaTot = flaskMassa + fenMassa + noskonMassa;

luftDensitet = 1.2;

hastighet = 15;

massCentrum = (flaskMassa * (flaskLangd/2) + fenMassa * mittPunktFenor + noskonMassa * flaskLangd)/massaTot;

luftVridmoment = ((cdFena * (luftDensitet * hastighet^2)/2 * fenArea*2)*(massCentrum - mittPunktFenor))+((cdFlaska * (luftDensitet * hastighet^2)/2 * flaskArea)*(massCentrum-(flaskLangd/2)));

end