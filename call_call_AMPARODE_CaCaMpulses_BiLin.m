%It calls Call_AMPARODE_bistable_CaCaMpulses and Call_AMPARODE_linear_CaCaMpulses
close all
clear
clc

pathname = fileparts('resultsAutoPrintCaCaM/');


cacam02 = importdata('CaCaM-pulse-2s.txt',',',1);%delimiterIn,headerlinesIn);
cacam02 = cacam02.data;
cacam10 = importdata('CaCaM-pulse-10s.txt',',',1);%delimiterIn,headerlinesIn);
cacam10 = cacam10.data;
cacam20 = importdata('CaCaM-pulse-20s.txt',',',1);%delimiterIn,headerlinesIn);
cacam20 = cacam20.data;

tspan = (0:.1:500);
Cams = zeros(length(tspan),3);
Cams(1:length(cacam02(:,2)),1) = cacam02(:,2);
Cams(1:length(cacam10(:,2)),2) = cacam10(:,2);
Cams(1:length(cacam20(:,2)),3) = cacam20(:,2);


% CaMKII = y(1);  %uM
% CaMKIIp = y(2); %uM
% CaNp = y(3);    %uM
% CaN = y(4);     %uM
% I1p = y(5);    %uM
% I1 = y(6);     %uM
% PP1p = y(7);   %uM
% PP1 = y(8);    %uM
% Aint=y(9);     %uM
% Amem=y(10);      %moles/m2
% scaff=y(11);     %moles/m2
% Abound=y(12);    %moles/m2

Cparts = 20;
Pparts = 0.25;
resultsBi = zeros(length(Cparts),length(Pparts),3,length(tspan),12); %C, P, cacam pulse, species values, species 
resultsLin = zeros(length(Cparts),length(Pparts),3,length(tspan),12); %C, P, cacam pulse, species values, species 
styles = {"-",":","-."};
%bistable
%AMPAR bound
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for i = 1:length(Cparts)
    for j = 1:length(Pparts)
        for c = 1:3
                [t,y] = call_AMPARODE_bistable_CaCaMpulses(Cparts(i), Pparts(j), Cams(:,c)); %CIC, PIC, EnEx, Influx
                resultsBi(i,j,c, :,:) = y;
                plot(t,y(:,12)*(6.022e23*1e-12),styles{c})
                hold on
        end
    end
end

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('#/\mum^2');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
title('AMPAR - Bistable')
legend("2 s","10 s","20 s")
hold off
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'ABound-CaCaMpulses-Bi.png');
saveas(gcf, pngfile);

%CaMKII
toPlotBi = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)

for c = 1:3
    toPlotBi(:) = resultsBi(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(t,toPlotBi,styles{c})
    hold on
end
    

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaMKIIp - Bistable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'CaMKIIp-CaCaMpulses-Bi.png');
saveas(gcf, pngfile);

%PP1
toPlotBi = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)

for c = 1:3
    toPlotBi(:) = resultsBi(1,1,c, :,8); %C, P, cacam pulse, species values, species 
    plot(t,toPlotBi,styles{c})
    hold on
end
    

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('PP1 - Bistable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'PP1-CaCaMpulses-Bi.png');
saveas(gcf, pngfile);

%linear
%AMPAR bound
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for i = 1:length(Cparts)
    for j = 1:length(Pparts)
        for c = 1:3
                [t,y] = call_AMPARODE_linear_CaCaMpulses(Cparts(i), Pparts(j), Cams(:,c)); %CIC, PIC, EnEx, Influx
                resultsLin(i,j,c, :,:) = y;
                plot(t,y(:,12)*(6.022e23*1e-12),styles{c})
                hold on
        end
    end
end

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('#/\mum^2');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('AMPAR - Monostable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'ABound-CaCaMpulses-Lin.png');
saveas(gcf, pngfile);

%CaMKII
toPlotLin = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for c = 1:3
    toPlotLin(:) = resultsLin(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(t,toPlotLin,styles{c})
    hold on
end

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaMKIIp - Monostable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'CaMKIIp-CaCaMpulses-Lin.png');
saveas(gcf, pngfile);

%PP1
toPlotLin = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for c = 1:3
    toPlotLin(:) = resultsLin(1,1,c, :,8); %C, P, cacam pulse, species values, species 
    plot(t,toPlotLin,styles{c})
    hold on
end

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('PP1 - Monostable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'PP1-CaCaMpulses-Lin.png');
saveas(gcf, pngfile);

%%%%%
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
plot(cacam02(:,1),cacam02(:,2))
% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaCaM 2 s')
pngfile = fullfile(pathname, 'CaCaMpulses-2s.png');
saveas(gcf, pngfile);

figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
plot(cacam10(:,1),cacam10(:,2))
% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaCaM 10 s')
pngfile = fullfile(pathname, 'CaCaMpulses-10s.png');
saveas(gcf, pngfile);

figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
plot(cacam20(:,1),cacam20(:,2))
% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaCaM 20 s')
pngfile = fullfile(pathname, 'CaCaMpulses-20s.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%Same but for smaller CaCaM magnitude stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%bistable
%AMPAR bound
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for i = 1:length(Cparts)
    for j = 1:length(Pparts)
        for c = 1:3
                [t,y] = call_AMPARODE_bistable_CaCaMpulses(Cparts(i), Pparts(j), Cams(:,c)./10); %CIC, PIC, EnEx, Influx
                resultsBi(i,j,c, :,:) = y;
                plot(t,y(:,12)*(6.022e23*1e-12),styles{c})
                hold on
        end
    end
end

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('#/\mum^2');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
title('AMPAR - Bistable')
legend("2 s","10 s","20 s")
hold off
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'ABound-CaCaMpulses-smallerStim-Bi.png');
saveas(gcf, pngfile);

%CaMKII
toPlotBi = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)

for c = 1:3
    toPlotBi(:) = resultsBi(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(t,toPlotBi,styles{c})
    hold on
end
    

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaMKIIp - Bistable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'CaMKIIp-CaCaMpulses-smallerStim-Bi.png');
saveas(gcf, pngfile);

%PP1
toPlotBi = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)

for c = 1:3
    toPlotBi(:) = resultsBi(1,1,c, :,8); %C, P, cacam pulse, species values, species 
    plot(t,toPlotBi,styles{c})
    hold on
end
    

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('PP1 - Bistable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'PP1-CaCaMpulses-smallerStim-Bi.png');
saveas(gcf, pngfile);

%linear
%AMPAR bound
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for i = 1:length(Cparts)
    for j = 1:length(Pparts)
        for c = 1:3
                [t,y] = call_AMPARODE_linear_CaCaMpulses(Cparts(i), Pparts(j), Cams(:,c)./10); %CIC, PIC, EnEx, Influx
                resultsLin(i,j,c, :,:) = y;
                plot(t,y(:,12)*(6.022e23*1e-12),styles{c})
                hold on
        end
    end
end

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('#/\mum^2');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('AMPAR - Monostable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'ABound-CaCaMpulses-smallerStim-Lin.png');
saveas(gcf, pngfile);

%CaMKII
toPlotLin = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for c = 1:3
    toPlotLin(:) = resultsLin(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(t,toPlotLin,styles{c})
    hold on
end

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaMKIIp - Monostable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'CaMKIIp-CaCaMpulses-smallerStim-Lin.png');
saveas(gcf, pngfile);

%PP1 linear
toPlotLin = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for c = 1:3
    toPlotLin(:) = resultsLin(1,1,c, :,8); %C, P, cacam pulse, species values, species 
    plot(t,toPlotLin,styles{c})
    hold on
end

% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('PP1 - Monostable')
legend("2 s","10 s","20 s")
hold off
pngfile = fullfile(pathname, 'PP1-CaCaMpulses-smallerStim-Lin.png');
saveas(gcf, pngfile);

%%%%%
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
plot(cacam02(:,1),cacam02(:,2)./10)
% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaCaM 2 s')
pngfile = fullfile(pathname, 'CaCaMpulses-2s-smallerStim.png');
saveas(gcf, pngfile);

figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
plot(cacam10(:,1),cacam10(:,2)./10)
% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaCaM 10 s')
pngfile = fullfile(pathname, 'CaCaMpulses-10s-smallerStim.png');
saveas(gcf, pngfile);

figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
plot(cacam20(:,1),cacam20(:,2)./10)
% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('CaCaM 20 s')
pngfile = fullfile(pathname, 'CaCaMpulses-20s-smallerStim.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Both stimulus on same plot
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
plot(cacam02(:,1),cacam02(:,2))
hold on
plot(cacam02(:,1),cacam02(:,2)./10,":")
hold off
% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 34])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('Ca^{2+}CaM - 2 s')
pngfile = fullfile(pathname, 'CaCaMpulses-2s-bothStim.png');
saveas(gcf, pngfile);

figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
plot(cacam10(:,1),cacam10(:,2))
hold on
plot(cacam10(:,1),cacam10(:,2)./10,":")
hold off
% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 40])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('Ca^{2+}CaM - 10 s')
pngfile = fullfile(pathname, 'CaCaMpulses-10s-bothStim.png');
saveas(gcf, pngfile);

figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
plot(cacam20(:,1),cacam20(:,2))
hold on
plot(cacam20(:,1),cacam20(:,2)./10,":")
hold off
% plot(t,results(:,:,:,:,:,17)*(6.022e23*1e-12))
ylabel('Concentration (\muM)');
xlabel('Time (s)');
xlim([0 80])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('Ca^{2+}CaM - 20 s')
pngfile = fullfile(pathname, 'CaCaMpulses-20s-bothStim.png');
saveas(gcf, pngfile);