function dydt = Solver(t,y,munstycksArea,cd,rhoVatten,atmTryck,flaskVolym,torrMassa,cdLuft,projektionsArea,startVinkel)
    x = y(1); 
    h = y(2); 
    vx = y(3); 
    vy = y(4); 
    vv = y(5); 
    p = y(6); 
    
    g = 9.81;

    v = sqrt(vx^2 + vy^2);
    
    if v < 0.1
        ex = cos(startVinkel);
        ey = sin(startVinkel);
    else
        ex = vx / v;
        ey = vy / v;
    end

    m = torrMassa + vv*rhoVatten;
    
    dragKraft = (1/2)*1.2*(v^2)*cdLuft*projektionsArea;

    if vv > 0 && p > atmTryck
        dmdt = munstycksArea*cd*sqrt(2*rhoVatten*(p-atmTryck));
        vattenHastighet = dmdt/(rhoVatten*munstycksArea);
        motorKraft = dmdt * vattenHastighet;
        dvvdt = -dmdt / 1000; 
        luftVolym = flaskVolym - vv;
        dpdt = (p/luftVolym)*dvvdt; 
    
    else %Om vattnet i flaskan är slut
        motorKraft = 0;
        dvvdt = 0;
        dpdt = 0;
    end

    ftot = motorKraft - dragKraft;
    fx = ftot * ex;
    fy = ftot * ey - m*g;
    ax = fx / m; 
    ay = fy / m; 

    dydt = [vx;
            vy;
            ax;
            ay;
            dvvdt;
            dpdt];
end
