%plot results of ODE AMPAR models - bistable and linear
%Plotting AMPAR SPECIES FOR BOTH LINEAR AND BISTABLE
%%have 2 IC for CaMKII 10 and 20,only P0.25
%%different CaCaM inputs - leaky
close all
clear
clc

pathname = fileparts('resultsAutoPrintCaCaM/');

%smaller stimulus
results = load('resultsLin-CaCaMpulses-10uMCIC-smallStim.mat');
resultsLin10 = results.resultsLin;
results = load('resultsLin-CaCaMpulses-smallStim.mat');
resultsLin20 = results.resultsLin;
%smaller stimulus
results = load('resultsBi-CaCaMpulses-10uMCIC-smallStim.mat');
resultsBi10 = results.resultsBi;
results = load('resultsBi-CaCaMpulses-smallStim.mat');
resultsBi20 = results.resultsBi;

%larger stimulus
results = load('resultsLin-CaCaMpulses-10uMCIC-largeStim.mat');
resultsLin10LS = results.resultsLin;
results = load('resultsLin-CaCaMpulses-largeStim.mat');
resultsLin20LS = results.resultsLin;
%larger stimulus
results = load('resultsBi-CaCaMpulses-10uMCIC-largeStim.mat');
resultsBi10LS = results.resultsBi;
results = load('resultsBi-CaCaMpulses-largeStim.mat');
resultsBi20LS = results.resultsBi;

%%C only 1, P only 1, cacam pulse 3, species values, species 

Cparts = [10 20];%[0:4:20];
Pparts = 0.25;%[0:0.05:0.5];
tspan = (0:.1:500);
styles = {"-",":","-."};
colors = {[0.301 0.745 0.933];[0.85 0.325 0.098];[0.466 0.674 0.188];[0 0.447 0.741];[0.635 0.078 0.184];[0.466 0.674 0.188]/2}; %blue, red, green

ABLinMatrix = zeros(2,3,3,3); %for CIC 10 and 20; CaMKII, PP1, Abound; 2/10/20s cacam; peak, peak time, steady state;
ABBiMatrix = zeros(2,3,3,3); %peak, peak time, steady state
ABLinMatrixLS = zeros(2,3,3,3); %for CIC 10 and 20; CaMKII, PP1, Abound; 2/10/20s cacam; peak, peak time, steady state;
ABBiMatrixLS = zeros(2,3,3,3); %peak, peak time, steady state

for pulse = 1:3
    %CaMKIIp 7
    %10
    [ABBiMatrix(1,1,pulse,1), ABBiMatrix(1,1,pulse,2)] = max(resultsBi10(1,1,pulse,:,2));
    ABBiMatrix(1,1,pulse,3) = resultsBi10(1,1,pulse,end,2);
    [ABLinMatrix(1,1,pulse,1), ABLinMatrix(1,1,pulse,2)] = max(resultsLin10(1,1,pulse, :,2));
    ABLinMatrix(1,1,pulse,3) = resultsLin10(1,1,pulse,end,2);
    %20
    [ABBiMatrix(2,1,pulse,1), ABBiMatrix(2,1,pulse,2)] = max(resultsBi20(1,1,pulse,:,2));
    ABBiMatrix(2,1,pulse,3) = resultsBi20(1,1,pulse,end,2);
    [ABLinMatrix(2,1,pulse,1), ABLinMatrix(2,1,pulse,2)] = max(resultsLin20(1,1,pulse, :,2));
    ABLinMatrix(2,1,pulse,3) = resultsLin20(1,1,pulse,end,2);
    %PP1 13
    %10
    [ABBiMatrix(1,2,pulse,1), ABBiMatrix(1,2,pulse,2)] = max(resultsBi10(1,1,pulse,:,8));
    ABBiMatrix(1,2,pulse,3) = resultsBi10(1,1,pulse,end,8);
    [ABLinMatrix(1,2,pulse,1), ABLinMatrix(1,2,pulse,2)] = max(resultsLin10(1,1,pulse, :,8));
    ABLinMatrix(1,2,pulse,3) = resultsLin10(1,1,pulse,end,8);
    %20
    [ABBiMatrix(2,2,pulse,1), ABBiMatrix(2,2,pulse,2)] = max(resultsBi20(1,1,pulse,:,8));
    ABBiMatrix(2,2,pulse,3) = resultsBi20(1,1,pulse,end,8);
    [ABLinMatrix(2,2,pulse,1), ABLinMatrix(2,2,pulse,2)] = max(resultsLin20(1,1,pulse, :,8));
    ABLinMatrix(2,2,pulse,3) = resultsLin20(1,1,pulse,end,8);
    %Abound 17
    %10
    [ABBiMatrix(1,3,pulse,1), ABBiMatrix(1,3,pulse,2)] = max(resultsBi10(1,1,pulse,:,12));
    ABBiMatrix(1,3,pulse,3) = resultsBi10(1,1,pulse,end,12)*(6.022e23*1e-12);
    [ABLinMatrix(1,3,pulse,1), ABLinMatrix(1,3,pulse,2)] = max(resultsLin10(1,1,pulse, :,12));
    ABLinMatrix(1,3,pulse,3) = resultsLin10(1,1,pulse,end,12)*(6.022e23*1e-12);
    %20
    [ABBiMatrix(2,3,pulse,1), ABBiMatrix(2,3,pulse,2)] = max(resultsBi20(1,1,pulse,:,12));
    ABBiMatrix(2,3,pulse,3) = resultsBi20(1,1,pulse,end,12)*(6.022e23*1e-12);
    [ABLinMatrix(2,3,pulse,1), ABLinMatrix(2,3,pulse,2)] = max(resultsLin20(1,1,pulse, :,12));
    ABLinMatrix(2,3,pulse,3) = resultsLin20(1,1,pulse,end,12)*(6.022e23*1e-12);
end

%large stimulus
for pulse = 1:3
%CaMKIIp 7
    %10
    [ABBiMatrixLS(1,1,pulse,1), ABBiMatrixLS(1,1,pulse,2)] = max(resultsBi10LS(1,1,pulse,:,2));
    ABBiMatrixLS(1,1,pulse,3) = resultsBi10LS(1,1,pulse,end,2);
    [ABLinMatrixLS(1,1,pulse,1), ABLinMatrixLS(1,1,pulse,2)] = max(resultsLin10LS(1,1,pulse, :,2));
    ABLinMatrixLS(1,1,pulse,3) = resultsLin10LS(1,1,pulse,end,2);
    %20
    [ABBiMatrixLS(2,1,pulse,1), ABBiMatrixLS(2,1,pulse,2)] = max(resultsBi20LS(1,1,pulse,:,2));
    ABBiMatrixLS(2,1,pulse,3) = resultsBi20LS(1,1,pulse,end,2);
    [ABLinMatrixLS(2,1,pulse,1), ABLinMatrixLS(2,1,pulse,2)] = max(resultsLin20LS(1,1,pulse, :,2));
    ABLinMatrixLS(2,1,pulse,3) = resultsLin20LS(1,1,pulse,end,2);
    %PP1 13
    %10
    [ABBiMatrixLS(1,2,pulse,1), ABBiMatrixLS(1,2,pulse,2)] = max(resultsBi10LS(1,1,pulse,:,8));
    ABBiMatrixLS(1,2,pulse,3) = resultsBi10LS(1,1,pulse,end,8);
    [ABLinMatrixLS(1,2,pulse,1), ABLinMatrixLS(1,2,pulse,2)] = max(resultsLin10LS(1,1,pulse, :,8));
    ABLinMatrixLS(1,2,pulse,3) = resultsLin10LS(1,1,pulse,end,8);
    %20
    [ABBiMatrixLS(2,2,pulse,1), ABBiMatrixLS(2,2,pulse,2)] = max(resultsBi20LS(1,1,pulse,:,8));
    ABBiMatrixLS(2,2,pulse,3) = resultsBi20LS(1,1,pulse,end,8);
    [ABLinMatrixLS(2,2,pulse,1), ABLinMatrixLS(2,2,pulse,2)] = max(resultsLin20LS(1,1,pulse, :,8));
    ABLinMatrixLS(2,2,pulse,3) = resultsLin20LS(1,1,pulse,end,8);
    %Abound 17
    %10
    [ABBiMatrixLS(1,3,pulse,1), ABBiMatrixLS(1,3,pulse,2)] = max(resultsBi10LS(1,1,pulse,:,12));
    ABBiMatrixLS(1,3,pulse,3) = resultsBi10LS(1,1,pulse,end,12)*(6.022e23*1e-12);
    [ABLinMatrixLS(1,3,pulse,1), ABLinMatrixLS(1,3,pulse,2)] = max(resultsLin10LS(1,1,pulse, :,12));
    ABLinMatrixLS(1,3,pulse,3) = resultsLin10LS(1,1,pulse,end,12)*(6.022e23*1e-12);
    %20
    [ABBiMatrixLS(2,3,pulse,1), ABBiMatrixLS(2,3,pulse,2)] = max(resultsBi20LS(1,1,pulse,:,12));
    ABBiMatrixLS(2,3,pulse,3) = resultsBi20LS(1,1,pulse,end,12)*(6.022e23*1e-12);
    [ABLinMatrixLS(2,3,pulse,1), ABLinMatrixLS(2,3,pulse,2)] = max(resultsLin20LS(1,1,pulse, :,12));
    ABLinMatrixLS(2,3,pulse,3) = resultsLin20LS(1,1,pulse,end,12)*(6.022e23*1e-12);
end


barSumsB10 = [ABBiMatrix(1,3,1,3) ABBiMatrix(1,3,2,3) ABBiMatrix(1,3,3,3) ABBiMatrixLS(1,3,1,3) ABBiMatrixLS(1,3,2,3) ABBiMatrixLS(1,3,3,3)]; %all pulses SS, for both CIC10 and CIC20
barSumsB20 = [ABBiMatrix(2,3,1,3) ABBiMatrix(2,3,2,3) ABBiMatrix(2,3,3,3) ABBiMatrixLS(2,3,1,3) ABBiMatrixLS(2,3,2,3) ABBiMatrixLS(2,3,3,3)]; %all pulses SS, for both CIC10 and CIC20
X = categorical({'10 \muM IC','20 \muM IC'});
X = reordercats(X,{'10 \muM IC','20 \muM IC'});
Y = [barSumsB10; barSumsB20];

figure
set(findall(gcf,'type','text'),'FontSize',32)
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
hBar=bar(X,Y);%[barSumsB; barSumsL])
x = [1 2];
for k1 = 1:size(Y,2)
    ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
    ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
    text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
end
legend({"2s - small stimulus","10s - small stimulus","20s - small stimulus","2s - large stimulus","10s - large stimulus","20s - large stimulus"},"Location","Northwest")
title("Abound SS")%title('Integrated Reaction Rate (#/(\mum^2))');
ylabel('#/(\mum^2)');
ylim([1000 1850])
set(gcf,'pos',[0 0 1250 750])
pngfile = fullfile(pathname, 'barG-Abound-SS-CaCaM-bothIC-Bi.png');
saveas(gcf, pngfile);


barSumsL10 = [ABLinMatrix(1,3,1,3) ABLinMatrix(1,3,2,3) ABLinMatrix(1,3,3,3) ABLinMatrixLS(1,3,1,3) ABLinMatrixLS(1,3,2,3) ABLinMatrixLS(1,3,3,3)];
barSumsL20 = [ABLinMatrix(2,3,1,3) ABLinMatrix(2,3,2,3) ABLinMatrix(2,3,3,3) ABLinMatrixLS(2,3,1,3) ABLinMatrixLS(2,3,2,3) ABLinMatrixLS(2,3,3,3)]; %all pulses SS, for both CIC10 and CIC20
X = categorical({'10 \muM IC','20 \muM IC'});
X = reordercats(X,{'10 \muM IC','20 \muM IC'});
Y = [barSumsL10; barSumsL20];

figure
set(findall(gcf,'type','text'),'FontSize',32)
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
hBar=bar(X,Y);%[barSumsB; barSumsL])
x = [1 2];
for k1 = 1:size(Y,2)
    ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
    ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
    text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
end
legend({"2s - small stimulus","10s - small stimulus","20s - small stimulus","2s - large stimulus","10s - large stimulus","20s - large stimulus"},"Location","Northwest")
title("Abound SS")%title('Integrated Reaction Rate (#/(\mum^2))');
ylabel('#/(\mum^2)');
set(gcf,'pos',[0 0 1250 750])
ylim([1000 1525])
pngfile = fullfile(pathname, 'barG-Abound-SS-CaCaM-bothIC-Lin.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%For fig; only monostable
barSumsLSm = [ABLinMatrix(1,3,1,3) ABLinMatrix(1,3,2,3) ABLinMatrix(1,3,3,3) ABLinMatrix(2,3,1,3) ABLinMatrix(2,3,2,3) ABLinMatrix(2,3,3,3)];
barSumsLLa = [ABLinMatrixLS(1,3,1,3) ABLinMatrixLS(1,3,2,3) ABLinMatrixLS(1,3,3,3) ABLinMatrixLS(2,3,1,3) ABLinMatrixLS(2,3,2,3) ABLinMatrixLS(2,3,3,3)]; %all pulses SS, for both CIC10 and CIC20
X = categorical({'Stimulus','10 x Stimulus'});
X = reordercats(X,{'Stimulus','10 x Stimulus'});
Y = [barSumsLSm; barSumsLLa];

figure
set(findall(gcf,'type','text'),'FontSize',32)
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
hBar=bar(X,Y,"FaceColor","flat");%[barSumsB; barSumsL])
x = [1 2];
for k1 = 1:size(Y,2)%%%%%%%%%%%%%%%%%%%%%%%TO PUT HERE%%%%%%%%%%%%%%%%%
    ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
    ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
    text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
    hBar(k1).CData = colors{k1};
end
legend({"0.50 Hz - 10 \muM","0.10 Hz - 10 \muM","0.05 Hz - 10 \muM","0.50 Hz - 20 \muM","0.10 Hz - 20 \muM","0.05 Hz - 20 \muM"},"Location","Northwest")
title("Abound SS")%title('Integrated Reaction Rate (#/(\mum^2))');
ylabel('#/(\mum^2)');
set(gcf,'pos',[0 0 1250 750])
ylim([1000 1525])
pngfile = fullfile(pathname, 'barG-Abound-SS-CaCaM-bothIC-splitbyStim-Lin.png');
saveas(gcf, pngfile);

barSumsLSm = [ABLinMatrix(1,3,1,3) ABLinMatrix(1,3,2,3) ABLinMatrix(1,3,3,3) ABLinMatrix(2,3,1,3) ABLinMatrix(2,3,2,3) ABLinMatrix(2,3,3,3)];
barSumsLLa = [ABLinMatrixLS(1,3,1,3) ABLinMatrixLS(1,3,2,3) ABLinMatrixLS(1,3,3,3) ABLinMatrixLS(2,3,1,3) ABLinMatrixLS(2,3,2,3) ABLinMatrixLS(2,3,3,3)]; %all pulses SS, for both CIC10 and CIC20
X = categorical({'Stimulus','10 x Stimulus'});
X = reordercats(X,{'Stimulus','10 x Stimulus'});
Y = [barSumsLSm; barSumsLLa];

figure
set(findall(gcf,'type','text'),'FontSize',32)
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
hBar=bar(X,Y,"FaceColor","flat");%[barSumsB; barSumsL])
x = [1 2];
for k1 = 1:size(Y,2)%%%%%%%%%%%%%%%%%%%%%%%TO PUT HERE%%%%%%%%%%%%%%%%%
    ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
    ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
    text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
    hBar(k1).CData = colors{k1};
end
legend({"0.50 Hz - 10 \muM","0.10 Hz - 10 \muM","0.05 Hz - 10 \muM","0.50 Hz - 20 \muM","0.10 Hz - 20 \muM","0.05 Hz - 20 \muM"},"Location","Northwest")
title("Abound SS")%title('Integrated Reaction Rate (#/(\mum^2))');
ylabel('#/(\mum^2)');
% xlim([0 1])
ylim([1000 1200])
set(gcf,'pos',[0 0 1250 750])
ylim([1000 1525])
pngfile = fullfile(pathname, 'barG-Abound-SS-CaCaM-bothIC-SmallStim-Lin.png');
saveas(gcf, pngfile);

barSumsLSm = [ABLinMatrix(1,3,1,3) ABLinMatrix(1,3,2,3) ABLinMatrix(1,3,3,3) ABLinMatrix(2,3,1,3) ABLinMatrix(2,3,2,3) ABLinMatrix(2,3,3,3)];
barSumsLLa = [ABLinMatrixLS(1,3,1,3) ABLinMatrixLS(1,3,2,3) ABLinMatrixLS(1,3,3,3) ABLinMatrixLS(2,3,1,3) ABLinMatrixLS(2,3,2,3) ABLinMatrixLS(2,3,3,3)]; %all pulses SS, for both CIC10 and CIC20
X = categorical({'Stimulus','10 x Stimulus'});
X = reordercats(X,{'Stimulus','10 x Stimulus'});
Y = [barSumsLSm; barSumsLLa];

figure
set(findall(gcf,'type','text'),'FontSize',32)
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
hBar=bar(X,Y,"FaceColor","flat");%[barSumsB; barSumsL])
x = [1 2];
for k1 = 1:size(Y,2)%%%%%%%%%%%%%%%%%%%%%%%TO PUT HERE%%%%%%%%%%%%%%%%%
    ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
    ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
    text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
    hBar(k1).CData = colors{k1};
end
legend({"0.50 Hz - 10 \muM","0.10 Hz - 10 \muM","0.05 Hz - 10 \muM","0.50 Hz - 20 \muM","0.10 Hz - 20 \muM","0.05 Hz - 20 \muM"},"Location","Northwest")
title("Abound SS")%title('Integrated Reaction Rate (#/(\mum^2))');
ylabel('#/(\mum^2)');
% xlim([0 1])
ylim([1000 1500])
set(gcf,'pos',[0 0 1000 600])
ylim([1000 1525])
pngfile = fullfile(pathname, 'barG-Abound-SS-CaCaM-bothIC-LargeStim-Lin.png');
saveas(gcf, pngfile);
% % barSumsLSm = [ABLinMatrix(1,3,1,3) ABLinMatrix(1,3,2,3) ABLinMatrix(1,3,3,3) ABLinMatrix(2,3,1,3) ABLinMatrix(2,3,2,3) ABLinMatrix(2,3,3,3)];
% % barSumsLLa = [ABLinMatrixLS(1,3,1,3) ABLinMatrixLS(1,3,2,3) ABLinMatrixLS(1,3,3,3) ABLinMatrixLS(2,3,1,3) ABLinMatrixLS(2,3,2,3) ABLinMatrixLS(2,3,3,3)]; %all pulses SS, for both CIC10 and CIC20
% % % X = categorical({'1 x Stimulus'});
% % % X = reordercats(X,{'1 x Stimulus'});
% % X = 1;
% % Y = barSumsLSm;
% % 
% % figure
% % set(findall(gcf,'type','text'),'FontSize',32)
% % set(0,'defaultAxesFontSize', 32)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % hBar=bar(X,Y.',"FaceColor","flat");%[barSumsB; barSumsL])
% % x = [1];
% % for k1 = 1:size(Y,1)%%%%%%%%%%%%%%%%%%%%%%%TO PUT HERE%%%%%%%%%%%%%%%%%
% %     ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
% %     ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
% %     text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
% %     hBar(k1).CData = colors{k1};
% % end
% % legend({"0.50 Hz - 10 \muM","0.10 Hz - 10 \muM","0.05 Hz - 10 \muM","0.50 Hz - 20 \muM","0.10 Hz - 20 \muM","0.05 Hz - 20 \muM"},"Location","Northwest")
% % title("Abound SS")%title('Integrated Reaction Rate (#/(\mum^2))');
% % ylabel('#/(\mum^2)');
% % set(gcf,'pos',[0 0 1250 750])
% % ylim([1000 1525])
% % pngfile = fullfile(pathname, 'barG-Abound-SS-CaCaM-bothIC-SmallStim-Lin.png');
% % saveas(gcf, pngfile);
% % 
% % barSumsLSm = [ABLinMatrix(1,3,1,3) ABLinMatrix(1,3,2,3) ABLinMatrix(1,3,3,3) ABLinMatrix(2,3,1,3) ABLinMatrix(2,3,2,3) ABLinMatrix(2,3,3,3)];
% % barSumsLLa = [ABLinMatrixLS(1,3,1,3) ABLinMatrixLS(1,3,2,3) ABLinMatrixLS(1,3,3,3) ABLinMatrixLS(2,3,1,3) ABLinMatrixLS(2,3,2,3) ABLinMatrixLS(2,3,3,3)]; %all pulses SS, for both CIC10 and CIC20
% % X = categorical({'10 x Stimulus'});
% % X = reordercats(X,{'10 x Stimulus'});
% % Y = [barSumsLLa];
% % 
% % figure
% % set(findall(gcf,'type','text'),'FontSize',32)
% % set(0,'defaultAxesFontSize', 32)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % hBar=bar(X,Y,"FaceColor","flat");%[barSumsB; barSumsL])
% % x = [1];
% % for k1 = 1:size(Y,1)%%%%%%%%%%%%%%%%%%%%%%%TO PUT HERE%%%%%%%%%%%%%%%%%
% %     ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
% %     ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
% %     text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
% %     hBar(k1).CData = colors{k1};
% % end
% % legend({"0.50 Hz - 10 \muM","0.10 Hz - 10 \muM","0.05 Hz - 10 \muM","0.50 Hz - 20 \muM","0.10 Hz - 20 \muM","0.05 Hz - 20 \muM"},"Location","Northwest")
% % title("Abound SS")%title('Integrated Reaction Rate (#/(\mum^2))');
% % ylabel('#/(\mum^2)');
% % set(gcf,'pos',[0 0 1250 750])
% % ylim([1000 1525])
% % pngfile = fullfile(pathname, 'barG-Abound-SS-CaCaM-bothIC-LargeStim-Lin.png');
% % saveas(gcf, pngfile);


%%%%%Temporal %%%small stim
figure
toPlotLin = ones(length(tspan),1);
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)

for c = 1:3
    toPlotLin = ones(length(tspan),1);
    toPlotLin(:) = resultsLin10(1,1,c, :,12)*(6.022e23*1e-12); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotLin,styles{c},'Color',colors{c})
    hold on
end
for c = 1:3
    toPlotLin = ones(length(tspan),1);
    toPlotLin(:) = resultsLin20(1,1,c, :,12)*(6.022e23*1e-12); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotLin,styles{c},'Color',colors{c+3})
    hold on
end

%legend("0.5 Hz - 10 \muM","0.1 Hz - 10 \muM","0.05 Hz - 10 \muM","0.5 Hz - 20 \muM","0.1 Hz - 20 \muM","0.05 Hz - 20 \muM")
ylabel('#/\mum^2');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('AMPAR - Small - Monostable')
hold off
pngfile = fullfile(pathname, 'ABound-CaCaM-CIC1020-SmallStim-Lin.png');
saveas(gcf, pngfile);

%CaMKII
toPlotLin = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for c = 1:3
    toPlotLin(:) = resultsLin10(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotLin,styles{c},'Color',colors{c})
    hold on
end
for c = 1:3
    toPlotLin(:) = resultsLin20(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotLin,styles{c},'Color',colors{c+3})
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
title('CaMKIIp - Small- Monostable')
legend("0.50 Hz - 10 \muM","0.10 Hz - 10 \muM","0.05 Hz - 10 \muM","0.50 Hz - 20 \muM","0.10 Hz - 20 \muM","0.05 Hz - 20 \muM")
hold off
pngfile = fullfile(pathname, 'CaMKII-CaCaM-CIC1020-SmallStim-Lin.png');
saveas(gcf, pngfile);

%%%%%Temporal %%%Large stim
figure
toPlotLin = ones(length(tspan),1);
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)

for c = 1:3
    toPlotLin(:) = resultsLin10LS(1,1,c, :,12)*(6.022e23*1e-12); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotLin,styles{c},'Color',colors{c})
    hold on
end
for c = 1:3
    toPlotLin(:) = resultsLin20LS(1,1,c, :,12)*(6.022e23*1e-12); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotLin,styles{c},'Color',colors{c+3})
    hold on
end

%legend("0.5 Hz - 10 \muM","0.1 Hz - 10 \muM","0.05 Hz - 10 \muM","0.5 Hz - 20 \muM","0.1 Hz - 20 \muM","0.05 Hz - 20 \muM")
ylabel('#/\mum^2');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('AMPAR - Large - Monostable')
hold off
pngfile = fullfile(pathname, 'ABound-CaCaM-CIC1020-LargeStim-Lin.png');
saveas(gcf, pngfile);

%CaMKII
toPlotLin = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for c = 1:3
    toPlotLin(:) = resultsLin10LS(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotLin,styles{c},'Color',colors{c})
    hold on
end
for c = 1:3
    toPlotLin(:) = resultsLin20LS(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotLin,styles{c},'Color',colors{c+3})
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
title('CaMKIIp - Large- Monostable')
%legend("0.5 Hz - 10 \muM","0.1 Hz - 10 \muM","0.05 Hz - 10 \muM","0.5 Hz - 20 \muM","0.1 Hz - 20 \muM","0.05 Hz - 20 \muM")
hold off
pngfile = fullfile(pathname, 'CaMKII-CaCaM-CIC1020-LargeStim-Lin.png');
saveas(gcf, pngfile);

%%%%%%%%%%%bistable temporal

%%%%%Temporal %%%small+large stim %%%%%Bistable
%%small
figure
toPlotBi = ones(length(tspan),1);
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)

for c = 1:3
    toPlotBi = ones(length(tspan),1);
    toPlotBi(:) = resultsBi10(1,1,c, :,12)*(6.022e23*1e-12); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotBi,styles{c},'Color',colors{c})
    hold on
end
for c = 1:3
    toPlotBi = ones(length(tspan),1);
    toPlotBi(:) = resultsBi20(1,1,c, :,12)*(6.022e23*1e-12); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotBi,styles{c},'Color',colors{c+3})
    hold on
end

%legend("0.5 Hz - 10 \muM","0.1 Hz - 10 \muM","0.05 Hz - 10 \muM","0.5 Hz - 20 \muM","0.1 Hz - 20 \muM","0.05 Hz - 20 \muM")
ylabel('#/\mum^2');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('AMPAR - Small - Bistable')
hold off
pngfile = fullfile(pathname, 'ABound-CaCaM-CIC1020-SmallStim-Bi.png');
saveas(gcf, pngfile);

%CaMKII
toPlotBi = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for c = 1:3
    toPlotBi(:) = resultsBi10(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotBi,styles{c},'Color',colors{c})
    hold on
end
for c = 1:3
    toPlotBi(:) = resultsBi20(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotBi,styles{c},'Color',colors{c+3})
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
title('CaMKIIp - Small- Bistable')
legend("0.50 Hz - 10 \muM","0.10 Hz - 10 \muM","0.05 Hz - 10 \muM","0.50 Hz - 20 \muM","0.10 Hz - 20 \muM","0.05 Hz - 20 \muM")
hold off
pngfile = fullfile(pathname, 'CaMKII-CaCaM-CIC1020-SmallStim-Bi.png');
saveas(gcf, pngfile);

%%%%%Temporal %%%Large stim
figure
toPlotBi = ones(length(tspan),1);
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)

for c = 1:3
    toPlotBi(:) = resultsBi10LS(1,1,c, :,12)*(6.022e23*1e-12); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotBi,styles{c},'Color',colors{c})
    hold on
end
for c = 1:3
    toPlotBi(:) = resultsBi20LS(1,1,c, :,12)*(6.022e23*1e-12); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotBi,styles{c},'Color',colors{c+3})
    hold on
end

%legend("0.5 Hz - 10 \muM","0.1 Hz - 10 \muM","0.05 Hz - 10 \muM","0.5 Hz - 20 \muM","0.1 Hz - 20 \muM","0.05 Hz - 20 \muM")
ylabel('#/\mum^2');
xlabel('Time (s)');
xlim([0 200])
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
title('AMPAR - Large - Bistable')
hold off
pngfile = fullfile(pathname, 'ABound-CaCaM-CIC1020-LargeStim-Bi.png');
saveas(gcf, pngfile);

%CaMKII
toPlotBi = ones(length(tspan),1);
figure
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
for c = 1:3
    toPlotBi(:) = resultsBi10LS(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotBi,styles{c},'Color',colors{c})
    hold on
end
for c = 1:3
    toPlotBi(:) = resultsBi20LS(1,1,c, :,2); %C, P, cacam pulse, species values, species 
    plot(tspan,toPlotBi,styles{c},'Color',colors{c+3})
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
title('CaMKIIp - Large- Bistable')
%legend("0.5 Hz - 10 \muM","0.1 Hz - 10 \muM","0.05 Hz - 10 \muM","0.5 Hz - 20 \muM","0.1 Hz - 20 \muM","0.05 Hz - 20 \muM")
hold off
pngfile = fullfile(pathname, 'CaMKII-CaCaM-CIC1020-LargeStim-Bi.png');
saveas(gcf, pngfile);

%%%%For fig; only monostable
barSumsLSm = [ABBiMatrix(1,3,1,3) ABBiMatrix(1,3,2,3) ABBiMatrix(1,3,3,3) ABBiMatrix(2,3,1,3) ABBiMatrix(2,3,2,3) ABBiMatrix(2,3,3,3)];
barSumsLLa = [ABBiMatrixLS(1,3,1,3) ABBiMatrixLS(1,3,2,3) ABBiMatrixLS(1,3,3,3) ABBiMatrixLS(2,3,1,3) ABBiMatrixLS(2,3,2,3) ABBiMatrixLS(2,3,3,3)]; %all pulses SS, for both CIC10 and CIC20
X = categorical({'Stimulus','10 x Stimulus'});
X = reordercats(X,{'Stimulus','10 x Stimulus'});
Y = [barSumsLSm; barSumsLLa];

figure
set(findall(gcf,'type','text'),'FontSize',32)
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
hBar=bar(X,Y,"FaceColor","flat");%[barSumsB; barSumsL])
x = [1 2];
for k1 = 1:size(Y,2)%%%%%%%%%%%%%%%%%%%%%%%TO PUT HERE%%%%%%%%%%%%%%%%%
    ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
    ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
    text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
    hBar(k1).CData = colors{k1};
end
legend({"0.50 Hz - 10 \muM","0.10 Hz - 10 \muM","0.05 Hz - 10 \muM","0.50 Hz - 20 \muM","0.10 Hz - 20 \muM","0.05 Hz - 20 \muM"},"Location","Northwest")
title("Abound SS")%title('Integrated Reaction Rate (#/(\mum^2))');
ylabel('#/(\mum^2)');
set(gcf,'pos',[0 0 1250 750])
ylim([1000 1900])
pngfile = fullfile(pathname, 'barG-Abound-SS-CaCaM-bothIC-splitbyStim-Bi.png');
saveas(gcf, pngfile);