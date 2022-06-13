%plot results of ODE AMPAR models - bistable and linear
%Plotting AMPAR SPECIES FOR BOTH LINEAR AND BISTABLE
%%have 2 IC for CaMKII 10 and 20,only P0.25
%%With and without influx
%%varies across both En and ex variations
%%en and ex affect c1 and c2
%%en and ex affect whole term

close all
clear
clc

pathname = fileparts('resultsAutoPrint/');

results = load('resultsLin-paraC1C2.mat');
resultsLin = results.resultsLin;
results = load('resultsLin-paraC1C2-noInflux.mat');
resultsLinNI = results.resultsLin;
results = load('resultsLin-paraEnExWhole.mat');
resultsLinW = results.resultsLin;
results = load('resultsLin-paraEnExWhole-noInflux.mat');
resultsLinWNI = results.resultsLin;


results = load('resultsBi-paraC1C2.mat');
resultsBi = results.resultsBi;
results = load('resultsBi-paraC1C2-noInflux.mat');
resultsBiNI = results.resultsBi;
results = load('resultsBi-paraEnExWhole.mat');
resultsBiW = results.resultsBi;
results = load('resultsBi-paraEnExWhole-noInflux.mat');
resultsBiWNI = results.resultsBi;


% order of results
% results(endo,exo,CIC, time,species)
% results(c1, c2,CIC
%control case is (1,1,3,11,:,species)

Cparts = [10 20];%[0:4:20];
Pparts = 0.25;%[0:0.05:0.5];
c1parts = [0:25:50];%[0:0.1:1];
c2parts = [0:25:50];%[0:0.1:1];
tspan = (0:.01:500);

EnpartsW = [0:0.5:1];
ExpartsW = [0:0.5:1];
tspanW = (0:.01:1000);

names = ["Ca_{cyto}", "CaM", "CaCaM", "Ng", "CaMNg", "CaMKII", .../
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

% figure %CIC, PIC only 1, en, ex, inf
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(1,1,11, 11,1, :,17)*(6.022e23*1e-12); %CIC10, no influx, 500 500
% plot(tspan,toPlot);%, marker(exo), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(endo-1) + exo}, 'Color' , colors{6*(endo-1) + exo})
% toPlot(:) = resultsBi(1,1,11, 11,2, :,17)*(6.022e23*1e-12); %CIC10, w influx, 500 500
% plot(tspan,toPlot);%, marker(exo), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(endo-1) + exo}, 'Color' , colors{6*(endo-1) + exo})
% toPlot(:) = resultsBi(2,1,11, 11,1, :,17)*(6.022e23*1e-12); %CIC20, no influx, 500 500
% plot(tspan,toPlot);%, marker(exo), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(endo-1) + exo}, 'Color' , colors{6*(endo-1) + exo})
% toPlot(:) = resultsBi(2,1,11, 11,2, :,17)*(6.022e23*1e-12); %CIC20, w influx, 500 500
% plot(tspan,toPlot);%, marker(exo), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(endo-1) + exo}, 'Color' , colors{6*(endo-1) + exo})

colors4 = {[0 255 255]/255;  .../ %teal 6
          [0 255 255]/255;   .../ %blue
          [0 153 0]/255;  .../ %green
          [255 0 51]/255;  .../ %red
          [255 51 255]/255;  .../ %pink/purple
          [255 255 51]/255; };   %yellow?
      
colors8 = {[0 255 255]/255;  .../ %blue 
    [153 255 102]/255;  .../ %green
    [255 0 51]/255;  .../ %red
    [255 204 255]/255;.../%purple
    
    [0 51 204]/255;  .../ %blue
    [0 102 0]/255; .../ %green
    [153 0 0]/255; .../ %red
    [153 51 153]/255; };%pink/purple
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%c1 and c2 multiplied
figure %Bistable + Mono, both CIC, no influx
counter = 1;
for c1 = [1 3] %exo
    for c2 = [1 3] %endo
        toPlot = ones(length(tspan),1);
        toPlot(:) = resultsLinNI(c1,c2,1,:,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspan,toPlot,'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=1;
for c1 = [1 3]
    for c2 = [1 3]
        toPlot = ones(length(tspan),1);
        toPlot(:) = resultsLinNI(c1,c2,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspan,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for c1 = [1 3]
    for c2 = [1 3]
        toPlot = ones(length(tspan),1);
        toPlot(:) = resultsBiNI(c1,c2,1, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspan,toPlot, 'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for c1 = [1 3]
    for c2 = [1 3]
        toPlot = ones(length(tspan),1);
        toPlot(:) = resultsBiNI(c1,c2,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspan,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   

title("No Influx")
ylabel('#/\mum^2');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',32,'fontWeight','bold')
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
pngfile = fullfile(pathname, 'Temporal-Abound-varyC1C2-noInflux-CIC-fewerLines-BiLin.png');
saveas(gcf, pngfile);

figure %Bistable + Mono, both CIC, influx
counter = 1;
for c1 = [1 3]
    for c2 = [1 3]
        toPlot = ones(length(tspan),1);
        toPlot(:) = resultsLin(c1,c2,1, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspan,toPlot,'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=1;
for c1 = [1 3]
    for c2 = [1 3]
        toPlot = ones(length(tspan),1);
        toPlot(:) = resultsLin(c1,c2,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspan,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for c1 = [1 3]
    for c2 = [1 3]
        toPlot = ones(length(tspan),1);
        toPlot(:) = resultsBi(c1,c2,1, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspan,toPlot, 'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for c1 = [1 3]
    for c2 = [1 3]
        toPlot = ones(length(tspan),1);
        toPlot(:) = resultsBi(c1,c2,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspan,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   

title("Influx")
ylabel('#/\mum^2');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',32,'fontWeight','bold')
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
pngfile = fullfile(pathname, 'Temporal-Abound-varyC1C2-Influx-CIC-fewerLines-BiLin.png');
saveas(gcf, pngfile);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%WHOLE TERM multiplied
figure %Bistable + Mono, both CIC, no influx
counter = 1;
for exo = [1 3] %exo
    for endo = [1 3] %endo
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsLinWNI(endo,exo,1,:,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot,'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=1;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsLinWNI(endo,exo,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsBiWNI(endo,exo,1, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot, 'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsBiWNI(endo,exo,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   

title("No Influx")
ylabel('#/\mum^2');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',32,'fontWeight','bold')
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
pngfile = fullfile(pathname, 'Temporal-Abound-varyWholeEnEx-noInflux-CIC-fewerLines-BiLin.png');
saveas(gcf, pngfile);

figure %Bistable + Mono, both CIC, WITH influx
counter = 1;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsLinW(endo,exo,1, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot,'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=1;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsLinW(endo,exo,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsBiW(endo,exo,1, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot, 'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsBiW(endo,exo,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   

title("Influx")
ylabel('#/\mum^2');
xlabel('Time (s)');
set(gcf,'pos',[0 0 750 450])
set(findall(gcf,'type','text'),'FontSize',32,'fontWeight','bold')
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
pngfile = fullfile(pathname, 'Temporal-Abound-varyWholeEnEx-Influx-CIC-fewerLines-BiLin.png');
saveas(gcf, pngfile);

% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%FOR LEGEND

figure %Bistable + Mono, both CIC, no influx
counter = 1;
for exo = [1 3] %exo
    for endo = [1 3] %endo
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsLinWNI(endo,exo,1,:,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot,'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=1;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsLinWNI(endo,exo,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsBiWNI(endo,exo,1, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot, 'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
counter=5;
for exo = [1 3]
    for endo = [1 3]
        toPlot = ones(length(tspanW),1);
        toPlot(:) = resultsBiWNI(endo,exo,2, :,12)*(6.022e23*1e-12); %CIC10, no influx, 500 500
        plot(tspanW,toPlot, ":",'Color' , colors8{counter});
        hold on
        counter = counter +1;
    end
end   
legend("Ex 0, En 0 - CIC10 - Mono", "Ex 0, En max - CIC10 - Mono","Ex max, En 0 - CIC10 - Mono", "Ex max, En max - CIC10 - Mono","Ex 0, En 0 - CIC20 - Mono", "Ex 0, En max - CIC20 - Mono","Ex max, En 0 - CIC20 - Mono", "Ex max, En max - CIC20 - Mono",.../
     "Ex 0, En 0 - CIC10 - Bi", "Ex 0, En max - CIC10 - Bi","Ex max, En 0 - CIC10 - Bi", "Ex max, En max - CIC10 - Bi","Ex 0, En 0 - CIC20 - Bi", "Ex 0, En max - CIC20 - Bi","Ex max, En 0 - CIC20 - Bi", "Ex max, En max - CIC20 - Bi") 
title("Legend")
ylabel('#/\mum^2');
xlabel('Time (s)');
set(gcf,'pos',[0 0 1500 900])
set(findall(gcf,'type','text'),'FontSize',32,'fontWeight','bold')
set(0,'defaultAxesFontSize', 32)
set(findall(gca, 'Type', 'Line'),'LineWidth',5)
pngfile = fullfile(pathname, 'Temporal-Abound-allEnExBoth-CIC-fewerLines-BiLin-LEGEND.png');
saveas(gcf, pngfile);
% figure %Bistable + Mono, both CIC, WITH influx
% counter = 1;
% for endo = [1 3]
%     for exo = [1 3]
%         for inf = 2
%             toPlot = ones(length(tspanW),1);
%             toPlot(:) = resultsLinWhole(1,1,endo,exo,inf, :,17)*(6.022e23*1e-12); %CIC10, no influx, 500 500
%             plot(tspanW,toPlot,'Color' , colors8{counter});
%             hold on
%             counter = counter +1;
%         end
%     end
% end   
% counter=1;
% for endo = [1 3]
%     for exo = [1 3]
%         for inf = 2
%             toPlot = ones(length(tspanW),1);
%             toPlot(:) = resultsLinWhole(2,1,endo,exo,inf, :,17)*(6.022e23*1e-12); %CIC10, no influx, 500 500
%             plot(tspanW,toPlot, ":",'Color' , colors8{counter});
%             hold on
%             counter = counter +1;
%         end
%     end
% end   
% counter=5;
% for endo = [1 3]
%     for exo = [1 3]
%         for inf = 2
%             toPlot = ones(length(tspanW),1);
%             toPlot(:) = resultsBiWhole(1,1,endo,exo,inf, :,17)*(6.022e23*1e-12); %CIC10, no influx, 500 500
%             plot(tspanW,toPlot, 'Color' , colors8{counter});
%             hold on
%             counter = counter +1;
%         end
%     end
% end   
% counter=5;
% for endo = [1 3]
%     for exo = [1 3]
%         for inf = 2
%             toPlot = ones(length(tspanW),1);
%             toPlot(:) = resultsBiWhole(2,1,endo,exo,inf, :,17)*(6.022e23*1e-12); %CIC10, no influx, 500 500
%             plot(tspanW,toPlot, ":",'Color' , colors8{counter});
%             hold on
%             counter = counter +1;
%         end
%     end
% end
% legend("En 0, Ex 0 - CIC10 - Mono", "En 0, Ex max - CIC10 - Mono","En max, Ex 0 - CIC10 - Mono", "En max, Ex max - CIC10 - Mono","En 0, Ex 0 - CIC20 - Mono", "En 0, Ex max - CIC20 - Mono","En max, Ex 0 - CIC20 - Mono", "En max, Ex max - CIC20 - Mono",.../
%     "En 0, Ex 0 - CIC10 - Bi", "En 0, Ex max - CIC10 - Bi","En max, Ex 0 - CIC10 - Bi", "En max, Ex max - CIC10 - Bi","En 0, Ex 0 - CIC20 - Bi", "En 0, Ex max - CIC20 - Bi","En max, Ex 0 - CIC20 - Bi", "En max, Ex max - CIC20 - Bi")
% 
% % legend({},"Location","east")
% title("Legend")
% ylabel('#/\mum^2');
% xlabel('Time (s)');
% set(gcf,'pos',[0 0 750 450])
% set(findall(gcf,'type','text'),'FontSize',32,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 32)
% set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% pngfile = fullfile(pathname, 'Temporal-Abound-AllEnExBoth-CIC-fewerLines-legend.png');
% saveas(gcf, pngfile);
% %%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%bar maps for steady state values
% %setting up to save Abound end value SS
% %c1 c2
% ABLinMatrix = zeros(2,3,3,2,1);%Cparts,enparts,exparts,influx,3
% ABBiMatrix = zeros(2,3,3,2,1); %17
% %pulling out Aint max and time of max, and value at 500s
% AiLinMatrix = zeros(2,3,3,2,1);
% AiBiMatrix = zeros(2,3,3,2,1); %14
% %pulling out Amem max, time of max, and value at 500s
% AmLinMatrix = zeros(2,3,3,2,1); %15
% AmBiMatrix = zeros(2,3,3,2,1);
% 
% %results order: cparts 1,PpartIndex 1,enx 11, infl 11
% 
% %for c1 c2 case
% ABBiMatrixSS = [];
% ABLinMatrixSS = [];
% for i = 1:length(Cparts)
%     for j = 1%:length(Pparts)
%         for endo = 1:length(Enparts)
%             for exo = 1:length(Exparts)
%                 for Infl = 1:length(Inflparts)
% 
%                     ABBiMatrix(i,endo,exo,Infl,1) = resultsBi(i,1,endo,exo,Infl, end,17)*(6.022e23*1e-12);
%                     ABLinMatrix(i,endo,exo,Infl,1) = resultsLin(i,1,endo,exo,Infl, end,17)*(6.022e23*1e-12);
% 
%                     AiBiMatrix(i,endo,exo,Infl,1) = resultsBi(i,1,endo,exo,Infl, end,14);
%                     AiLinMatrix(i,endo,exo,Infl,1) = resultsLin(i,1,endo,exo,Infl, end,14);
% 
%                     AmBiMatrix(i,endo,exo,Infl,1) = resultsBi(i,1,endo,exo,Infl, end,15)*(6.022e23*1e-12);
%                     AmLinMatrix(i,endo,exo,Infl,1) = resultsLin(i,1,endo,exo,Infl, end,15)*(6.022e23*1e-12);
%                     
%                     
%                 end
%             end
%         end
%     end
% end
% 
% %whole
% ABLinMatrixW = zeros(2,3,3,2,1);%Cparts,enparts,exparts,influx,3
% ABBiMatrixW = zeros(2,3,3,2,1); %17
% %pulling out Aint max and time of max, and value at 500s
% AiLinMatrixW = zeros(2,3,3,2,1);
% AiBiMatrixW = zeros(2,3,3,2,1); %14
% %pulling out Amem max, time of max, and value at 500s
% AmLinMatrixW = zeros(2,3,3,2,1); %15
% AmBiMatrixW = zeros(2,3,3,2,1);
% 
% %results order: cparts 1,PpartIndex 1,enx 11, infl 11
% 
% %for whole
% ABBiMatrixWSS = [];
% ABLinMatrixWSS = [];
% for i = 1:length(Cparts)
%     for j = 1%:length(Pparts)
%         for endo = 1:length(Enparts)
%             for exo = 1:length(Exparts)
%                 for Infl = 1:length(Inflparts)
%                     ABBiMatrixW(i,endo,exo,Infl,1) = resultsBiWhole(i,1,endo,exo,Infl, end,17)*(6.022e23*1e-12);
%                     ABLinMatrixW(i,endo,exo,Infl,1) = resultsLinWhole(i,1,endo,exo,Infl, end,17)*(6.022e23*1e-12);
% 
%                     AiBiMatrixW(i,endo,exo,Infl,1) = resultsBiWhole(i,1,endo,exo,Infl, end,14);
%                     AiLinMatrixW(i,endo,exo,Infl,1) = resultsLinWhole(i,1,endo,exo,Infl, end,14);
% 
%                     AmBiMatrixW(i,endo,exo,Infl,1) = resultsBiWhole(i,1,endo,exo,Infl, end,15)*(6.022e23*1e-12);
%                     AmLinMatrixW(i,endo,exo,Infl,1) = resultsLinWhole(i,1,endo,exo,Infl, end,15)*(6.022e23*1e-12);
%                    
%                 end
%             end
%         end
%     end
% end
% for i = 1:length(Cparts)
%     for j = 1%:length(Pparts)
%         for endo = [1 3]
%             for exo = [1 3]
%                 for Infl = 1:length(Inflparts)
%                     ABBiMatrixWSS = [ABBiMatrixWSS ABBiMatrixW(i,endo,exo,Infl,1)];
%                     ABLinMatrixWSS = [ABLinMatrixWSS ABLinMatrixW(i,endo,exo,Infl,1)];
%                     ABBiMatrixSS = [ABBiMatrixSS ABBiMatrix(i,endo,exo,Infl,1)];
%                     ABLinMatrixSS = [ABLinMatrixSS ABLinMatrix(i,endo,exo,Infl,1)];
%                 end
%             end
%         end
%     end
% end
% 
% X = categorical({'Bistable','Monostable'});
% X = reordercats(X,{'Bistable','Monostable'});
% Y = [ABBiMatrixSS(1:2:end); ABLinMatrixSS(1:2:end)];
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',32)
% set(0,'defaultAxesFontSize', 32)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% hBar=bar(X,Y,'FaceColor','flat');%[barSumsB; barSumsL])
% x = [1 2];
% for k1 = 1:size(Y,2)
%     hBar(k1).CData = colors8{k1};
% %     ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
% %     ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
% %     text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
% end
% %legend({"No Influx - Min","No Influx - Max","Influx - Min","Influx - Max"},"Location","Southeast")
% title("Abound SS - BiMono c1c2 noI")%title('Integrated Reaction Rate (#/(\mum^2))');
% ylabel('#/(\mum^2)');
% ylim([980 1011])
% set(gcf,'pos',[0 0 750 450])
% pngfile = fullfile(pathname, 'barG-Abound-SS-EnExVarC1C2-bothIC-noInflux-BiLin.png');
% saveas(gcf, pngfile);
% 
% X = categorical({'Bistable','Monostable'});
% X = reordercats(X,{'Bistable','Monostable'});
% Y = [ABBiMatrixSS(2:2:end); ABLinMatrixSS(2:2:end)];
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',32)
% set(0,'defaultAxesFontSize', 32)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% hBar=bar(X,Y,'FaceColor','flat');%[barSumsB; barSumsL])
% x = [1 2];
% for k1 = 1:size(Y,2)
%     hBar(k1).CData = colors8{k1};
% %     ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
% %     ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
% %     text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
% end
% %legend({"No Influx - Min","No Influx - Max","Influx - Min","Influx - Max"},"Location","Southeast")
% title("Abound SS - BiMono c1c2 I")%title('Integrated Reaction Rate (#/(\mum^2))');
% ylabel('#/(\mum^2)')
% ylim([1000 1810])
% set(gcf,'pos',[0 0 750 450])
% pngfile = fullfile(pathname, 'barG-Abound-SS-EnExVarC1C2-bothIC-wInflux-BiLin.png');
% saveas(gcf, pngfile);
% 
% %%%%whole
% X = categorical({'Bistable','Monostable'});
% X = reordercats(X,{'Bistable','Monostable'});
% Y = [ABBiMatrixWSS(1:2:end); ABLinMatrixWSS(1:2:end)];
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',32)
% set(0,'defaultAxesFontSize', 32)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% hBar=bar(X,Y,'FaceColor','flat');%[barSumsB; barSumsL])
% x = [1 2];
% for k1 = 1:size(Y,2)
%     hBar(k1).CData = colors8{k1};
% %     ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
% %     ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
% %     text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
% end
% %legend({"No Influx - Min","No Influx - Max","Influx - Min","Influx - Max"},"Location","Southeast")
% title("Abound SS - BiMono whole noI")%title('Integrated Reaction Rate (#/(\mum^2))');
% ylabel('#/(\mum^2)');
% ylim([980 1011])
% set(gcf,'pos',[0 0 750 450])
% pngfile = fullfile(pathname, 'barG-Abound-SS-EnExVarWhole-bothIC-noInflux-BiLin.png');
% saveas(gcf, pngfile);
% 
% X = categorical({'Bistable','Monostable'});
% X = reordercats(X,{'Bistable','Monostable'});
% Y = [ABBiMatrixWSS(2:2:end); ABLinMatrixWSS(2:2:end)];
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',32)
% set(0,'defaultAxesFontSize', 32)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% hBar=bar(X,Y,'FaceColor','flat');%[barSumsB; barSumsL])
% x = [1 2];
% for k1 = 1:size(Y,2)
%     hBar(k1).CData = colors8{k1};
% %     ctr(k1,:) = bsxfun(@plus, x, hBar(k1).XOffset');    % Note: ?XOffset? Is An Undocumented Feature, This Selects The ?bar? Centres
% %     ydt(k1,:) = hBar(k1).YData;                                     % Individual Bar Heights
% %     text(ctr(k1,:), ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',16, 'Color','k')
% end
% %legend({"No Influx - Min","No Influx - Max","Influx - Min","Influx - Max"},"Location","Southeast")
% title("Abound SS - BiMono Whole I")%title('Integrated Reaction Rate (#/(\mum^2))');
% ylabel('#/(\mum^2)');ylim([980 1810])
% set(gcf,'pos',[0 0 750 450])
% pngfile = fullfile(pathname, 'barG-Abound-SS-EnExVarWhole-bothIC-wInflux-BiLin.png');
% saveas(gcf, pngfile);
