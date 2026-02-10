function V0 = starthastighet(raketMassa,vattenMassa,cd,vattenDensitet,A,atmTryck, flaskTryck,startvinkel,fd)
p = flaskTryck - atmTryck

massFlowRate = A*cd*sqrt(2*vattenDensitet*A*p)

vattenVolym = vattenMassa/1000;

flowVelocity = massFlowRate/(vattenDensitet * A)

Range = ((((massFlowRate * vattenMassa)/raketMassa*vattenDensitet*A)^2)*sin(2*startvinkel))/9.82

V0 = ((vattenDensitet * vattenVolym)/massFlowRate)*(((massFlowRate^2)/vattenDensitet*A)-fd-(raketMassa*9.82)/raketMassa)


end