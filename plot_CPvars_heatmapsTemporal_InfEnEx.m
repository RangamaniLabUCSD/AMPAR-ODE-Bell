%plot results of ODE AMPAR models - bistable and linear
%camkii and ppi variations with both endoexo and influx
%%plot heatmaps!!! plot AB for 
%for camkii and pp1 ic

close all
clear
clc

pathname = fileparts('resultsAutoPrint/');
results = load('resultsLin-paraC20P05InfEnEx.mat');
resultsLin = results.resultsLin;

results = load('resultsBi-paraC20P05InfEnEx.mat');
resultsBi = results.resultsBi;

Cparts = [0:5:20]; %5 parts
Pparts = [0:0.1:0.5]; %6 parts
EnExparts = [0 1];
Influxparts = [0 1];
tspan = (0:.01:500);

names = ["CaMKII", .../
    "CaMKIIp", "CaNp", "CaN", "I1p", "I1", "PP1p", "PP1", .../
    "Aint", "Amem" ,"scaff", "Abound"];

marker = ['+', 'o','^','<','>','x'];
colors = {[102 255 255]/255; [0 255 255]/255; [102 255 204]/255; [51 255 204]/255; [0 255 204]/255; [0 204 153]/255;  .../ %teal 6
          [0 255 255]/255; [0 204 255]/255; [0 153 255]/255; [0 102 255]/255; [0 51 255]/255; [0 51 204]/255;  .../ %blue
          [153 255 102]/255; [102 255 51]/255; [51 255 0]/255; [51 204 51]/255; [0 153 0]/255; [0 102 0]/255;  .../ %green
          [255 51 51]/255; [255 0 51]/255; [255 0 0]/255; [204 0 0]/255; [153 0 0]/255; [102 0 0]/255;  .../ %red
          [255 204 255]/255; [255 153 255]/255; [255 102 255]/255; [255 51 255]/255; [204 51 204]/255; [153 51 153]/255;  .../ %pink/purple
          [255 255 153]/255; [255 255 102]/255; [255 255 51]/255; [255 255 0]/255; [255 204 51]/255; [255 204 0]/255  };   %yellow?
% order is CaMKII 1, then all PP1, then CaMKII 2, then all PP1; 
% so make CaMKII different, and PP1 variations
% colors = {[1 0 0.75]; [0 0 1]; [0 1 0.85]; [1 0 0]; [56/255 61/255 150/255]; [0 128/255 128/255]}; %pink, blue, cyan

%setting up to save Abound 1- both, 2 - no inf, 3 - no enex
ABLinMatrix = zeros(5,6,3);
ABBiMatrix = zeros(5,6,3);


%results order: cparts,PpartIndex,influx, enex
%Abound 1- both, 2 - no inf, 3 - no enex
for c = 1:5
    for p = 1:6
        ABLinMatrix(c,p,1) = resultsLin(6-c,p,2, 2, 50001,12)*(6.022e23*1e-12);
        ABLinMatrix(c,p,2) = resultsLin(6-c,p,1, 2, 50001,12)*(6.022e23*1e-12);
        ABLinMatrix(c,p,3) = resultsLin(6-c,p,2, 1, 50001,12)*(6.022e23*1e-12);
        
        ABBiMatrix(c,p,1) = resultsBi(6-c,p,2, 2, 50001,12)*(6.022e23*1e-12);
        ABBiMatrix(c,p,2) = resultsBi(6-c,p,1, 2, 50001,12)*(6.022e23*1e-12);
        ABBiMatrix(c,p,3) = resultsBi(6-c,p,2, 1, 50001,12)*(6.022e23*1e-12);
    end
end


%%%%%%%HEATMAPS for AB no if, no enex for CP  vars
%Abound 1- both, 2 - no inf, 3 - no enex
MyMap = brewermap(100, 'RdPu');

figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
data = ABLinMatrix(:,:,2);
[X,Y] = meshgrid(1:6, 1:5);
[X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
outData = interp2(X, Y, data, X2, Y2, 'linear');
clim = [1000 1001];
colormap(MyMap);
imagesc(data,clim);
colorbar;
% xticks([1,21,41,61,81,101])
% yticks([1, 11,21, 31,41,51])
% xticks([1,21,41,61,81,101])
% yticks([1, 11,21, 31,41,51])
% title('AB L')%title('Bound AMPAR Steady State - Linear')
xlabel('PP1 IC (\muM)')
ylabel('CaMKII IC (\muM)');
h = colorbar;
h.Title.String = '#/\mum^2'; %ylabel(h, '#/\mum^2')
%annotation('textarrow',[1,1],[0.5,0.5],'string','#/\mum^2', ...
%      'HeadStyle','none','LineStyle','none','HorizontalAlignment','center','TextRotation',270);
set(gcf,'pos',[0 0 750 450])
%set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
set(gca,'YTickLabel',{'20','15','10', '5','0'});
set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
%set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'ABound-heatmap-SS-CPvars-noInf-Lin.png');
saveas(gcf, pngfile);

figure%no enex
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
data = ABLinMatrix(:,:,3);
[X,Y] = meshgrid(1:6, 1:5);
[X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
outData = interp2(X, Y, data, X2, Y2, 'linear');
colormap(MyMap);
imagesc(data);
colorbar;
% xticks([1,21,41,61,81,101])
% yticks([1, 11,21, 31,41,51])
% xticks([1,21,41,61,81,101])
% yticks([1, 11,21, 31,41,51])
% title('AB L')%title('Bound AMPAR Steady State - Linear')
xlabel('PP1 IC (\muM)')
ylabel('CaMKII IC (\muM)');
h = colorbar;
h.Title.String = '#/\mum^2'; %ylabel(h, '#/\mum^2')
%annotation('textarrow',[1,1],[0.5,0.5],'string','#/\mum^2', ...
%      'HeadStyle','none','LineStyle','none','HorizontalAlignment','center','TextRotation',270);
set(gcf,'pos',[0 0 750 450])
%set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
set(gca,'YTickLabel',{'20','15','10', '5','0'});
set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
%set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'ABound-heatmap-SS-CPvars-noEnEx-Lin.png');
saveas(gcf, pngfile);

%%%%%bistable
%%no influx
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
data = ABBiMatrix(:,:,2);
[X,Y] = meshgrid(1:6, 1:5);
[X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
outData = interp2(X, Y, data, X2, Y2, 'linear');
colormap(MyMap);
imagesc(data);
colorbar;
% xticks([1,21,41,61,81,101])
% yticks([1, 11,21, 31,41,51])
% xticks([1,21,41,61,81,101])
% yticks([1, 11,21, 31,41,51])
% title('AB L')%title('Bound AMPAR Steady State - Linear')
xlabel('PP1 IC (\muM)')
ylabel('CaMKII IC (\muM)');
h = colorbar;
h.Title.String = '#/\mum^2'; %ylabel(h, '#/\mum^2')
%annotation('textarrow',[1,1],[0.5,0.5],'string','#/\mum^2', ...
%      'HeadStyle','none','LineStyle','none','HorizontalAlignment','center','TextRotation',270);
set(gcf,'pos',[0 0 750 450])
%set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
set(gca,'YTickLabel',{'20','15','10', '5','0'});
set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
%set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'ABound-heatmap-SS-CPvars-noInf-Bi.png');
saveas(gcf, pngfile);

figure%no enex
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
data = ABBiMatrix(:,:,3);
[X,Y] = meshgrid(1:6, 1:5);
[X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
outData = interp2(X, Y, data, X2, Y2, 'linear');
colormap(MyMap);
imagesc(data);
colorbar;
% xticks([1,21,41,61,81,101])
% yticks([1, 11,21, 31,41,51])
% xticks([1,21,41,61,81,101])
% yticks([1, 11,21, 31,41,51])
% title('AB L')%title('Bound AMPAR Steady State - Linear')
xlabel('PP1 IC (\muM)')
ylabel('CaMKII IC (\muM)');
h = colorbar;
h.Title.String = '#/\mum^2'; %ylabel(h, '#/\mum^2')
%annotation('textarrow',[1,1],[0.5,0.5],'string','#/\mum^2', ...
%      'HeadStyle','none','LineStyle','none','HorizontalAlignment','center','TextRotation',270);
set(gcf,'pos',[0 0 750 450])
%set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
set(gca,'YTickLabel',{'20','15','10', '5','0'});
set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
%set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'ABound-heatmap-SS-CPvars-noEnEx-Bi.png');
saveas(gcf, pngfile);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Temporal CaMKII and PP1 for variety of IC
% % Cparts = [0:5:20]; 5 of these
% % Pparts = [0:0.1:0.5];% g of these 
% %order cparts,PpartIndex,infl, enex
% 

%Abound 1- both, 2 - no inf, 3 - no enex
%ab bistable no inf
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,3,1, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,6,1, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot(:) = resultsBi(5,3,1, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
toPlot(:) = resultsBi(5,6,1, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('Bound AMPAR (#/\mum^2)');
xlabel('Time (s)')
title('Bound AMPAR')
set(gcf,'pos',[0 0 750 450])
xlim([0 300])
legend({"C 10; P 0.2","C 10; P 0.5","C 20; P 0.2","C 20; P 0.5"},"Location","east")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-abound-varyCvaryP-bi-noInf.png');
saveas(gcf, pngfile);

%ab bistable no inf
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,3,2, 1, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,6,2, 1, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot(:) = resultsBi(5,3,2, 1, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
toPlot(:) = resultsBi(5,6,2, 1, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('Bound AMPAR (#/\mum^2)');
xlabel('Time (s)')
title('Bound AMPAR')
set(gcf,'pos',[0 0 750 450])
xlim([0 300])
% legend({"C 10; P 0.2","C 10; P 0.5","C 20; P 0.2","C 20; P 0.5"},"Location","east")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-abound-varyCvaryP-bi-noEnEx.png');
saveas(gcf, pngfile);


%ab Mono no inf
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,3,1, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,6,1, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,3,1, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,6,1, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('Bound AMPAR (#/\mum^2)');
xlabel('Time (s)')
title('Bound AMPAR')
set(gcf,'pos',[0 0 750 450])
xlim([0 300])
legend({"C 10; P 0.2","C 10; P 0.5","C 20; P 0.2","C 20; P 0.5"},"Location","east")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-abound-varyCvaryP-lin-noInf.png');
saveas(gcf, pngfile);

%mono no enex
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,3,2, 1, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,6,2, 1, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,3,2, 1, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,6,2, 1, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('Bound AMPAR (#/\mum^2)');
xlabel('Time (s)')
title('Bound AMPAR')
set(gcf,'pos',[0 0 750 450])
xlim([0 300])
% legend({"C 10; P 0.2","C 10; P 0.5","C 20; P 0.2","C 20; P 0.5"},"Location","east")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-abound-varyCvaryP-lin-noEnEx.png');
saveas(gcf, pngfile);