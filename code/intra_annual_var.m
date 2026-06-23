%%
cropclass_label={'barley(s)','barley(w)','fruit','legume','maize','oilplant(s)','oilplant(w)','other cereal(s)',...
    'other cereal(w)','potato','rice', 'sugar beet','vegetables','wheat(s)','wheat(w)'};
R=georefcells([34 74], [-15 55],[160 280],'ColumnsStartFrom','north');
figure('Position',[100 100 900 550]);

pos_a=[-0.03 0.55 0.4 0.4];pos_b=[0.5 0.55 0.5 0.4];
pos_c=[-0.03 0.09 0.4 0.4];pos_d=[0.5 0.09 0.5 0.4];

ax1=axes('Position', pos_a);
axesm('MapProjection','lambertstd','FontSize', 11,'GLineStyle','--', ...
          'GLineWidth',1.2,'GColor',[.3 .3 .3]);
framem on;axis off;
setm(gca,'MapProjection','braun','origin',[54 10],...
    'FLatLimit',[-19 18],'FLonLimit',[-16 20])
geoshow('landareas.shp', 'FaceColor',[0.96 0.95 0.93],'LineWidth',0.77)

data=E_GS_annual(:,:,21)*1000;data(data==0)=nan;
hold on;hImg=geoshow(data,R,'DisplayType','surface');
amap=flipud(slanCM('spectral',256));
colormap(amap);clim([0 80]);
alphaData=~isnan(data);
set(hImg, 'AlphaData', alphaData);
cb=colorbar('eastoutside');
cb.Label.String='Gridded N_2O emission (t N/yr)';
cb.Label.Position=[3, -10,0];
cb.FontSize=11;cb.LineWidth=0.77;
cb.Label.FontSize=13;
cb.Position=[0.31,0.55,0.018,0.4];
cb.Ticks=0:25:100;cb.TickLength=0.02;
setm(gca,'FLineWidth',1.2,'Grid','on')
tightmap;text(ax1,-0.1,1.05,'a','Units','normalized','FontWeight','bold','FontSize',14.5);
hold on;text(ax1,-0.18,0.8,'60°N','Units','normalized','FontSize',11,'Color',[.3 .3 .3]/2);
hold on;text(ax1,-0.18,0.35,'45°N','Units','normalized','FontSize',11,'Color',[.3 .3 .3]/2);
hold on;text(ax1,0.15,-0.05,'0°','Units','normalized','FontSize',11,'Color',[.3 .3 .3]/2);
hold on;text(ax1,0.85,-0.05,'30°E','Units','normalized','FontSize',11,'Color',[.3 .3 .3]/2);


ax2=axes('Position',pos_b);
text(ax2,-0.25,1.05,'b','Units','normalized','FontWeight','bold','FontSize',14.5);
hold on;
h=area(1:366,E_GS_2020','LineStyle','none');
amap=slanCM('set3',24)*0.75+ones(24,3)*0.25;
aamap=amap([1,2,3:2:9,10,11,12,13,15,17,19,21,22],:);
aamap([2,7,9,15],:)=aamap([2,7,9,15],:)*0.8;
for i=1:15
    h(i).FaceColor=aamap(i,:);
end
hold on;

ylim([0 1.6])
yl=ylim;

col_JFM=[198 221 209]/255;
col_AMJ=[247 220 200]/255;
col_JAS=[240 231 190]/255;
col_OND=[211 216 232]/255;

season_x=[1 91; 91 182; 182 274; 274 366];
season_col={col_JFM,col_AMJ,col_JAS,col_OND};
season_lab={'JFM','AMJ','JAS','OND'};

for s=1:4
    patch([season_x(s,:) fliplr(season_x(s,:))],[yl(1) yl(1) yl(2) yl(2)], ...
          season_col{s}, 'FaceAlpha',0.2,'EdgeColor','none');
end
uistack(findall(gca,'Type','patch'),'bottom')


for s=1:4
    text(mean(season_x(s,:)), yl(2)*0.9, season_lab{s},...
        'HorizontalAlignment','center', 'FontSize',13,...
        'FontWeight','bold','Color',season_col{s}*0.8);
end
season_boundary=[91 182 274];

for x=season_boundary
    plot([x x], yl, '--', 'Color',[0.6 0.6 0.6],'LineWidth',1.2);
end
ylabel('Daily N_2O emission (Gg N)');
set(gca,'FontSize',12,'Box','on','LineWidth',1.2,'XTick',[])
xlim([1 366]);
set(gca,'FontSize',12,'box','on','LineWidth',1.2,'XTickLabel',{'      '});
xlim([1 366]);xticks([0 366])

lgd=legend(h, cropclass_label, 'Location','eastoutside', 'FontSize',12, ...
    'Box','off','NumColumns',1);
lgd.ItemTokenSize=[12 12];set(lgd, 'FontName','Arial','Visible','off');


ax3=axes('Position', pos_c);
h2=axesm('MapProjection','lambertstd','FontSize', 11,'GLineStyle','--', ...
          'GLineWidth',1.2,'GColor',[.3, .3, .3]);
framem on;axis off;
setm(gca,'MapProjection','braun');
setm(gca,'origin',[54 10])
setm(gca,'FLatLimit',[-19 18],'FLonLimit',[-16 20])		% 设置图片经纬度范围	
geoshow('landareas.shp', 'FaceColor',[0.96 0.95 0.93],'LineWidth',0.77)
data=E_FP_annual(:,:,21)*1000;data(data==0)=nan;
hold on;hImg=geoshow(data,R,'DisplayType','surface');
amap=flipud(slanCM('spectral',256));
colormap(amap);clim([0 80]);
alphaData=~isnan(data);
set(hImg, 'AlphaData', alphaData);
cb=colorbar('eastoutside');
cb.Label.String='';
cb.FontSize=11;cb.LineWidth=0.77;
cb.Position=[0.31,0.08,0.018,0.4];
cb.Ticks=0:25:100;cb.TickLength=0.02;
setm(gca,'FLineWidth',1.2,'Grid','on')
tightmap;text(ax3,-0.1,1.05,'c','Units','normalized','FontWeight','bold','FontSize',14.5);
hold on;text(ax3,-0.18,0.8,'60°N','Units','normalized','FontSize',11,'Color',[.3 .3 .3]/2);
hold on;text(ax3,-0.18,0.35,'45°N','Units','normalized','FontSize',11,'Color',[.3 .3 .3]/2);
hold on;text(ax3,0.15,-0.05,'0°','Units','normalized','FontSize',11,'Color',[.3 .3 .3]/2);
hold on;text(ax3,0.85,-0.05,'30°E','Units','normalized','FontSize',11,'Color',[.3 .3 .3]/2);



ax4=axes('Position', pos_d);
text(ax4,-0.25,1.05,'d','Units','normalized','FontWeight','bold','FontSize',14.5);
hold on;
%data from fallow_code.m
h=area(1:366,E_fallow_2020','LineStyle','none');
for i=1:15
    h(i).FaceColor=aamap(i,:);
end
hold on;
ylim([0 0.8]);yl=ylim;
for s=1:4
    patch([season_x(s,:) fliplr(season_x(s,:))],[yl(1) yl(1) yl(2) yl(2)], ...
          season_col{s}, 'FaceAlpha',0.2,'EdgeColor','none');
end
uistack(findall(gca,'Type','patch'),'bottom')

for s=1:4
    text(mean(season_x(s,:)), yl(2)*0.9, season_lab{s},...
        'HorizontalAlignment','center', 'FontSize',13,...
        'FontWeight','bold','Color',season_col{s}*0.8);
end

for x=season_boundary
    plot([x x], yl, '--', 'Color',[0.6 0.6 0.6],'LineWidth',1.2);
end

ylabel('Daily N_2O emission (Gg N)');
xlabel('Day of Year')
set(gca,'FontSize',12,'box','on','LineWidth',1.2);
xlim([1 366]);xticks([0 91 182 274 366])
lgd=legend(h, cropclass_label, 'Location','eastoutside', 'FontSize',12, ...
    'Box','off','NumColumns',1);
lgd.ItemTokenSize=[12 12];set(lgd, 'FontName','Arial','Visible','off');
hold off;



ax5=axes('Position', pos_b);
axis(ax5,'off');
lgd=legend(ax5,h, cropclass_label, 'position',[0.86,0.2,0.1339,0.6], 'FontSize',12, ...
   'Box','off','NumColumns',1);
lgd.ItemTokenSize=[12 12];set(lgd, 'FontName','Arial');
