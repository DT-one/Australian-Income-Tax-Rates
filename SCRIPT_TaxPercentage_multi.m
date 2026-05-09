%% Define Study Parameters

study_gross = [70000,110000,170000];
study_date = datenum(2025,09,01);
colours = {'#0072bd','#d95319','#edb120'};

[inf_dates,inf_indexes] = SUB_TaxPercentage(study_date,study_gross(1));

figure

subplot(3,1,1)
plot(inf_dates,inf_indexes,'linewidth',2)
% Make the plot look nice
set(gca, 'XTick', datenum(1995:5:2025,1,1));
datetick('x', 'yyyy','keepticks')
xlim([datenum(1991,1,1),datenum(2025,12,1)])
grid 'on'
grid 'minor'
xlabel('Year')
ylabel('CPI [index]')
title('Inflation - CPI, Melbourne - Jan 1991 to Dec 2025')

subplot(3,1,2)
hold on
legend_arry = {};
for ii = 1:numel(study_gross)
  study_gross(ii)
  [~,~,inf_net_vect,inf_gross_vect] = SUB_TaxPercentage(study_date,study_gross(ii));
  plot(inf_dates,inf_gross_vect./1000,'linewidth',2,'color',colours{ii})
  plot(inf_dates,inf_net_vect./1000,'linewidth',2,'--','color',colours{ii})
  legend_arry{end+1} = ['Gross - $',num2str(study_gross(ii)),' pa.'];
  legend_arry{end+1} = ['Net'];
end
% Make the plot look nice
set(gca, 'XTick', datenum(1995:5:2025,1,1));
datetick('x', 'yyyy','keepticks')
xlim([datenum(1991,1,1),datenum(2025,12,1)])
ylims = ylim();
ylim([0,ylims(end)])
grid 'on'
grid 'minor'
xlabel('Year')
ylabel('Yearly Income [$1000 AUD]')
title('Gross & Net Wages, Net adjusted by CPI, Gross back-calculated - Base Date Sep 2025')
legend(legend_arry,'location','north','Orientation', 'horizontal')



subplot(3,1,3)
hold on
for ii = 1:numel(study_gross)
  [~,~,inf_net_vect,inf_gross_vect] = SUB_TaxPercentage(study_date,study_gross(ii));
  % Calculate percentage of the income tax take
  tax_pct = 1-(inf_net_vect./inf_gross_vect);
  tax_pct = tax_pct.*100;
  plot(inf_dates,tax_pct,'linewidth',2)
end
% Make the plot look nice
set(gca, 'XTick', datenum(1995:5:2025,1,1));
datetick('x', 'yyyy','keepticks')
xlim([datenum(1991,1,1),datenum(2025,12,1)])
ylims = ylim();
ylim([0,50])
grid 'on'
grid 'minor'
xlabel('Year')
ylabel('Tax Take [%]')
title('Income Tax Take - % of Gross Income')

