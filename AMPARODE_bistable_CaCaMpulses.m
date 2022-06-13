function dydt= AMPARODE_bistable_CaCaMpulses(t,y,CaCaMinput,tv)

%making compartmental
%units; cytosol will be uM
%units; membrane will be moles/m^2

dydt= zeros(12,1);

CaMKII = y(1);  %uM
CaMKIIp = y(2); %uM
CaNp = y(3);    %uM
CaN = y(4);     %uM
I1p = y(5);    %uM
I1 = y(6);     %uM
PP1p = y(7);   %uM
PP1 = y(8);    %uM

Aint=y(9);     %uM
%%%%=
Amem=y(10);      %moles/m2
%%%%
scaff=y(11);     %moles/m2
Abound=y(12);    %moles/m2

cacam_inter = interp1(tv(:),CaCaMinput(:),t);


nscalePM = (0.67/6.63)*1e-6; %m
uMnPMtoMolesPerM2 = 1e-3;
molesPerM23touM = 1e3;


%%CaMKII
kcat13 = 120; %1/s
kcat23 = 1; %1/s
kcat4 = 15; %1/s
km13 = 4; %uM
km23 = 10; %uM
km4 = 3; %uM
part1camkii = kcat13*(cacam_inter^4)*CaMKII/(km13^4 + cacam_inter^4);
part2camkii = kcat23*CaMKIIp*CaMKII/(km23+CaMKII);
part3camkii = -kcat4*PP1*CaMKIIp/(km4+CaMKIIp);
rcamkiip = part1camkii+part2camkii+part3camkii;
rcamkii = -rcamkiip;

%%phosphatase cascade
%%CaN
kcat5 = 127; %1/s
kcat6 = 0.34; %1/s
km5 = 0.34; %uM
km6 = 127; %uM
part1can = kcat5*(cacam_inter^4)*CaNp/(km5^4 + cacam_inter^4);
part2can = -kcat6*CaMKIIp*CaN/(km6 + CaN);
rcan = part1can+part2can;
rcanp = -rcan;
%%I1
kcat7 = 0.034; %1/s
kcat8 = 0.0688; %1/s
km7 = 4.97; %uM
km8 = 127; %uM
part1i1 = kcat7*(CaN)*I1p/(km7 + I1p);
part2i1 = -kcat8*CaMKIIp*I1/(km8 + I1);
ri1 = part1i1+part2i1;
ri1p = -ri1;
%%PP1
kcat19 = 50; %1/s
kcat29 = 2; %1/s
kcat10 = 0.07166; %1/s
km19 = 80; %uM
km29 = 80; %uM
km10 = 4.97; %uM
part1pp1 = kcat19*I1*PP1p/(km19 + PP1p);
part2pp1 = kcat29*PP1*PP1p/(km29 + PP1p);
part3pp1 = -kcat10*CaMKIIp*PP1/(km10 + PP1);
rpp1 = part1pp1+part2pp1+part3pp1;
rpp1p = -rpp1;

%%Aint
c1 = 1; %1/(s*uM)
c3 = 6; %1/s
c2 = 1; %1/(s*uM)
c4 = 8; %1/s
k21 = CaMKIIp*c1 + c3;
k22 = c2*PP1 + c4;
%rmemForAint = (k21*Aint-k22*Amem*molesPerM23touM/nscalePM); %units uM/s
rmemForAint = -(k21*Aint*uMnPMtoMolesPerM2*nscalePM-k22*Amem)*molesPerM23touM/nscalePM; %units uM/s

rmemForAmem = (k21*Aint*uMnPMtoMolesPerM2*nscalePM-k22*Amem); %moles/m^2 s
%%Amem binds scaff to form Abound
kbind = 20*1.05e9; % 20*1.05e9 m^2/(moles*s)
krelease = 0.1*10;       % 1/s

%base influx
timeBase = 800; %s
tdecayBase = 60; %s
perimeter_base = 0.9069e-6; %m
baseInflux = (perimeter_base/(timeBase))*exp(-t/(tdecayBase)).../
    *(CaMKIIp*uMnPMtoMolesPerM2); %moles/m^2 s

dydt(1) = rcamkii;
dydt(2) = rcamkiip; %uM
dydt(3) = rcanp;    %uM
dydt(4) = rcan;     %uM
dydt(5) = ri1p;    %uM
dydt(6) = ri1;     %uM
dydt(7) = rpp1p;    %uM
dydt(8) = rpp1;     %uM
dydt(9) = rmemForAint; %Aint
dydt(10) = rmemForAmem.../
    -kbind*scaff*Amem + krelease*Abound + baseInflux; %Amem

dydt(11) = -kbind*scaff*Amem + krelease*Abound; %Scaff
dydt(12) = kbind*scaff*Amem - krelease*Abound; %Abound


end
