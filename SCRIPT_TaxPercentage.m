%% Define Study Parameters

study_gross = 100000;
study_date = datenum(2025,09,01);

%% Load Data

% Import CPI inflation data
[inf_dates,inf_indexes] = textread('Melbourne_Inflation.csv','%u,%f');
% Convert from excel to MATLAB datenum
inf_dates = dateConv(inf_dates);

%% Perform Calculations

% CPI Index data for the study point
inf_idx = find(inf_dates >= study_date,1);
if isempty(inf_idx)
    inf_idx = numel(inf_dates);
end
% Find the CPI index at the study date
inf_study_idx = inf_indexes(inf_idx);

% Calculate after-tax earnings at the study point
inf_study_net = aust_tax_gross2net(study_gross,study_date);

% Find real historic after tax earnings By scaling to CPI
% Use CPI time series and the CPI index at the study date to scale net earnings
inf_net_vect = (inf_study_net/inf_study_idx).*inf_indexes;
% Back calculate gross earnings using historic income tax brackets
inf_gross_vect = arrayfun(@(x,y)aust_tax_net2gross(x,y),inf_net_vect,inf_dates);

% Calculate percentage of the income tax take
tax_pct = 1-(inf_net_vect./inf_gross_vect);
tax_pct = tax_pct.*100;

figure

subplot(3,1,1)
plot(inf_dates,inf_indexes,'linewidth',2)
% Make the plot look nice
datetick('x', 'yyyy')
xlim([datenum(1997,1,1),datenum(2025,12,1)])
grid 'on'
grid 'minor'
xlabel('Year')
ylabel('CPI [index]')
title('Inflation - CPI, Melbourne')

subplot(3,1,2)
plot(inf_dates,inf_gross_vect./1000,'linewidth',2,'color','#0072bd')
hold on
plot(inf_dates,inf_net_vect./1000,'linewidth',2,'.','color','#0072bd')

plot(study_date * [1,1],[study_gross,inf_study_net]/1000,'ko','MarkerFaceColor',[1,1,1])

% Make the plot look nice
datetick('x', 'yyyy')
xlim([datenum(1997,1,1),datenum(2025,12,1)])
ylims = ylim();
ylim([0,ylims(end)])
grid 'on'
grid 'minor'
xlabel('Year')
ylabel('Yearly Income [$1000 AUD]')
title('Real wages over time')


subplot(3,1,3)
plot(inf_dates,tax_pct,'linewidth',2)
% Make the plot look nice
datetick('x', 'yyyy')
xlim([datenum(1997,1,1),datenum(2025,12,1)])
ylims = ylim();
ylim([0,50])
grid 'on'
grid 'minor'
xlabel('Year')
ylabel('Income Tax Take [% of gross income]')
title('Tax Take')

