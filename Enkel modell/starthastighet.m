function [V0, Range] = starthastighet(raketMassa, vattenMassa, cd, vattenDensitet, A, atmTryck, flaskTryck, startvinkel)

    % Konstant för tyngdacceleration
    g = 9.8; 
    
    % 1. Tryckskillnad (delta P)
    p = flaskTryck - atmTryck;
    
    % 2. Massflöde (massFlowRate) - Extra 'A' under roten är borttaget
    massFlowRate = A * cd * sqrt(2 * vattenDensitet * p);
    
    % 3. Vattnets utgångshastighet (flowVelocity)
    flowVelocity = massFlowRate / (vattenDensitet * A);
    
    % 4. Drivkraft (Thrust)
    ft = massFlowRate * flowVelocity;
    
    % 5. Genomsnittlig massa (m_ave)
    m_ave = raketMassa + (vattenMassa / 2);
    
    % 6. Nettokraft (utan luftmotstånd, fd = 0)
    f_net = ft - (m_ave * g);
    
    % 7. Acceleration (a)
    a = f_net / m_ave;
    
    % 8. Tid för att spruta ut allt vatten (t)
    t = vattenMassa / massFlowRate;
    
    % 9. Starthastighet för kastbanan (V_bottle)
    V0 = a * t;
    
    % 10. Kastlängd (Range)
    Range = (V0^2 * sin(2 * startvinkel)) / g;
end
