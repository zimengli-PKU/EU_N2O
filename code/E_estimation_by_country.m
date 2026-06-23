%%
E_tot_annual(:,:,:,1)=E_GS_annual;
E_tot_annual(:,:,:,2)=E_FP_annual;
E_tot_annual=tsnansum(E_tot_annual,4);
E_tot=tsnanmean(E_tot_annual,3);

%%
country_mask=imread('Europe_country_0p25deg.tif');
country_maskls=unique(country_mask);country_maskls=country_maskls(country_maskls>0);
country_E=nan(43,21);
for i=1:43
    for j=1:21
        etmp=E_tot_annual(:,:,j);
tmp=etmp(country_mask==country_maskls(i));
country_E(i,j)=sum(tmp,'all');
    end
end
%%
pos_a=[0.1 0.55 0.42 0.4];pos_b=[0.15 0.05 0.35 0.45];
pos_c=[0.65 0.1 0.3 0.85];

figure('Position',[100 100 900 700]);
ax1=axes('Position',pos_a);
text(ax1,-0.15,1.05,'a','Units','normalized','FontWeight','bold','FontSize',14.5);
hold on
axesm('MapProjection','lambertstd','FontSize', 11,'GLineStyle','--', ...
           'GLineWidth',1.2,'GColor',[.3 .3 .3]);
 framem on;axis off;
 setm(gca,'MapProjection','braun','origin',[54 10],...
     'FLatLimit',[-19 18],'FLonLimit',[-16 20])
geoshow('landareas.shp', 'FaceColor',[0.96 0.95 0.93],'LineWidth',0.77)

data0=E_tot*1000;data0(data0==0)=nan;
hold on;hImg=geoshow(data0,R,'DisplayType','surface');
amap=flipud(slanCM('spectral',256));
colormap(ax1,amap);clim([0 130]);
alphaData=~isnan(data0);set(hImg, 'AlphaData', alphaData);
cb=colorbar(ax1,'eastoutside');
cb.Label.String='Gridded N_2O emission (t N/yr)';
cb.FontSize=12;cb.Label.FontSize=13;cb.LineWidth=0.77;
cb.Ticks=0:30:120;cb.TickLength=0.02;cb.TickLabels={'0','30','60','90','120'};

setm(gca,'FLineWidth',1.2,'Grid','on')
tightmap;
hold on;text(ax1,-0.15,0.8,'60°N','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold on;text(ax1,-0.15,0.35,'45°N','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold on;text(ax1,0.15,-0.05,'0°','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold on;text(ax1,0.85,-0.05,'30°E','Units','normalized','FontSize',12,'Color',[.3 .3 .3]/2);
hold off;

ax2=axes('Position',pos_b);
text(ax2,-0.2,1.1,'b','Units','normalized','FontWeight','bold','FontSize',14.5);
hold(ax2,'on');

T=readtable('inventory_emissions_country.xlsx','Sheet',1,'VariableNamingRule','preserve');
year=T{:,1};data=T{:,2:end};
varNames=T.Properties.VariableNames(2:end);
varNames{6}='This study';

nVar=size(data,2);
colors=colormap(ax2,lines(256))*0.66;
colors(2,:)=[219 128 169]/255;
colors(nVar,:)=[0.7392 0.1529 0.1569]*0.88;

hx1=xline(2000:5:2020,'LineWidth',1,'Color',[0.8 0.8 0.8],'LineStyle','--');
for i=1:5
hx1(i).HandleVisibility='off';
end

ax=gca;
ax.LineWidth=1.2;
for i=1:nVar
    y=data(:,i);  
    plot(year, y, '-', 'Color',colors(i,:), 'LineWidth', 2.5);
end
hold on;
x =year(:);  y =y(:);  sd=varlist(:); 
y_lower=y - sd;
y_upper=y + sd;

hold on;
fill([x; flipud(x)],  [y_lower; flipud(y_upper)], ...
     colors(i,:), 'FaceAlpha', 0.15, ...
     'EdgeColor', 'none', 'HandleVisibility','off');   % 不进 legend
plot(x, y, '-', 'Color', colors(i,:), 'LineWidth', 4);

ax.Box='on';ax.FontName='Arial';
ax.FontSize=12;
ax.TickDir='in';ax.TickLength=[0.015 0.015];

xlim([1999 2021]);ylim([150 550])
xticks([2000 2005 2010 2015 2020])
yticks(100:100:600)
ylabel('Cropland N_2O emission (Gg N_2O-N/yr)','FontSize',14);
set(gca,'FontSize',13)
legend(varNames, 'Location','north', 'FontSize',12.5, 'Box','off','NumColumns',2);



ax3=axes('Position',pos_c);
text(ax3,-0.15,1.02,'c','Units','normalized','FontWeight','bold','FontSize',14.5);
hold(ax3,'on');
T_ord=readtable("inventory_emissions_country.xlsx",'Sheet',1,'VariableNamingRule','preserve');
y=1:45;x=T_ord.our;
colors=readtable("inventory_emissions_country.xlsx",'Sheet',2,'VariableNamingRule','preserve');
colors=table2array(colors(:,2:4));
for i=1:37
    line([0 x(i)], [y(i) y(i)], 'Color', colors(i,:),'linewidth',2); % stem杆
end
hold on;
scatter(x,y, 70,colors, 'filled'); % 点
set(gca,'YDir','reverse','FontSize',12,'YTickLabel',T_ord.Var1,...
    'YTick',1:37,'box','on','LineWidth',1.2,'TickLength',[0.005 0.005])

ylim([0 37.5]);xlim([0 80]);xlabel('N_2O emission (Gg N_2O-N/yr)','FontSize',14)

hx2=yline(5:5:30,'LineWidth',1,'Color',[0.8 0.8 0.8],'LineStyle','--');
for i=1:5
hx2(i).HandleVisibility='off';
end

x0=T_ord.mean;  x0= x0(:); y0 =y(:);  sd=T_ord.std;

hold on;
fill([x0-sd; flipud(x0+sd)],  [y0;flipud(y0)], ...
     [.5 .5 .5]*1.5, 'FaceAlpha', 0.1, ...
     'EdgeColor', [.77 .77 .77], 'HandleVisibility','off',...
     'LineStyle','--','LineWidth',1.5);


ax4=axes('Position',[0.745 0.1 0.2 0.4],'Color','none');hold(ax4,'on');

h=imagesc(lon, lat, country_raster);
alphaData=country_raster ~= 0;

set(h, 'AlphaData', alphaData);
set(gca,'xtick',[],'ytick',[],'box','off','XColor','none','YColor','none')
hold on;
geoshow(S,'DisplayType','polygon','LineWidth',0.77,'FaceAlpha',0,'EdgeColor',[1 1 1]*0.5)
geoshow(coastlat,coastlon,'Color',[1 1 1]*0.3,'LineWidth',0.77)
xlim([-13 41]);ylim([34 72])
set(gca,'YDir','normal','FontSize',12)
colorbar('off');
amap=othercolor('Set312')*0.88;
p_trans=ones(256,3);
amap=amap+p_trans*0.1;
aamap=[1,1,1;amap(1:5:256,:)];
aamap(6,:)=[1,1,1];aamap([7,25,31,34],:)=aamap([34,7,25,31],:);
colormap(ax4,aamap)

