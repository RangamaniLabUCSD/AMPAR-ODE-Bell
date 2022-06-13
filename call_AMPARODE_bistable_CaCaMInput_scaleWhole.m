function [t,y]= call_AMPARODE_bistable_CaCaMInput_scaleWhole(CIC,En, Ex, CaCaMinput)
%close all
%clear


tspan = (0:.01:500);
%initial conditions
names = ["CaMKII", .../
    "CaMKIIp", "CaNp", "CaN", "I1p", "I1", "PP1p", "PP1", .../
    "Aint", "Amem" ,"scaff", "Abound"];

CaMKII_IC = CIC;  %uM
CaMKIIp_IC = 0; %uM
CaNp_IC = 1;    %uM
CaN_IC = 0;     %uM
I1p_IC = 1.8;    %uM
I1_IC = 0;     %uM
PP1p_IC = 0.25;%0.27;   %uM
PP1_IC = 0;    %uM

Aint_IC = 0.1597;%0.2628;     %uM
%%%%=
Amem_IC = (7.288/(6.022e23))*1e12;      %moles/m2 12
%%%%
scaff_IC = (4000/(6.022e23))*1e12;     %moles/m2
Abound_IC = (1000/(6.022e23))*1e12;    %moles/m2


original_cond = [CaMKII_IC CaMKIIp_IC CaNp_IC CaN_IC I1p_IC I1_IC PP1p_IC PP1_IC.../
    Aint_IC Amem_IC scaff_IC Abound_IC];

CaCaMinput1 = zeros(length(tspan),1);
[t,y] = ode23s(@(t,y) AMPARODE_bistable_CaCaMInput_scaleWhole(t,y,En, Ex, CaCaMinput1,tspan), tspan, original_cond);
sol1 = y;
newIC(:) = [y(end,:)];
[t,y] = ode23s(@(t,y) AMPARODE_bistable_CaCaMInput_scaleWhole(t,y,En, Ex, CaCaMinput,tspan), tspan, newIC);
sol2 = y;

y = [sol1; sol2(2:end,:)];

end


