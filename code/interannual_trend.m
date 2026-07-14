%fitlm(1:21,sum(E_annual,2))
trendE_gs=nan(160,280,2);%slope,sig
for i=1:160
    for j=1:280
        seq=squeeze(E_GS_annual(i,j,:));
if sum(seq)>0
tmp=fitlm(1:21,seq);
trendE_gs(i,j,:)=[tmp.Coefficients.Estimate(2)*1000,tmp.Coefficients.pValue(2)];
end
    end
end

trendE_fp=nan(160,280,2);%slope,sig
for i=1:160
    for j=1:280
        seq=squeeze(E_FP_annual(i,j,:));
if sum(seq)>0
tmp=fitlm(1:21,seq);
trendE_fp(i,j,:)=[tmp.Coefficients.Estimate(2)*1000,tmp.Coefficients.pValue(2)];
end
    end
end


%%
figure('Position',[100 100 900 550]);

pos_a=[0.105 0.72 0.325 0.2];pos_b=[0.55 0.72 0.325 0.2];
pos_c=[0.1 0.08 0.4 0.55];pos_d=[0.55 0.08 0.4 0.55];
color_fp=[145 152 190]/255*0.88+0.25;
color_gs=[220 155 110]/255;

ax1=axes('Position',pos_a);
text(ax1,-0.1,1.1,'a','Units','normalized','FontWeight','bold','FontSize',14.5);
hold on
y=E_annual(:,1);x=2000:2020;
plot(x,y,'-','Color',color_gs,'LineWidth',2,'Marker','.',...
    'MarkerEdgeColor',color_gs*0.92,'MarkerSize',18)
ylabel({'Gg N_{2}O-N/yr'})
set(gca,'FontSize',12,'xtick',2000:5:2020,'Box','on','LineWidth',1.2,'YTick',[200 240])
xlim([1999 2021]);ylim([180 260])
mdl=fitlm(x(:), y(:));
x_fit=linspace(min(x), max(x), 100)';
[y_fit, y_ci]=predict(mdl, x_fit);  % y_ci=95% CI
hold on;
fill([x_fit; flipud(x_fit)],  [y_ci(:,1); flipud(y_ci(:,2))],[0.2 0.2 0.2], 'FaceAlpha', 0.12, 'EdgeColor', 'none');
plot(x_fit, y_fit, '--', 'Color', [0.2 0.2 0.2], 'LineWidth', 2.5);
text(2001,247,'Slope=1.55 Gg N/yr^{2}','FontSize',12,'FontAngle','italic')
text(2003,227,'p < 0.001','FontSize',12,'FontAngle','italic')


ax3=axes('Position', pos_c);
axesm('MapProjection','lambertstd','FontSize', 11,'GLineStyle','--', ...
           'GLineWidth',1.2,'GColor',[.3 .3 .3]);
 framem on;axis off;
 setm(gca,'MapProjection','braun','origin',[54 10],...
     'FLatLimit',[-19 18],'FLonLimit',[-16 20])
geoshow('landareas.shp', 'FaceColor',[0.96 0.95 0.93],'LineWidth',0.77)

data0=trendE_gs(:,:,1)+5;
hold on;hImg=geoshow(data0,R,'DisplayType','surface');
amap=flipud(slanCM('RdBu',256));
colormap(amap([2:2:100,104:4:128,130:2:154,157:256],:));clim([3.9 7.2]);
alphaData=~isnan(data0);set(hImg, 'AlphaData', alphaData);
cb=colorbar('eastoutside');
cb.Label.String='Slope (Gg N_{2}O-N/yr^{2})';
cb.FontSize=12;cb.Label.FontSize=13;cb.LineWidth=0.77;
cb.Ticks=4:7;cb.TickLength=0.02;cb.TickLabels={'-1','0','1','2'};

setm(gca,'FLineWidth',1.2,'Grid','on')
tightmap;
text(ax3,-0.1,1,'c','Units','normalized','FontWeight','bold','FontSize',14.5);
hold on;text(ax3,-0.15,0.8,'60°N','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold on;text(ax3,-0.15,0.35,'45°N','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold on;text(ax3,0.15,-0.05,'0°','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold on;text(ax3,0.85,-0.05,'30°E','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);

sig_mask=trendE_gs(:,:,2)<0.05;
[Lon, Lat]=meshgrid(-14.875:0.25:54.875,73.875:-0.25:34.125);
sig_mask_plot=sig_mask & ~isnan(data0);
step=8;
thin_mask=false(size(sig_mask_plot));
thin_mask(1:step:end, 1:step:end)=true;
stipple_mask=sig_mask & thin_mask;
lon_sig=Lon(stipple_mask);lat_sig=Lat(stipple_mask);
axes('Position', pos_c);
axesm('MapProjection','lambertstd','FontSize', 11,'GLineStyle','--', ...
           'GLineWidth',1.2,'GColor',[.3 .3 .3]);
framem on;axis off;
setm(gca,'MapProjection','braun','origin',[54 10],'FLatLimit',[-19 18],'FLonLimit',[-16 20])
hold on;cb=colorbar('eastoutside');cb.Visible='off';
setm(gca,'FLineWidth',1.2,'Grid','on');tightmap;
hold on;scatterm(lat_sig,lon_sig,5, 'k','filled');






ax2=axes('Position',pos_b);
text(ax2,-0.1,1.1,'b','Units','normalized','FontWeight','bold','FontSize',14.5);
hold on
y=E_annual(:,2);x=2000:2020;
plot(x,y,'-','Color',color_fp,'LineWidth',2,'Marker','.',...
    'MarkerEdgeColor',color_fp*0.92,'MarkerSize',18)
ylabel({'Gg N_{2}O-N/yr'})
set(gca,'FontSize',12,'xtick',2000:5:2020,'Box','on','LineWidth',1.2,'YTick',[120 140])
xlim([1999 2021]);ylim([100 150])
mdl=fitlm(x(:), y(:));
x_fit=linspace(min(x), max(x), 100)';
[y_fit, y_ci]=predict(mdl, x_fit);  % y_ci=95% CI
hold on;
fill([x_fit; flipud(x_fit)],  [y_ci(:,1); flipud(y_ci(:,2))],[0.2 0.2 0.2], 'FaceAlpha', 0.12, 'EdgeColor', 'none');
plot(x_fit, y_fit, '--', 'Color', [0.2 0.2 0.2], 'LineWidth', 2.5);
text(2001,142,'Slope=0.69 Gg N/yr^{2}','FontSize',12,'FontAngle','italic')
text(2003,130,'p < 0.01','FontSize',12,'FontAngle','italic')


ax4=axes('Position', pos_d);
axesm('MapProjection','lambertstd','FontSize', 11,'GLineStyle','--', ...
           'GLineWidth',1.2,'GColor',[.3 .3 .3]);
 framem on;axis off;
 setm(gca,'MapProjection','braun','origin',[54 10],...
     'FLatLimit',[-19 18],'FLonLimit',[-16 20])
geoshow('landareas.shp', 'FaceColor',[0.96 0.95 0.93],'LineWidth',0.77)

data0=trendE_fp(:,:,1)+2;
hold on;hImg=geoshow(data0,R,'DisplayType','surface');
amap=flipud(slanCM('RdBu',256));
colormap(amap([2:2:100,104:4:128,130:2:154,157:256],:));clim([1 4]);
alphaData=~isnan(data);set(hImg, 'AlphaData', alphaData);
cb=colorbar('eastoutside');
cb.Label.String='Slope (Gg N_{2}O-N/yr^{2})';
cb.FontSize=11;cb.Label.FontSize=13;
cb.Ticks=1:4;cb.TickLength=0.02;cb.TickLabels={'-1','0','1','2'};
cb.Visible='off';
setm(gca,'FLineWidth',1.2,'Grid','on')
tightmap;
text(ax4,-0.1,1,'d','Units','normalized','FontWeight','bold','FontSize',14.5);
hold on;text(ax4,1.02,0.84,'60°N','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold on;text(ax4,1.02,0.39,'45°N','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold on;text(ax4,0.15,-0.05,'0°','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold on;text(ax4,0.85,-0.05,'30°E','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);

sig_mask=trendE_fp(:,:,2)<0.05;
[Lon, Lat]=meshgrid(-14.875:0.25:54.875,73.875:-0.25:34.125);
sig_mask_plot=sig_mask & ~isnan(data0);
step=8;
thin_mask=false(size(sig_mask_plot));
thin_mask(1:step:end, 1:step:end)=true;
stipple_mask=sig_mask & thin_mask;
lon_sig=Lon(stipple_mask);lat_sig=Lat(stipple_mask);
axes('Position', pos_d);
axesm('MapProjection','lambertstd','FontSize', 11,'GLineStyle','--', ...
           'GLineWidth',1.2,'GColor',[.3 .3 .3]);
framem on;axis off;
setm(gca,'MapProjection','braun','origin',[54 10],'FLatLimit',[-19 18],'FLonLimit',[-16 20])
hold on;cb=colorbar('eastoutside');cb.Visible='off';
setm(gca,'FLineWidth',1.2,'Grid','on');tightmap;
hold on;scatterm(lat_sig,lon_sig,5, 'k','filled');