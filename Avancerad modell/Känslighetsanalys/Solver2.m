function dydt = Solver(t,y,p)
%Själva formatet för denna funktion är standard för ode45 i matlab, så
%det finns dokumentation online.
flaskVolym      = p(1);
projektionsArea = p(2);
torrMassa       = p(3);
munstycksArea   = p(4);
flaskTryck      = p(5);
atmTryck        = p(6);
vattenVolym     = p(7);
rhoVatten       = p(8);
cdLuft          = p(9);
cd              = p(10);
startVinkel     = p(11);

ex = cos(startVinkel);
ey = sin(startVinkel);
%Initierar alla startvärden
    x = y(1); %X-pos.
    h = y(2); %Höjd
    vx = y(3); %Hastighet x
    vy = y(4); %Hastighet y
    vv = y(5); %Vatten-volym
    p = y(6); %Flasktryck
    
    g = 9.81;

    v = sqrt(vx^2 + vy^2);
    
    %Detta gör att vinkeln är låst då hastigheten är mycket låg
    %(hjälper med stabilitet men framförallt gör att den börjar
    %i rätt vinkel)
    if v < 0.1
        ex = cos(startVinkel);
        ey = sin(startVinkel);
    else
        %Senare i färden följer vinkeln hastighetens riktning
        ex = vx / v;
        ey = vy / v;
    end

    %Räknar momentär tot. massa
    m = torrMassa + vv*rhoVatten;
    
    %Nasa drag equation
    dragKraft = (1/2)*1.2*(v^2)*cdLuft*projektionsArea;

    %Kontrollerar om det finns vatten kvar i flaskan samt om trycket
    %är högre än det atmosfäriska trycket utanför flaskan
    %(om det atmosfäriska trycket är högre får man
    %en negativ rot och ger error för imaginära tal)
    if vv > 0 && p > atmTryck
        %Dessa formler är tagna från dokumenten för enkla modeller
        dmdt = munstycksArea*cd*sqrt(2*rhoVatten*(p-atmTryck));
        vattenHastighet = dmdt/(rhoVatten*munstycksArea);
        motorKraft = dmdt * vattenHastighet;
        dvvdt = -dmdt / 1000; 
        luftVolym = flaskVolym - vv;

        %Förändringen i tryck beroende på vatten-volymens förändring
        dpdt = (p/luftVolym)*dvvdt; 
    
    else %Om vattnet i flaskan är slut eller det atmosfäriska trycket
         %blir högre än flasktrycket
        motorKraft = 0;
        dvvdt = 0;
        dpdt = 0;
    end

    %Räknar de slutgiltiga accelerationerna
    ftot = motorKraft - dragKraft;
    fx = ftot * ex;
    fy = ftot * ey - m*g;
    ax = fx / m; 
    ay = fy / m; 

    %Använder derivatorna för nästa iteration
    dydt = [vx;
            vy;
            ax;
            ay;
            dvvdt;
            dpdt];
end
