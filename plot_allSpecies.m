%plot results of ODE AMPAR models - bistable and linear
%Plotting ALL SPECIES FOR BOTH LINEAR AND BISTABLE
%%Only control CaMKII and PP1 variations C20, P0.25
%%Pulling out the control trafficking conditions
close all
clear
clc

pathname = fileparts('resultsAutoPrint/');

results = load('resultsLin-paraC20P05.mat');
resultsLin = results.resultsLin;

results = load('resultsBi-paraC20P05.mat');
resultsBi = results.resultsBi;

results = load('resultsLin-paraC20P05-noInflux.mat');
resultsLinNI = results.resultsLin;

results = load('resultsBi-paraC20P05-noInflux.mat');
resultsBiNI = results.resultsBi;

results = load('resultsLin-paraC20P05-noEnEx.mat');
resultsLinNEE = results.resultsLin;

results = load('resultsBi-paraC20P05-noEnEx.mat');
resultsBiNEE = results.resultsBi;

% order of results
% results(CpartIndex,PpartIndex, time,species)
%control case is (6,6,2,2,:,species)

Cparts = [0:5:20]; 
Pparts = [0:0.25:0.5];
tspan = (0:.01:500);

names = ["CaMKII", .../
    "CaMKIIp", "CaNp", "CaN", "I1p", "I1", "PP1p", "PP1", .../
    "Aint", "Amem" ,"scaff", "Abound"];

% marker = ['+', 'o','^','<','>','x'];
% colors = {[102 255 255]/255; [0 255 255]/255; [102 255 204]/255; [51 255 204]/255; [0 255 204]/255; [0 204 153]/255;  .../ %teal 6
%           [0 255 255]/255; [0 204 255]/255; [0 153 255]/255; [0 102 255]/255; [0 51 255]/255; [0 51 204]/255;  .../ %blue
%           [153 255 102]/255; [102 255 51]/255; [51 255 0]/255; [51 204 51]/255; [0 153 0]/255; [0 102 0]/255;  .../ %green
%           [255 51 51]/255; [255 0 51]/255; [255 0 0]/255; [204 0 0]/255; [153 0 0]/255; [102 0 0]/255;  .../ %red
%           [255 204 255]/255; [255 153 255]/255; [255 102 255]/255; [255 51 255]/255; [204 51 204]/255; [153 51 153]/255;  .../ %pink/purple
%           [255 255 153]/255; [255 255 102]/255; [255 255 51]/255; [255 255 0]/255; [255 204 51]/255; [255 204 0]/255  };   %yellow?
% order is CaMKII 1, then all PP1, then CaMKII 2, then all PP1; 
% so make CaMKII different, and PP1 variations
% colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]; [1 0 0]; [56/255 61/255 150/255]; [0 128/255 128/255]}; %pink, blue, cyan



%CaMKIIp
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(5,2, :,2); % CaMKIIp
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,2, :,2); % CaMKIIp
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('CaMKIIp (\muM)');
xlabel('Time (s)')
title('CaMKIIp')
set(gcf,'pos',[0 0 750 450])
xlim([0 300])
% legend("Bistable","Linear")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-camkiip.png');
saveas(gcf, pngfile);


%CaN
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(5,2, :,4); % CaN
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,2, :,4); % CaN
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('CaN (\muM)');
xlabel('Time (s)')
title('CaN')
set(gcf,'pos',[0 0 750 450])
xlim([0 150])
% legend("Bistable","Linear")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-can.png');
saveas(gcf, pngfile);



%I1
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(5,2, :,6); % I1
plot(tspan,toPlot,'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,2, :,6); % I1
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('I1 (\muM)');
xlabel('Time (s)')
title('I1')
set(gcf,'pos',[0 0 750 450])
xlim([0 500])
% legend("Bistable","Linear")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-i1.png');
saveas(gcf, pngfile);



%PP1
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(5,2, :,8); % PP1
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,2, :,8); % PP1
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('PP1 (\muM)');
xlabel('Time (s)')
title('PP1')
set(gcf,'pos',[0 0 750 450])
xlim([0 500])
% legend("Bistable","Linear")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-pp1.png');
saveas(gcf, pngfile);

%Aint
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(5,2, :,9); % Aint
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,2, :,9); % Aint
plot(tspan,toPlot, '--', 'LineWidth', 6)
ylabel('Aint (\muM)');
xlabel('Time (s)')
title('Aint')
set(gcf,'pos',[0 0 750 450])
xlim([0 500])
legend("Bistable","Monostable")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-aint.png');
saveas(gcf, pngfile);


%Amem
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(5,2, :,10)*(6.022e23*1e-12); % Amem
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,2, :,10)*(6.022e23*1e-12); % Amem
plot(tspan,toPlot,'--','LineWidth', 6)
ylabel('Amem (#/\mum^2)');
xlabel('Time (s)')
title('Amem')
set(gcf,'pos',[0 0 750 450])
xlim([0 500])
% legend("Bistable","Linear")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-amem.png');
saveas(gcf, pngfile);

%PSD95
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(5,2, :,11)*(6.022e23*1e-12); % PSD95
plot(tspan,toPlot,  'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,2, :,11)*(6.022e23*1e-12); % PSD95
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('PSD95 (#/\mum^2)');
xlabel('Time (s)')
title('PSD95')
set(gcf,'pos',[0 0 750 450])
xlim([0 500])
legend({"Bistable","Monostable"},"Location","east")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-scaff.png');
saveas(gcf, pngfile);

%Bound AMPAR
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(5,2, :,12)*(6.022e23*1e-12); % CaM
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,2, :,12)*(6.022e23*1e-12); % CaM
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('Bound AMPAR (#/\mum^2)');
xlabel('Time (s)')
title('Bound AMPAR')
set(gcf,'pos',[0 0 750 450])
xlim([0 500])
% legend("Bistable","Linear")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-BoundAMPAR.png');
saveas(gcf, pngfile);

%%%%%%%%plot input!
cacam = load("cacamStim.mat");
cacam = cacam.cacamTemporal;
time = 0:0.01:500;

figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
plot(time,cacam, 'LineWidth', 6)
ylabel('Ca^{2+}CaM (\muM)');
xlabel('Time (s)')
title('Ca^{2+}CaM')
set(gcf,'pos',[0 0 750 450])
xlim([0 10])
% legend("Bistable","Linear")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-cacamInput.png');
saveas(gcf, pngfile);