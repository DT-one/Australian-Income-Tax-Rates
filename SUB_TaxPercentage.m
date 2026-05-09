function [inf_dates,inf_indexes,inf_net_vect,inf_gross_vect] = SUB_TaxPercentage(study_date,study_gross)

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

end
