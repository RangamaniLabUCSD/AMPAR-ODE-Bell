%plot results of ODE AMPAR models - bistable and linear
%camkii and ppi variations with both endoexo and influx
%%plot heatmaps!!! CONTROL CASE for C, P, and AB
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

%setting up to save Abound max and time of max, and value at 500s
ABLinMatrix = zeros(5,6,3);
ABBiMatrix = zeros(5,6,3);
%pulling out CaMKIIp max and time of max, and value at 500s
CLinMatrix = zeros(5,6,3);
CBiMatrix = zeros(5,6,3);
%pulling out PP1 max, time of max, and value at 500s
PLinMatrix = zeros(5,6,3);
PBiMatrix = zeros(5,6,3);

%results order: cparts,PpartIndex,influx, enex

for c = 1:5
    for p = 1:6
        ABLinMatrix(c,p,3) = resultsLin(6-c,p,2, 2, 50001,12)*(6.022e23*1e-12);
        [ABBiMatrix(c,p,1), ABBiMatrix(c,p,2)] = max(resultsBi(6-c,p,2, 2, :,12));
        ABBiMatrix(c,p,3) = resultsBi(6-c,p,2, 2, 50001,12)*(6.022e23*1e-12);
        [ABLinMatrix(c,p,1), ABLinMatrix(c,p,2)] = max(resultsLin(6-c,p,2, 2, :,12));
        
        [CLinMatrix(c,p,1), CLinMatrix(c,p,2)] = max(resultsLin(6-c,p,2, 2, :,2));
        CLinMatrix(c,p,3) = resultsLin(6-c,p,2, 2, 50001, 2);
        if CLinMatrix(c,p,3) < 1e-3
            CLinMatrix(c,p,3) = 0;
        end
        [CBiMatrix(c,p,1), CBiMatrix(c,p,2)] = max(resultsBi(6-c,p,2, 2, :,2));
        CBiMatrix(c,p,3) = resultsBi(6-c,p,2, 2, 50001, 2);
        if CBiMatrix(c,p,3) < 1e-3
            CBiMatrix(c,p,3) = 0;
        end
        [PLinMatrix(c,p,1), PLinMatrix(c,p,2)] = max(resultsLin(6-c,p,2, 2, :,8));
        PLinMatrix(c,p,3) = resultsLin(6-c,p,2, 2, 50001, 8);
        if PLinMatrix(c,p,3) < 1e-3
            PLinMatrix(c,p,3) = 0;
        end
        [PBiMatrix(c,p,1), PBiMatrix(c,p,2)] = max(resultsBi(6-c,p,2, 2, :,8));
        PBiMatrix(c,p,3) = resultsBi(6-c,p,2, 2, 50001, 8);
        if PBiMatrix(c,p,3) < 1e-3
            PBiMatrix(c,p,3) = 0;
        end
    end
end
CLinMatrix(5,:,1) = zeros(6,1); %set peak of C IC of 0 to 0
PLinMatrix(:,1,1) = zeros(5,1); %set peak of P IC of 0 to 0

CLinMatrix(5,:,2) = zeros(6,1); %set peak times of C IC of 0 to 0
PLinMatrix(:,1,2) = zeros(5,1); %set peka times of P IC of 0 to 0

%%%%%%%HEATMAPS for C, P, and AB for CP  vars
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%Plotting SS values for A Bound%%%%%%%
% figure
% imagesc(ABLinMatrix)
% colorbar;
% %set(gca, 'CLim', [9.5137, 46.4504]);
% colormap(MyMap); %daspect([1 1 1]);%daspect([1 2 1]);
% set(findall(gcf,'type','text'),'FontSize',24,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 24)
% set(findall(gca, 'Type', 'Line'),'LineWidth',2)
% title('Bound AMPAR Steady State - Linear')
% xlabel('PP1 IC (\muM)')
% ylabel('CaMKII IC (\muM)');
% set(gcf,'pos',[0 0 750 450])
% %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% set(gca,'YTickLabel',{'20','16','12', '8', '4','0'});
% set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% set(findall(gcf,'type','text'),'FontSize',24,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 24)
% set(findall(gca, 'Type', 'Line'),'LineWidth',2)

%replaced meshgrid(1:0.01:size(data,2), 1:0.01:size(data,1))
%replaced xticks([1,201,401,601,801,1001])
%yticks([1, 101,201, 301,401,501])
%set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold'); got rid
%of bold

MyMap = brewermap(100, 'RdPu');

figure
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
pngfile = fullfile(pathname, 'ABound-heatmap-smooth-CPvars-Lin.png');
saveas(gcf, pngfile);

figure
data = ABBiMatrix(:,:,3);
[X,Y] = meshgrid(1:6, 1:5);
[X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
outData = interp2(X, Y, data, X2, Y2, 'linear');
colormap(MyMap);
imagesc(data);
colorbar;
%xticks([1,21,41,61,81,101])
%yticks([1, 11,21, 31,41,51])
% title('AB B')%title('Bound AMPAR Steady State - Bistable')
xlabel('PP1 IC (\muM)')
ylabel('CaMKII IC (\muM)');
h = colorbar;
h.Title.String = '#/\mum^2'; %ylabel(h, '#/\mum^2')
set(gcf,'pos',[0 0 750 450])
%set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
set(gca,'YTickLabel',{'20','15','10', '5','0'});
set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% set(gca,'YTickLabel',{'20','15','10', '5','0'});
% set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'ABound-heatmap-smooth-CPvars-Bi.png');
saveas(gcf, pngfile);

% % % figure
% % % data = ABLinMatrix(:,:,1)*(6.022e23*1e-12);
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVAB L')%title('Max Value Activated CaMKII - Linear')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = '#/\mum^2'; %ylabel(h, '#/\mum^2')
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'Abound-MaxValue-heatmap-smooth-CPvars-Lin.png');
% % % saveas(gcf, pngfile);
% % % 
% % % figure
% % % data = ABBiMatrix(:,:,1)*(6.022e23*1e-12);
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVAB B')%title('Max Value Activated CaMKII - Bistable')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = '#/\mum^2'; %ylabel(h, '#/\mum^2')
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'Abound-MaxValue-heatmap-smooth-CPvars-Bi.png');
% % % saveas(gcf, pngfile);
% % % 
% % % figure
% % % data = tspan(ABLinMatrix(:,:,2));
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVTAB L')%title('Max Value Time Activated CaMKII - Linear')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = 's';
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'Abound-MaxValueTime-heatmap-smooth-CPvars-Lin.png');
% % % saveas(gcf, pngfile);
% % % 
% % % figure
% % % data = tspan(ABBiMatrix(:,:,2));
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVTAB B')%title('Max Value Time Activated CaMKII - Bistable')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % set(gcf,'pos',[0 0 750 450])
% % % h = colorbar;
% % % h.Title.String = 's'; %ylabel(h, '#/\mum^2')
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'Abound-MaxValueTime-heatmap-smooth-CPvars-Bi.png');
% % % saveas(gcf, pngfile);
% % % 
% % % 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%%Plotting max, max time, SS value for C and P%%%%
% % % 
% % % figure
% % % data = CLinMatrix(:,:,1);
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVC L')%title('Max Value Activated CaMKII - Linear')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = '\muM'; %ylabel(h, '#/\mum^2')
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'CaMKIIp-MaxValue-heatmap-smooth-CPvars-Lin.png');
% % % saveas(gcf, pngfile);
% % % 
% % % figure
% % % data = CBiMatrix(:,:,1);
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVC B')%title('Max Value Activated CaMKII - Bistable')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = '\muM'; %ylabel(h, '#/\mum^2')
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'CaMKIIp-MaxValue-heatmap-smooth-CPvars-Bi.png');
% % % saveas(gcf, pngfile);
% % % 
% % % figure
% % % data = tspan(CLinMatrix(:,:,2)+1);
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVTC L')%title('Max Value Time Activated CaMKII - Linear')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = 's';
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'CaMKIIp-MaxValueTime-heatmap-smooth-CPvars-Lin.png');
% % % saveas(gcf, pngfile);
% % % 
% % % figure
% % % data = tspan(CBiMatrix(:,:,2));
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVTC B')%title('Max Value Time Activated CaMKII - Bistable')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % set(gcf,'pos',[0 0 750 450])
% % % h = colorbar;
% % % h.Title.String = 's'; %ylabel(h, '#/\mum^2')
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'CaMKIIp-MaxValueTime-heatmap-smooth-CPvars-Bi.png');
% % % saveas(gcf, pngfile);
% % % 
figure
data = CLinMatrix(:,:,3);
[X,Y] = meshgrid(1:6, 1:5);
[X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
outData = interp2(X, Y, data, X2, Y2, 'linear');
colormap(MyMap);
clims = [0 1];
imagesc(data,clims);
colorbar;
%xticks([1,21,41,61,81,101])
%yticks([1, 11,21, 31,41,51])
% title('SSC L')%title('Steady State Activated CaMKII - Linear')
xlabel('PP1 IC (\muM)')
ylabel('CaMKII IC (\muM)');
h = colorbar;
h.Title.String = '\muM'; %ylabel(h, '#/\mum^2')
% set(h, 'ylim', [0 1])
set(gcf,'pos',[0 0 750 450])
%set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
set(gca,'YTickLabel',{'20','15','10', '5','0'});
set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
%set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'CaMKIIp-SS-heatmap-smooth-CPvars-Lin.png');
saveas(gcf, pngfile);

figure
data = CBiMatrix(:,:,3);
[X,Y] = meshgrid(1:6, 1:5);
[X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
outData = interp2(X, Y, data, X2, Y2, 'linear');
colormap(MyMap);
imagesc(data);
colorbar;
%xticks([1,21,41,61,81,101])
%yticks([1, 11,21, 31,41,51])
% title('SSC B')%title('Steady State Activated CaMKII - Bistable')
xlabel('PP1 IC (\muM)')
ylabel('CaMKII IC (\muM)');
h = colorbar;
h.Title.String = '\muM'; %ylabel(h, '#/\mum^2')
set(gcf,'pos',[0 0 750 450])
%set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
set(gca,'YTickLabel',{'20','15','10', '5','0'});
set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
%set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'CaMKIIp-SS-heatmap-smooth-CPvars-Bi.png');
saveas(gcf, pngfile);
% % % 
% % % %%PP1
% % % figure
% % % data = PLinMatrix(:,:,1);
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVP L')%title('Max Value Activated PP1 - Linear')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = '\muM'; %ylabel(h, '#/\mum^2')
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'PP1-MaxValue-heatmap-smooth-CPvars-Lin.png');
% % % saveas(gcf, pngfile);
% % % 
% % % figure
% % % data = PBiMatrix(:,:,1);
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVP B')%title('Max Value Activated PP1 - Bistable')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = '\muM'; %ylabel(h, '#/\mum^2')
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'PP1-MaxValue-heatmap-smooth-CPvars-Bi.png');
% % % saveas(gcf, pngfile);
% % % 
% % % figure
% % % data = tspan(PLinMatrix(:,:,2)+1);
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVTP L')%title('Max Value Time Activated PP1 - Linear')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = 's'; %ylabel(h, '#/\mum^2')
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'PP1-MaxValueTime-heatmap-smooth-CPvars-Lin.png');
% % % saveas(gcf, pngfile);
% % % 
% % % figure
% % % data = tspan(PBiMatrix(:,:,2));
% % % [X,Y] = meshgrid(1:6, 1:5);
% % % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % % colormap(MyMap);
% % % imagesc(data);
% % % colorbar;
% % % %xticks([1,21,41,61,81,101])
% % % %yticks([1, 11,21, 31,41,51])
% % % title('MVTP B')%title('Max Value Time Activated PP1 - Bistable')
% % % xlabel('PP1 IC (\muM)')
% % % ylabel('CaMKII IC (\muM)');
% % % h = colorbar;
% % % h.Title.String = 's'; %ylabel(h, '#/\mum^2')
% % % set(gcf,'pos',[0 0 750 450])
% % % %set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
% % % set(gca,'YTickLabel',{'20','15','10', '5','0'});
% % % set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
% % % %set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
% % % set(findall(gcf,'type','text'),'FontSize',28)
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',6)
% % % pngfile = fullfile(pathname, 'PP1-MaxValueTime-heatmap-smooth-CPvars-Bi.png');
% % % saveas(gcf, pngfile);
% % % 
figure
data = PLinMatrix(:,:,3);
[X,Y] = meshgrid(1:6, 1:5);
[X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
outData = interp2(X, Y, data, X2, Y2, 'linear');
colormap(MyMap);
clims = [0 1];
imagesc(data,clims);
colorbar;
%xticks([1,21,41,61,81,101])
%yticks([1, 11,21, 31,41,51])
% title('SSP L')%title('Steady State Activated PP1 - Linear')
xlabel('PP1 IC (\muM)')
ylabel('CaMKII IC (\muM)');
h = colorbar;
h.Title.String = '\muM'; %ylabel(h, '#/\mum^2')
% set(h, 'ylim', [0 1])
set(gcf,'pos',[0 0 750 450])
%set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
set(gca,'YTickLabel',{'20','15','10', '5','0'});
set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
%set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'PP1-SS-heatmap-smooth-CPvars-Lin.png');
saveas(gcf, pngfile);

figure
data = PBiMatrix(:,:,3);
[X,Y] = meshgrid(1:6, 1:5);
[X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
outData = interp2(X, Y, data, X2, Y2, 'linear');
colormap(MyMap);
imagesc(data);
colorbar;
%xticks([1,21,41,61,81,101])
%yticks([1, 11,21, 31,41,51])
% title('SSP B')%title('Steady State Activated PP1 - Bistable')
xlabel('PP1 IC (\muM)')
ylabel('CaMKII IC (\muM)');
h = colorbar;
h.Title.String = '\muM'; %ylabel(h, '#/\mum^2')
set(gcf,'pos',[0 0 750 450])
%set(gca,'YTickLabel',{'0','4','8', '12', '16','20'});
set(gca,'YTickLabel',{'20','15','10', '5','0'});
set(gca,'xTickLabel',{ '0', '0.1', '0.2','0.3','0.4','0.5'});
%set(gca,'xTickLabel',{ '0', '0.05', '0.1','0.15', '0.2','0.25', '0.3','0.35', '0.4','0.45','0.5'});
set(findall(gcf,'type','text'),'FontSize',28)
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',6)
pngfile = fullfile(pathname, 'PP1-SS-heatmap-smooth-CPvars-Bi.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Temporal CaMKII and PP1 for variety of IC
% % Cparts = [0:5:20]; 5 of these
% % Pparts = [0:0.1:0.5];% g of these 
% %order cparts,PpartIndex,infl, enex
% 
%CaMKIIp Bi
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,3,2, 2, :,2); % CaMKIIp
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,6,2, 2, :,2); % CaMKIIp
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot(:) = resultsBi(5,3,2, 2, :,2); % CaMKIIp
plot(tspan,toPlot, 'LineWidth', 6)
toPlot(:) = resultsBi(5,6,2, 2, :,2); % CaMKIIp
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('CaMKIIp (\muM)');
xlabel('Time (s)')
title('CaMKIIp')
set(gcf,'pos',[0 0 750 450])
xlim([0 300])
% legend({"C 10; P 0.2","C 10; P 0.5","C 20; P 0.2","C 20; P 0.5"},"Location","east")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-camkiip-varyCvaryP-bi.png');
saveas(gcf, pngfile);


%CaMKIIp Mono
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,3,2, 2, :,2); % CaMKIIp
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,6,2, 2, :,2); % CaMKIIp
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot(:) = resultsLin(5,3,2, 2, :,2); % CaMKIIp
plot(tspan,toPlot, 'LineWidth', 6)
toPlot(:) = resultsLin(5,6,2, 2, :,2); % CaMKIIp
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('CaMKIIp (\muM)');
xlabel('Time (s)')
title('CaMKIIp')
set(gcf,'pos',[0 0 750 450])
xlim([0 300])
legend({"C 10; P 0.2","C 10; P 0.5","C 20; P 0.2","C 20; P 0.5"},"Location","east")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-camkiip-varyCvaryP-lin.png');
saveas(gcf, pngfile);


%pp1 bistable
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,3,2, 2, :,8); % pp1
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,6,2, 2, :,8); % pp1
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot(:) = resultsBi(5,3,2, 2, :,8); % pp1
plot(tspan,toPlot, 'LineWidth', 6)
toPlot(:) = resultsBi(5,6,2, 2, :,8); % pp1
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('PP1 (\muM)');
xlabel('Time (s)')
title('PP1')
set(gcf,'pos',[0 0 750 450])
xlim([0 300])
% legend({"C 10; P 0.2","C 10; P 0.5","C 20; P 0.2","C 20; P 0.5"},"Location","east")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-pp1-varyCvaryP-bi.png');
saveas(gcf, pngfile);


%pp1 Mono
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,3,2, 2, :,8); % pp1
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,6,2, 2, :,8); % pp1
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,3,2, 2, :,8); % pp1
plot(tspan,toPlot, 'LineWidth', 6)
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,6,2, 2, :,8); % pp1
plot(tspan,toPlot, '--','LineWidth', 6)
ylabel('PP1 (\muM)');
xlabel('Time (s)')
title('PP1')
set(gcf,'pos',[0 0 750 450])
xlim([0 300])
% legend({"C 10; P 0.2","C 10; P 0.5","C 20; P 0.2","C 20; P 0.5"},"Location","east")
hold off
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
pngfile = fullfile(pathname, 'Temporal-pp1-varyCvaryP-lin.png');
saveas(gcf, pngfile);


%ab bistable
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,3,2, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsBi(3,6,2, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot(:) = resultsBi(5,3,2, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
toPlot(:) = resultsBi(5,6,2, 2, :,12)*(6.022e23*1e-12); % ab
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
pngfile = fullfile(pathname, 'Temporal-abound-varyCvaryP-bi.png');
saveas(gcf, pngfile);


%ab Mono
figure
set(findall(gcf,'type','text'),'FontSize',36)
set(0,'defaultAxesFontSize', 36)
set(findall(gca, 'Type', 'Line'),'LineWidth',6);
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,3,2, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
hold on
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(3,6,2, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, '--', 'LineWidth', 6)
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,3,2, 2, :,12)*(6.022e23*1e-12); % ab
plot(tspan,toPlot, 'LineWidth', 6)
toPlot = ones(length(tspan),1);
toPlot(:) = resultsLin(5,6,2, 2, :,12)*(6.022e23*1e-12); % ab
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
pngfile = fullfile(pathname, 'Temporal-abound-varyCvaryP-lin.png');
saveas(gcf, pngfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(4,6,2, 2, :,7); % CaMKIIp
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(6,6,2, 2, :,7); % CaMKIIp
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('CaMKIIp (\muM)');
% xlabel('Time (s)')
% title('CaMKIIp')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend({"C 12; P 0.25","C 20; P 0.25"},"Location","southeast")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-camkiip-varyCsetP.png');
% saveas(gcf, pngfile);
% 
% %PP1
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(4,3,2, 2, :,13); % PP1
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(4,11,2, 2, :,13); % PP1
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('PP1 (\muM)');
% xlabel('Time (s)')
% title('PP1')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend({"C 12; P 0.1","C 12; P 0.5"},"Location","east")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-pp1-setCvaryP.png');
% saveas(gcf, pngfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(4,6,2, 2, :,13); % PP1
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(6,6,2, 2, :,13); % PP1
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('PP1 (\muM)');
% xlabel('Time (s)')
% title('PP1')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend("C 12; P 0.25","C 20; P 0.25")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-pp1-varyCsetP.png');
% saveas(gcf, pngfile);
% 
% %Abound
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(4,3,2, 2, :,17)*(6.022e23*1e-12); % Abound
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(4,11,2, 2, :,17)*(6.022e23*1e-12); % Abound
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('Bound AMPAR (#/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend({"C 12; P 0.1","C 12; P 0.5"},"Location","southeast")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-Abound-setCvaryP.png');
% saveas(gcf, pngfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(4,6,2, 2, :,17)*(6.022e23*1e-12); % Abound
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsBi(6,6,2, 2, :,17)*(6.022e23*1e-12); % Abound
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('Bound AMPAR (#/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend({"C 12; P 0.25","C 20; P 0.25"},"Location","southeast")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-Abound-varyCsetP.png');
% saveas(gcf, pngfile);
% 
% %%linear
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(4,3,2, 2, :,7); % CaMKIIp
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(4,11,2, 2, :,7); % CaMKIIp
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('CaMKIIp (\muM)');
% xlabel('Time (s)')
% title('CaMKIIp')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend({"C 12; P 0.1","C 12; P 0.5"},"Location","east")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-camkiip-setCvaryP-Lin.png');
% saveas(gcf, pngfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(4,6,2, 2, :,7); % CaMKIIp
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(6,6,2, 2, :,7); % CaMKIIp
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('CaMKIIp (\muM)');
% xlabel('Time (s)')
% title('CaMKIIp')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend({"C 12; P 0.25","C 20; P 0.25"},"Location","southeast")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-camkiip-varyCsetP-Lin.png');
% saveas(gcf, pngfile);
% 
% %PP1
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(4,3,2, 2, :,13); % PP1
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(4,11,2, 2, :,13); % PP1
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('PP1 (\muM)');
% xlabel('Time (s)')
% title('PP1')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend({"C 12; P 0.1","C 12; P 0.5"},"Location","east")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-pp1-setCvaryP-Lin.png');
% saveas(gcf, pngfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(4,6,2, 2, :,13); % PP1
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(6,6,2, 2, :,13); % PP1
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('PP1 (\muM)');
% xlabel('Time (s)')
% title('PP1')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend("C 12; P 0.25","C 20; P 0.25")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-pp1-varyCsetP-Lin.png');
% saveas(gcf, pngfile);
% 
% %Abound
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(4,3,2, 2, :,17)*(6.022e23*1e-12); % Abound
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(4,11,2, 2, :,17)*(6.022e23*1e-12); % Abound
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('Bound AMPAR (#/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend({"C 12; P 0.1","C 12; P 0.5"},"Location","southeast")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-Abound-setCvaryP-Lin.png');
% saveas(gcf, pngfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(4,6,2, 2, :,17)*(6.022e23*1e-12); % Abound
% plot(tspan,toPlot, 'LineWidth', 6)
% hold on
% toPlot = ones(length(tspan),1);
% toPlot(:) = resultsLin(6,6,2, 2, :,17)*(6.022e23*1e-12); % Abound
% plot(tspan,toPlot, '--','LineWidth', 6)
% ylabel('Bound AMPAR (#/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 300])
% legend({"C 12; P 0.25","C 20; P 0.25"},"Location","southeast")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'Temporal-Abound-varyCsetP-Lin.png');
% saveas(gcf, pngfile);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Fig 5 SS plot of CaMKII and PP1 for variety of IC
% % Cparts = [0:4:20];
% % Pparts = [0:0.05:0.5];% 11 parts here, only want 6
% %order cparts,PpartIndex,enx, infl
% 
% CSSLinMatrix = zeros(6,11);
% CSSBiMatrix = zeros(6,11);
% %pulling out PP1 max, time of max, and value at 500s
% PSSLinMatrix = zeros(6,11);
% PSSBiMatrix = zeros(6,11);
% 
% ASSLinMatrix = zeros(6,11);
% ASSBiMatrix = zeros(6,11);
% 
% %results order: cparts,PpartIndex,enx, infl
% 
% for c = 1:6
%     for p = 1:11
%         CSSLinMatrix(c,p) = resultsLin(c,p,2, 2, 50001, 7);
%         CSSBiMatrix(c,p) = resultsBi(c,p,2, 2, 50001, 7);
%         
%         PSSLinMatrix(c,p) = resultsLin(c,p,2, 2, 50001, 13);
%         PSSBiMatrix(c,p) = resultsBi(c,p,2, 2, 50001, 13);
%         
%         ASSLinMatrix(c,p) = resultsLin(c,p,2, 2, 50001, 17)*(6.022e23*1e-12);
%         ASSBiMatrix(c,p) = resultsBi(c,p,2, 2, 50001, 17)*(6.022e23*1e-12);
%     end
% end
% 
% %all SS for C and P in linear system are zero (show numerical issues if
% %pull out value at 500s
% 
% CSSLinMatrix = zeros(6,11);
% PSSLinMatrix = zeros(6,11);
% 
% %CaMKIIp
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,3,2, 2, :,7); % CaMKIIp
% plot(Cparts,CSSBiMatrix(:,3),'*', 'MarkerSize', 16)
% hold on
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,11,2, 2, :,7); % CaMKIIp
% plot(Cparts,CSSBiMatrix(:,11),'o','MarkerSize', 16)
% ylabel('Steady State (\muM)');
% xlabel('CaMKII IC (\muM)')
% title('CaMKIIp SS')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 20])
% legend({"P 0.1","P 0.5"},"Location","east")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'SSC-vscamkiiIC-twoPIC-Bi.png');
% saveas(gcf, pngfile);
% 
% %CaMKIIp Lin
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,3,2, 2, :,7); % CaMKIIp
% plot(Cparts,CSSLinMatrix(:,3),'*', 'MarkerSize', 16)
% hold on
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,11,2, 2, :,7); % CaMKIIp
% plot(Cparts,CSSLinMatrix(:,11),'o', 'MarkerSize', 16)
% ylabel('Steady State (\muM)');
% xlabel('CaMKII IC (\muM)')
% title('CaMKIIp SS')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 20])
% ylim([0 1])
% legend({"P 0.1","P 0.5"},"Location","east")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'SSC-vscamkiiIC-twoPIC-Lin.png');
% saveas(gcf, pngfile);
% 
% 
% %PP1
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,3,2, 2, :,7); % CaMKIIp
% plot(Pparts,PSSBiMatrix(4,:),'*', 'MarkerSize', 16)
% hold on
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,11,2, 2, :,7); % CaMKIIp
% plot(Pparts,PSSBiMatrix(6,:),'o', 'MarkerSize', 16)
% ylabel('Steady State (\muM)');
% xlabel('PP1p IC (\muM)')
% title('PP1 SS')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 0.5])
% legend({"C 12","C 20"},"Location","west")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'SSP-vspp1IC-twoCIC-Bi.png');
% saveas(gcf, pngfile);
% 
% %PP1 Lin
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,3,2, 2, :,7); % CaMKIIp
% plot(Pparts,PSSLinMatrix(4,:), '*', 'MarkerSize', 16)
% hold on
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,11,2, 2, :,7); % CaMKIIp
% plot(Pparts,PSSLinMatrix(6,:),'o', 'MarkerSize', 16)
% ylabel('Steady State (\muM)');
% xlabel('PP1p IC (\muM)')
% title('PP1 SS')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 0.5])
% ylim([0 1])
% legend({"C 12","C 20"},"Location","east")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'SSP-vspp1IC-twoCIC-Lin.png');
% saveas(gcf, pngfile);
% 
% %Abound %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%To resave
% %vs C IC
% figure
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,3,2, 2, :,7); % CaMKIIp
% plot(Cparts,ASSBiMatrix(:,3), '*', 'MarkerSize', 16)
% hold on
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,11,2, 2, :,7); % CaMKIIp
% plot(Cparts,ASSBiMatrix(:,11),'o', 'MarkerSize', 16)
% ylabel('Steady State (#/\mum^2)');
% xlabel('CaMKII IC (\muM)')
% title('Bound AMPAR SS')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 20])
% legend({"P 0.1","P 0.5"},"Location","west")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'SSA-vscamkiiIC-twoPIC-Bi.png');
% saveas(gcf, pngfile);
% 
% figure%Lin
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,3,2, 2, :,7); % CaMKIIp
% plot(Cparts,ASSLinMatrix(:,3),'*', 'MarkerSize', 16)
% hold on
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,11,2, 2, :,7); % CaMKIIp
% plot(Cparts,ASSLinMatrix(:,11),'o', 'MarkerSize', 16)
% ylabel('Steady State (#/\mum^2)');
% xlabel('CaMKII IC (\muM)')
% title('Bound AMPAR SS')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 20])
% legend({"P 0.1","P 0.5"},"Location","east")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'SSA-vscamkiiIC-twoPIC-Lin.png');
% saveas(gcf, pngfile);
% 
% figure % vs P IC
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,3,2, 2, :,7); % CaMKIIp
% plot(Pparts,ASSBiMatrix(4,:),'*', 'MarkerSize', 16)
% hold on
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,11,2, 2, :,7); % CaMKIIp
% plot(Pparts,ASSBiMatrix(6,:),'o', 'MarkerSize', 16)
% ylabel('Steady State (#/\mum^2)');
% xlabel('PP1p IC (\muM)')
% title('Bound AMPAR SS')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 0.5])
% legend({"C 12","C 20"},"Location","east")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'SSA-vspp1IC-twoCIC-Bi.png');
% saveas(gcf, pngfile);
% 
% figure % vs P IC
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,3,2, 2, :,7); % CaMKIIp
% plot(Pparts,ASSLinMatrix(4,:),'*', 'MarkerSize', 16)
% hold on
% % toPlot = ones(length(tspan),1);
% % toPlot(:) = resultsBi(4,11,2, 2, :,7); % CaMKIIp
% plot(Pparts,ASSLinMatrix(6,:),'o', 'MarkerSize', 16)
% ylabel('Steady State (#/\mum^2)');
% xlabel('PP1p IC (\muM)')
% title('Bound AMPAR SS')
% set(gcf,'pos',[0 0 750 450])
% xlim([0 0.5])
% legend({"C 12","C 20"},"Location","east")
% hold off
% set(findall(gcf,'type','text'),'FontSize',36)
% set(0,'defaultAxesFontSize', 36)
% set(findall(gca, 'Type', 'Line'),'LineWidth',6);
% pngfile = fullfile(pathname, 'SSA-vspp1IC-twoCIC-Lin.png');
% saveas(gcf, pngfile);
% 
% 
% %%%%%% C and P variations %%%Order CaMKII, PP1, AMPAR%%%%%%%%%%%%%%%%%%%%
% %%%Control trafficking; order lienar then bistable
% 
% %CaMKII
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 2
%             for infl = 2
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsLin(i,PpartIndex,enx, infl, :,7);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Activated CaMKII (\muM)');
% xlabel('Time (s)')
% title('Activated CaMKII - Linear')
% set(gcf,'pos',[0 0 1000 600])
% xlim([0 250])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'CaMKIIp-CPvariations-BothEnExInf-Lin.png');
% saveas(gcf, pngfile);
% 
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 2
%             for infl = 2
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsBi(i,PpartIndex,enx, infl, :,7);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Activated CaMKII (\muM)');
% xlabel('Time (s)')
% title('Activated CaMKII - Bistable')
% set(gcf,'pos',[0 0 1000 600])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'CaMKIIp-CPvariations-BothEnExInf-Bi.png');
% saveas(gcf, pngfile);
% 
% 
% 
% %%PP1
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 2
%             for infl = 2
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsLin(i,PpartIndex,enx, infl, :,13);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Activated PP1 (\muM)');
% %xticks([0.035, 0.119, 0.283])
% %xlabel('\mum^3')
% xlabel('Time (s)')
% title('Activated PP1 - Linear')
% set(gcf,'pos',[0 0 1000 600])
% xlim([0 250])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'PP1-CPvariations-BothEnExInf-Lin.png');
% saveas(gcf, pngfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 2
%             for infl = 2
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsBi(i,PpartIndex,enx, infl, :,13);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Activated PP1 (\muM)');
% xlabel('Time (s)')
% title('Activated PP1 - Bistable')
% set(gcf,'pos',[0 0 1000 600])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'PP1-CPvariations-BothEnExInf-Bi.png');
% saveas(gcf, pngfile);
% 
% 
% %%AMPAR Bound
% %%plot temporal
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 2
%             for infl = 2
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsLin(i,PpartIndex,enx, infl, :,17)*(6.022e23*1e-12);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Bound AMPAR (molecules/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR - Linear')
% set(gcf,'pos',[0 0 1000 600])
% xlim([0 250])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'ABound-CPvariations-BothEnExInf-Lin.png');
% saveas(gcf, pngfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 2
%             for infl = 2
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsBi(i,PpartIndex,enx, infl, :,17)*(6.022e23*1e-12);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Bound AMPAR (molecules/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR - Bistable')
% set(gcf,'pos',[0 0 1000 600])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'ABound-CPvariations-BothEnExInf-Bi.png');
% saveas(gcf, pngfile);
% 
% %%AMPAR Bound
% %%plot temporal for No endo/exo
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 1
%             for infl = 2
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsLin(i,PpartIndex,enx, infl, :,17)*(6.022e23*1e-12);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Bound AMPAR (molecules/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR - Linear')
% set(gcf,'pos',[0 0 1000 600])
% xlim([0 250])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'ABound-CPvariations-NoEnEx-Lin.png');
% saveas(gcf, pngfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 1
%             for infl = 2
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsBi(i,PpartIndex,enx, infl, :,17)*(6.022e23*1e-12);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Bound AMPAR (molecules/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR - Bistable')
% set(gcf,'pos',[0 0 1000 600])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'ABound-CPvariations-NoEnEx-Bi.png');
% saveas(gcf, pngfile);
% 
% %%AMPAR Bound
% %%plot temporal for No influx
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 2
%             for infl = 1
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsLin(i,PpartIndex,enx, infl, :,17)*(6.022e23*1e-12);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Bound AMPAR (molecules/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR - Linear')
% set(gcf,'pos',[0 0 1000 600])
% xlim([0 250])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'ABound-CPvariations-NoInflux-Lin.png');
% saveas(gcf, pngfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 2
%             for infl = 1
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsBi(i,PpartIndex,enx, infl, :,17)*(6.022e23*1e-12);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 2, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%                 %legendList = [legend List ]
%             end
%         end
%     end
% end
% 
% 
% ylabel('Bound AMPAR (molecules/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR - Bistable')
% set(gcf,'pos',[0 0 1000 600])
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',28)
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'ABound-CPvariations-NoInflux-Bi.png');
% saveas(gcf, pngfile);
% 
% %%%Legend
% figure
% set(findall(gcf,'type','text'),'FontSize',20,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 20)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% toPlot = ones(length(tspan),1);
% 
% for i = 1:length(Cparts)
%     for j = 1:6 %length(Pparts)
%         for enx = 2
%             for infl = 2
%                 %C, P, enex, influx, species values, species 
%                 PpartIndex = 1 + 2*(j-1);
%                 toPlot(:) = resultsBi(i,PpartIndex,enx, infl, :,17)*(6.022e23*1e-12);
%                 plot(tspan,toPlot, marker(j), 'MarkerSize', 10, 'LineWidth', 4,'MarkerFaceColor',colors{6*(i-1) + j}, 'Color' , colors{6*(i-1) + j})
%                 hold on
%             end
%         end
%     end
% end
% 
% 
% ylabel('Bound AMPAR (molecules/\mum^2)');
% xlabel('Time (s)')
% title('Bound AMPAR - Bistable')
% set(gcf,'pos',[0 0 1000 600])
% legend('C 0, P 0','C 0, P 0.1','C 0, P 0.2','C 0, P 0.3','C 0, P 0.4','C 0, P 0.5', .../
%     'C 4, P 0','C 4, P 0.1','C 4, P 0.2','C 4, P 0.3','C 4, P 0.4','C 4, P 0.5', .../
%     'C 8, P 0','C 8, P 0.1','C 8, P 0.2','C 8, P 0.3','C 8, P 0.4','C 8, P 0.5', .../
%     'C 12, P 0','C 12, P 0.1','C 12, P 0.2','C 12, P 0.3','C 12, P 0.4','C 12, P 0.5', .../
%     'C 16, P 0','C 16, P 0.1','C 16, P 0.2','C 16, P 0.3','C 16, P 0.4','C 16, P 0.5', .../
%     'C 20, P 0','C 20, P 0.1','C 20, P 0.2','C 20, P 0.3','C 20, P 0.4','C 20, P 0.5');
% %legend(legendnames);
% 
% hold off
% set(findall(gcf,'type','text'),'FontSize',20,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 20)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'CPvariations-Legend.png');
% saveas(gcf, pngfile);
% 
% %%%%%%%%%%%%%%%%%%gathering peak, peak time, SS, SS time
% %%%Bistable, linear
% %%% all species
% %%% all CP var, both influx endo/exo cases
% % Cparts = [0:4:20];
% % Pparts = [0:0.05:0.5];% 11 parts here, only want 6
% % EnExparts = [0 1];
% % Influxparts = [0 1];
% 
% speciesBiDiff = zeros(6,11,2,2,length(tspan)-1,17); speciesLinDiff = zeros(6,11,2,2,length(tspan)-1,17);
% % speciesBiDiffBinary = zeros(length(tspan)-1,17); speciesLinDiffBinary = zeros(length(tspan)-1,17);
% speciesBiPeak = zeros(6,11,2,2,17); speciesLinPeak = zeros(6,11,2,2,17);
% speciesBiPeakTime = zeros(6,11,2,2,17); speciesLinPeakTime = zeros(6,11,2,2,17);
% speciesBiSS = zeros(6,11,2,2,17); speciesLinSS = zeros(6,11,2,2,17);
% % speciesBiSSBinary50 = zeros(50,17); speciesLinSSBinary50 = zeros(50,17); %%%Indexes of first 50 instances of 0
% speciesBiSSTime = zeros(6,11,2,2,17); speciesLinSSTime = zeros(6,11,2,2,17);
% 
% for pval = 1:6
%     for cval = 1:11
%         for enex = 1:2
%             for inf = 1:2
%                 for n = 1:17
%                     speciesBi(:) = resultsBi(pval,cval,enex, inf, :,n);
%                     speciesLin(:) = resultsLin(pval,cval,enex, inf, :,n);
%                     stepSize = 0.01;
%                     %rates of increase
%                     speciesBiDiff(pval,cval,enex, inf, :,n) = diff(speciesBi)/stepSize;
%                     speciesLinDiff(pval,cval,enex, inf, :,n) = diff(speciesLin)/stepSize;
%                     %peak and time of peak
%                     [speciesBiPeak(pval,cval,enex, inf,n), indexBi] = max(speciesBi);
%                     speciesBiPeakTime(pval,cval,enex, inf,n)=tspan(indexBi);
%                     [speciesLinPeak(pval,cval,enex, inf,n), indexLin] = max(speciesLin);
%                     speciesLinPeakTime(pval,cval,enex, inf,n)=tspan(indexLin);
%                     %SS and time of SS
%                 %     if n < 15
%                 %         cutoff = 1e-3;
%                 %         multiplier = 1;
%                 %     elseif n >=15
%                 %         cutoff = 1e-3;%1e-3/(6.022e23*1e-12);
%                 %         multiplier = (6.022e23*1e-12);
%                 %     end
% %                     cutoff = 1e-3;
% %                     multiplier=1;
% %                     for i=1:length(tspan)-1
% %                         if abs(speciesBiDiff(i,n))*multiplier < cutoff
% %                             speciesBiDiffBinary(i,n) = 0;
% %                         else
% %                             speciesBiDiffBinary(i,n)=1;
% %                         end
% %                         %Lin
% %                         if abs(speciesLinDiff(i,n))*multiplier < cutoff
% %                             speciesLinDiffBinary(i,n) = 0;
% %                         else
% %                             speciesLinDiffBinary(i,n)=1;
% %                         end
% %                     end
%                 %     speciesBiSSBinary50(:,n) = find(speciesBiDiffBinary(:,n)==0,50);
%                 %     speciesLinSSBinary50(:,n) = find(speciesLinDiffBinary(:,n)==0,50);
%                 end
%             end
%         end
%     end
% end
% 
% 
% 
% % figure
% % imagesc(matrixToPlotS)
% % colorbar;
% % %set(gca, 'CLim', [9.5137, 46.4504]);
% % colormap(MyMap); %daspect([1 1 1]);%daspect([1 2 1]);
% % set(findall(gcf,'type','text'),'FontSize',24,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 24)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',2)
% % title('Sphere - AUC')
% % xlabel('Mobile Buffer Concentration (\muM)')
% % ylabel('Diffusion rate (\mum^2/s)');
% % set(gca,'xTickLabel',{'1','10','20', '50', '100'});
% % set(gca,'YTickLabel',{ '220', '100', '10','1'});
% % set(findall(gcf,'type','text'),'FontSize',24,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 24)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',2)
% % 
% % 
% % figure
% % data = matrixToPlotS;
% % [X,Y] = meshgrid(1:5, 1:4);
% % [X2,Y2] = meshgrid(1:0.1:size(data,2), 1:0.1:size(data,1));
% % outData = interp2(X, Y, data, X2, Y2, 'linear');
% % colormap(MyMap);
% % imagesc(outData);
% % colorbar;
% % xticks([40,120,200,280,360])
% % yticks([37.5,1.125000000000000e+02,1.875000000000000e+02,2.625000000000000e+02])
% % title('Sphere - AUC')
% % xlabel('Mobile Buffer Concentration (\muM)')
% % ylabel('Diffusion rate (\mum^2/s)');
% % set(gca,'xTickLabel',{'1','10','20', '50', '100'});
% % set(gca,'YTickLabel',{ '220', '100', '10','1'});
% % set(findall(gcf,'type','text'),'FontSize',24,'fontWeight','bold')
% % set(0,'defaultAxesFontSize', 24)
% % set(findall(gca, 'Type', 'Line'),'LineWidth',2)