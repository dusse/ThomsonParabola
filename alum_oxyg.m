%% Oxygen
angle = 0;

for i = 1:3
    q=i*1.6e-19;%C
    m=(8*(938.2796+939.5653)-16*7.8)*1.782662695946e-30;%kg
    proton_energy_min = 0.1;
    proton_energy_max = 55;
    proton_rest_energy=(8*(938.2796+939.5653)-16*7.8);
    proton_energy_max= 0.6+1.3*i+3.4*i^2;
    [ X,Y ] = getParabola( q,m,proton_energy_min,proton_energy_max,proton_rest_energy,angle );
    plot(Y,X);
    hold on
end
%% Aluminium
angle = 0;
for i = 1:13
    q=i*1.6e-19;%C
    m=(13*(938.2796+939.5653)-26*7.8)*1.782662695946e-30;%kg
    proton_energy_min = 0.1;
    proton_energy_max = 55;
    proton_rest_energy=(13*(938.2796+939.5653)-26*7.8);
    [ X,Y ] = getParabola( q,m,proton_energy_min,proton_energy_max,proton_rest_energy,angle );
    plot(Y,X);
    hold on
end
%%

file = 'sh60';
imdata_for_approx_new = load([file '_rot'],'imdata_for_approx_new');
imdata_for_approx_new=imdata_for_approx_new.imdata_for_approx_new;
x_cent = load([folder file '_x_cent'],'x_cent');x_cent = x_cent.x_cent;
y_cent = load([folder file '_y_cent'],'y_cent');y_cent = y_cent.y_cent;
x_scale = load([folder file '_x_scale'],'x_scale');x_scale = x_scale.x_scale;
y_scale = load([folder file '_y_scale'],'y_scale');y_scale = y_scale.y_scale;
% x_cent = 1491;
% y_cent = 1752;
% x_scale=  0.14221/size(imdata_for_approx_new,2);
% y_scale= 0.06823/size(imdata_for_approx_new,1);
angle = 0;
plotStyle = {'--r','--b','--c','--m','--g','--k'};

imagesc (log(double(imdata_for_approx_new)),[6.9 8.5]);
axis equal
set(gca, 'XLim', [x_cent-50 x_cent+1900 ])
set(gca, 'YLim', [y_cent-1250 y_cent+50 ])
mm_size_x = 5;
mm_size_y = 5;
size_y = mm_size_y/y_scale/1000;
ylim = get(gca,'ylim');
yticks = (round((ylim(1)-y_cent)/size_y)*size_y+y_cent):size_y:(y_cent+round((ylim(2)-y_cent)/size_y)*size_y);
if ylim(1) < yticks(1) && ylim(2) > yticks(end)
    yticks = [ylim(1) yticks ylim(2)];
else
    if ylim(1) > yticks(1) && ylim(2) > yticks(end)
        yticks = [ yticks ylim(2)];
    end
    if  ylim(1) < yticks(1)
        yticks = [ylim(1) yticks ];
    end
end
yTickLabels = cell(1,size(yticks,2));
zero_y_idx =  find(yticks==y_cent);
for i=2:size(yticks,2)-1
    yTickLabels{1,i} = num2str(mm_size_y*(i-zero_y_idx));
end
yTickLabels{1,1} = '';
yTickLabels{1,end} = '';
set(gca,'YTick',yticks)
set(gca,'YTickLabel',yTickLabels)
size_x = mm_size_x/x_scale/1000;
xlim = get(gca,'xlim');
xticks = x_cent:size_x:(x_cent+round((xlim(2)-x_cent)/size_x)*size_x);
if xlim(1) < xticks(1) && xlim(2) > xticks(end)
    xticks = [xlim(1) xticks xlim(2)];
else
    if xlim(1) > xticks(1)
        xticks = [ xticks xlim(2)];
    else
        xticks = [xlim(1) xticks ];
    end
end
xTickLabels = cell(1,size(xticks,2));
xTickLabels{1,1} = '';
xTickLabels{1,end} = '';
for i=2:size(xticks,2)-1
    xTickLabels{1,i} = num2str(mm_size_x*(i-2));
end
set(gca,'FontName','Arial','FontSize',8,'FontWeight','Bold');
set(gca,'XTick',xticks)
set(gca,'XTickLabel',xTickLabels)
hold on
legendIDX = 1;
%%Carbon
for i=1:6
    c_charge = i;
    q=c_charge*1.6e-19;%C
    m=(6*(938.2796+939.5653)-12*7.8)*1.782662695946e-30;%kg
    proton_energy_min = 0.1;
    if c_charge == 1
        proton_energy_max = 5;
    end
    if c_charge == 2
        proton_energy_max = 17;
    end
    if c_charge == 3
        proton_energy_max = 35;
    end
    if c_charge == 4
        proton_energy_max = 60;
    end
    if c_charge == 5
        proton_energy_max = 90;
    end
    if c_charge == 6
        proton_energy_max = 130;
    end
    proton_energy_max= 0.6+1.3*i+3.4*i^2;
    proton_rest_energy=(6*(938.2796+939.5653)-12*7.8);
    [ Y,X ] = getParabola( q,m,proton_energy_min,proton_energy_max,proton_rest_energy,angle );
%     h = plot (X/x_scale+x_cent, Y/y_scale+y_cent, plotStyle{i});
    h = plot (X/x_scale+x_cent, Y/y_scale+y_cent, 'g');
    set(h,'LineWidth',2);
    legendInfo{legendIDX} = ['C' num2str(i) '+'];
    legendIDX=legendIDX+1;
end

%%Oxygen
for i = 1:8
    q=i*1.6e-19;
    m=(8*(938.2796+939.5653)-16*7.8)*1.782662695946e-30;%kg
    proton_energy_min = 0.1;
    proton_energy_max = 55;
    proton_rest_energy=(8*(938.2796+939.5653)-16*7.8);
    proton_energy_max= 0.6+1.3*i+3.4*i^2;
    [ Y,X ] = getParabola( q,m,proton_energy_min,proton_energy_max,proton_rest_energy,angle );
    h = plot (X/x_scale+x_cent, Y/y_scale+y_cent, 'b');
    set(h,'LineWidth',2);
    legendInfo{legendIDX} = ['O' num2str(i) '+'];
    legendIDX=legendIDX+1;
end

%%Aluminium
for i = 1:13
    q=i*1.6e-19;%C
    m=(13*(938.2796+939.5653)-26*7.8)*1.782662695946e-30;%kg
    proton_energy_min = 0.1;
    proton_energy_max = 55;
    proton_energy_max= 0.6+1.3*i+3.4*i^2;
    proton_rest_energy=(13*(938.2796+939.5653)-26*7.8);
    [ Y,X ] = getParabola( q,m,proton_energy_min,proton_energy_max,proton_rest_energy,angle );
    h = plot (X/x_scale+x_cent, Y/y_scale+y_cent, 'r');
    set(h,'LineWidth',2);
    legendInfo{legendIDX} = ['Al' num2str(i) '+'];
    legendIDX=legendIDX+1;
end

q=1.6e-19;%
m=1.7e-27;%kg
proton_energy_min = 0.2;
proton_energy_max = 42;
proton_rest_energy= 938.2796;% MeV
[ Y,X ] = getParabola( q,m,proton_energy_min,proton_energy_max,proton_rest_energy,angle );
plot (X/x_scale+x_cent, Y/y_scale+y_cent, 'k');
plot (x_cent, y_cent, 'r*');
legendInfo{legendIDX} = 'p+';
set(h,'LineWidth',2);

h = get(gca,'xtick');
xTickLabel = arrayfun( @(x) sprintf('%.0f',(x-x_cent)*x_scale*1000), h, 'uniformoutput', false);
set(gca,'xticklabel',xTickLabel);
h = get(gca,'ytick');
yTickLabel = arrayfun( @(y) sprintf('%.0f',-(y-y_cent)*y_scale*1000), h, 'uniformoutput', false);
set(gca,'yticklabel',yTickLabel);
xlabel('mm')
ylabel('mm')
legend(legendInfo);

%% Rotation
imdata_for_approx=imread([file '.tiff']);
imdata_for_approx = imcomplement(imdata_for_approx);
range = [6.9 8.5];
imagesc (log(double(imdata_for_approx)),range);
[x,y]=ginput(2);
alpha = 180/pi*(atan((y(1,1)-y(2,1))/(x(2,1)-x(1,1))));
imdata_for_approx_new = imrotate(imdata_for_approx,-alpha,'bicubic','crop');
figure
imagesc (log(double(imdata_for_approx_new)),range);
save([folder file '_rot'],'imdata_for_approx_new');
%%
file = 'sh60';
imdata_for_approx_new = load([file '_rot'],'imdata_for_approx_new');
imdata_for_approx_new=imdata_for_approx_new.imdata_for_approx_new;
% imdata_for_approx_new = imadjust(imdata_for_approx_new);
% imdata_for_approx_new = histeq(imdata_for_approx_new);
% imdata_for_approx_new  = log(double(imdata_for_approx_new));
% imdata_for_approx_new = imadjust(imdata_for_approx_new,[0 0.2],[0.5 1]);
% imdata_for_approx_new = imadjust(imdata_for_approx_new);
imdata_for_approx_new = imadjust(imdata_for_approx_new,[],[],0.5);
imagesc(imdata_for_approx_new),imcontrast
%%
file = 'sh60';
imdata_for_approx_new = load([file '_rot'],'imdata_for_approx_new');
imdata_for_approx_new = imdata_for_approx_new.imdata_for_approx_new;
imdata_for_approx_new = im2double (imdata_for_approx_new);
imdata_for_approx_new = 1*(log(1+double (imdata_for_approx_new)));
imagesc(imdata_for_approx_new),imcontrast
%%
file = 'sh60';
imdata_for_approx_new = load([file '_rot'],'imdata_for_approx_new');
imdata_for_approx_new = imdata_for_approx_new.imdata_for_approx_new;
imdata_for_approx_new = im2double (imdata_for_approx_new);
m= mean2 (imdata_for_approx_new);
E = 4.0;
imdata_for_approx_new = 1./ (1+(m./ (imdata_for_approx_new+eps)).^E);

imdata_for_approx_new = 1*(log(1+double (imdata_for_approx_new)));
% imdata_for_approx_new = 1*(log(1+double (imdata_for_approx_new)));
imagesc(imdata_for_approx_new),imcontrast

%%



