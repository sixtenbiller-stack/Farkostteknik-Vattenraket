clc; clear all;
%raketMassa = 0.107 kg
%vattenMassa = 0.5 kg (exempel för 0.5 liter)
%cd = 0.89
%vattenDensitet = 998 kg/m^3
%A = (0.01^2)*pi (exempel på r = 1 cm)
%atmTryck = 101300 Pa (14.7 psi motsvarar ca 101,300 Pa)
%flaskTryck = 700000 Pa (7 bar)
%startvinkel = pi/4 (45 grader)

[V0, Range] = starthastighet(0.107, 0.5, 0.89, 998, (0.01^2)*pi, 101300, 700000, pi/4)
