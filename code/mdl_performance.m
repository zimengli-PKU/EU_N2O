figure('Position',[100 100 900 750]);

pos_a=[0.1 0.6 0.33 0.35];
pos_b=[0.55 0.6 0.4 0.35];
pos_c1=[0.1 0.25 0.78 0.25];
pos_c2=[0.1 0.08 0.78 0.15];

ax1=axes('Position', pos_a);
hold on
radius=3; % 定义半径
density_2D=density2D_KD(data0(:,[1,7]),radius);
scatter(log10(data0(:,1)+10),log10(data0(:,7)+10), 8, log10(density_2D), 'filled');
map=flipud(othercolor('Spectral10'));
colormap(map);clim([-1 3])

xlabel('Observed GS N_2O flux (g N/ha/day)')
ylabel('Predicted GS N_2O flux (g N/ha/day)')
xlim([0.8 3.1]);ylim([0.8 3.1]);hold on;plot([-30,200],[-30,200],'--k','LineWidth',1.5)
text(ax1,-0.2,1.1,'a','Units','normalized','FontWeight','bold','FontSize',14.5)
set(gca, 'Box', 'off', 'LineWidth',0.8, 'XGrid', 'off', 'YGrid', 'off', ...    
         'TickDir', 'in', 'TickLength', [.005 .005], ... 
         'XMinorTick', 'off', 'YMinorTick', 'off', ...     
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  
         'XTick', [ 1 log10(25) log10(60) log10(160) log10(410) log10(1010)], ...
         'YTick', [ 1 log10(25) log10(60) log10(160) log10(410) log10(1010)],'GridLineStyle','--',...
         'XTickLabel',{'0','20','50','150','400','1000'},...
         'YTickLabel',{'0','20','50','150','400','1000'},'FontSize',12)
box on
text(2,2.9,'R^{2}= 0.63','FontSize',12.5)

axes('Position',[0.15,0.87,0.1,0.07])
bh=barh([R2_train_mean,R2_test_mean], 'barwidth',0.7,'LineWidth',1.2,'FaceAlpha',0.8);
bh.FaceColor='Flat';
bh.CData=[0.3 0.3 0.6;178/255 86/255 71/255]*1.1;
hold on;
errorbar([R2_train_mean,R2_test_mean], 1:2, [0 0],[R2_train_sd,R2_test_sd], ...
    'horizontal', 'Color','k', 'LineStyle', 'none', 'LineWidth', 1.5,'CapSize',8);

barh([R2_train_mean_RF,R2_test_mean_RF], 'barwidth',0.3,'LineWidth',1,...
    'EdgeColor',[242,234,223]/255,'FaceColor',[242,234,223]/255,'FaceAlpha',0.8);
box off
yticks(1:2)
yticklabels({'Train','Test'})
errorbar([R2_train_mean_RF,R2_test_mean_RF], 1:2, [0 0],[R2_train_sd_RF,R2_test_sd_RF], ...
    'horizontal','color', [242,234,223]/255, 'LineStyle', 'none', 'LineWidth', 1.2,'CapSize',6);
text(0.8,1.3,'**','FontSize',12,'FontWeight','bold','Rotation',90);
text(0.7,2.4,'***','FontSize',12,'FontWeight','bold','Rotation',90);
set(gca, 'YDir','reverse','FontSize',11,'LineWidth',0.8,'Color','none',...
    'ylim',[0.5 2.5],'xtick',0:0.3:0.6,'xlim',[0 0.75],'TickLength',[0.01 0.01])

% fig1b
ax2=axes('Position', pos_b);
radius=3;
density_2D=density2D_KD([flux_m.obs flux_m.LSTMmean],radius);
scatter(log10(flux_m.obs+10), log10(flux_m.LSTMmean+10), 8, log10(density_2D), 'filled');
map=flipud(othercolor('Spectral10'))*0.9+[0.1 0.1 0.1];
colormap(map);h=colorbar;clim([-1 3])
set(h,'ticks',-1:3,'TickLabels',{'0.1','1','10','100','1000'},'fontsize',12);
h.Label.String='Kernel density estimate';

xlabel('Observed GS N_2O flux (g N/ha/day)')
ylabel('Predicted GS N_2O flux (g N/ha/day)')
xlim([0.8 3.1]);ylim([0.8 3.1]);hold on;plot([-30,200],[-30,200],'--k','LineWidth',1.5)
text(ax2,-0.2,1.1,'b','Units','normalized','FontWeight','bold','FontSize',14.5)
set(gca, 'Box', 'off', 'LineWidth',0.8, 'XGrid', 'off', 'YGrid', 'off', ...    
         'TickDir', 'in', 'TickLength', [.005 .005], ... 
         'XMinorTick', 'off', 'YMinorTick', 'off', ...     
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  
         'XTick', [ 1 log10(25) log10(60) log10(160) log10(410) log10(1010)], ...
         'YTick', [ 1 log10(25) log10(60) log10(160) log10(410) log10(1010)],'GridLineStyle','--',...
         'XTickLabel',{'0','20','50','150','400','1000'},...
         'YTickLabel',{'0','20','50','150','400','1000'},'FontSize',12)
box on
text(2,2.9,'R^{2}= 0.54','FontSize',12.5)

axes('Position',[0.6,0.87,0.1,0.07])

bh=barh([R2m_train_mean,R2m_test_mean], 'barwidth',0.7,'LineWidth',1.2,'FaceAlpha',0.8);
bh.FaceColor='Flat';
bh.CData=[0.3 0.3 0.6;178/255 86/255 71/255]*1.1;
hold on;
errorbar([R2m_train_mean,R2m_test_mean], 1:2, [0 0],[R2m_train_sd,R2m_test_sd], ...
    'horizontal', 'Color','k', 'LineStyle', 'none', 'LineWidth', 1.5,'CapSize',8);

bh=barh([R2m_train_mean_RF,R2m_test_mean_RF], 'barwidth',0.3,'LineWidth',1,...
    'EdgeColor',[242,234,223]/255,'FaceColor',[242,234,223]/255,'FaceAlpha',0.8);
box off
yticks(1:2)
yticklabels({'Train','Test'})
errorbar([R2m_train_mean_RF,R2m_test_mean_RF], 1:2, [0 0],[R2m_train_sd_RF,R2m_test_sd_RF], ...
    'horizontal','color', [242,234,223]/255, 'LineStyle', 'none', 'LineWidth', 1.2,'CapSize',6);
text(0.7,1.3,'***','FontSize',12,'FontWeight','bold','Rotation',90);
text(0.8,2.3,'**','FontSize',12,'FontWeight','bold','Rotation',90);
set(gca, 'YDir','reverse','FontSize',11,'LineWidth',0.8,'Color','none',...
    'ylim',[0.5 2.5],'xtick',0:0.3:0.6,'xlim',[0 0.75],'TickLength',[0.01 0.01])

%c 图
ax3=axes('Position', pos_c1);
data_seq=readtable('sequence_list.xlsx');data_seq.sowdur=floor(data_seq.sowdur);
t=data_seq.sowdur;obs_seq=data_seq.DailyFluxes;
pred1=data_seq.predicted;sd1=data_seq.sd1;
pred2=data_seq.pred_RF;sd2=data_seq.sd2;
h_obs=plot(t, obs_seq,'-','LineWidth',1.5,'Marker','.',...
    'MarkerSize',16,'Color',[207 214 227]/255); hold on
fill([t; flipud(t)], [pred2-sd2; flipud(pred2+sd2)], ...
     [250 189 41]/255, 'FaceAlpha',0.4, 'EdgeColor','none');
fill([t; flipud(t)], [pred1-sd1; flipud(pred1+sd1)], ...
     [178 86 71]/255, 'FaceAlpha',0.3, 'EdgeColor','none');
h1=plot(t, pred2,'-','color',[220 169 60]/255*1.1,'LineWidth',2);
h2=plot(t, pred1,'-','color',[178 86 71]/255,'LineWidth',2);

lgd=legend([h_obs, h2, h1], {'Observed','LSTM-predicted','RF-predicted'},'Box','off',...
    'FontSize',12,'Location','northeast');
lgd.Position(4)=0.1;lgd.Position(2)=0.38;

ylabel('N_2O flux (g N/ha/day)');ylim([-1 100]);xlim([0 260])

h_arrow1=quiver(94, 40, 0, -25, 0, 'LineWidth',2, 'Color',[.3 .3 .3],'MaxHeadSize',1);
h_arrow2=quiver(161, 40, 0, -25, 0, 'LineWidth',2, 'Color',[.3 .3 .3],'MaxHeadSize',1);
h_arrow3=quiver(195, 30, 0, -25, 0, 'LineWidth',2, 'Color',[.3 .3 .3],'MaxHeadSize',1);
h_arrow4=quiver(20, 76, 0, -12, 0, 'LineWidth',1.5, 'Color',[.3 .3 .3],'MaxHeadSize',1);
text(25,70,'Fertilization','FontSize',12.5)
h_arrow1.Annotation.LegendInformation.IconDisplayStyle='off';
h_arrow2.Annotation.LegendInformation.IconDisplayStyle='off';
h_arrow3.Annotation.LegendInformation.IconDisplayStyle='off';
h_arrow4.Annotation.LegendInformation.IconDisplayStyle='off';
text(1,93.5,'Growing season sequence','FontSize',11.5,'Color',[.6 .6 .6])
set(gca, 'XGrid', 'off', 'YGrid', 'off', 'TickLength', [.005 .005], ... 
         'XMinorTick', 'off', 'YMinorTick', 'off', ...     
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1],...  
         'XTick', [12 42 73 104 133 164 194 225 255], ...
         'YTick', 0:50:100,'GridLineStyle','--',...
         'XTickLabel',{''},'YTickLabel',{'0','50','100'},'FontSize',12,'LineWidth',1.2)

text(ax3,-0.08,1.15,'c','Units','normalized','FontWeight','bold','FontSize',14.5)
text(130,40,'R^{2}= 0.61','FontSize',12.5,'Color',[178 86 71]/255)
text(40,25,'R^{2}= 0.33','FontSize',12.5,'Color',[250 189 41]/255-[0.3 0.3 0])

prec=data_seq.Prec;temp=data_seq.Temp;
ax4=axes('Position', pos_c2);
yyaxis left
plot(t,temp,'Color',[0.8 0.3 0.3],'LineWidth',1.2);hold on;xlim([0 260]);ylim([-10 25])
set(gca, 'TickLength', [.005 .005], 'XColor', [.1 .1 .1],  'YColor', [.7 .1 .1],...  
         'XTick', [12 42 73 104 133 164 194 225 255], ...
         'YTick', [0 20],'GridLineStyle','--','XTickLabelRotation',0,...
         'XTickLabel',{'','2015-Dec','','','2016-March','','','2016-June','',''},...
         'YTickLabel',{'0','20'},'FontSize',12,'LineWidth',1.2)
ylabel('Temperature (°C)')

yyaxis right
bar(t, prec,'FaceAlpha',0.3,'EdgeColor','none','FaceColor',[.1 .1 .7]);xlim([0 260])
set(gca, 'TickLength', [.005 .005], 'XColor', [.1 .1 .1],  'YColor', [.4 .4 .7],...  
         'XTick', [12 42 73 104 133 164 194 225 255], ...
         'YTick', 0:50:100,'GridLineStyle','--','XTickLabelRotation',0,...
         'XTickLabel',{'','2015-Dec','','','2016-March','','','2016-June','',''},...
         'YTickLabel',{'0','50','100'},'FontSize',12,'LineWidth',1.2)
ylabel('Precipitation (mm)','Rotation',270)


function density_2D=density2D_KD(data,radius)
M=size(data,1);density_2D=zeros(M,1);
idx=rangesearch(data(:,1:2),data(:,1:2),radius,'Distance','euclidean','NSMethod','kdtree');
for i=1:M
    density_2D(i,1)=length(idx{i})/(pi*radius^2);
end
end