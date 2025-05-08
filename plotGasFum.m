clear;

dateBeg = datetime(2017,1,1);
dateEnd = datetime(2024,11,19);

% Load gas data
load('data/gas/gas_so2_traverse.mat');
gasDays = gas_dates;
gasVals = gas_so2_trav;
gasErrs = gas_err;
datetimedata = datetime(gasDays,'ConvertFrom','datenum')';
idPlot = datetimedata >= dateBeg & datetimedata < dateEnd;
datetimedata = datetimedata(idPlot);
gasVals = gasVals(idPlot);
gasErrs = gasErrs(idPlot);
datetimeGasTraverse = datetimedata';
dataGasTraverse = gasVals';
errGasTraverse = gasErrs';

% Load fumarole data
load( 'data/fumarole_temps/fumarole_temps.mat' );
datetimedata = datetime(fdatim,'ConvertFrom','datenum')';
idPlot = datetimedata >= dateBeg & datetimedata < dateEnd;
datetimedata = datetimedata(idPlot);
fdata = fdata(idPlot);
datetimeFum = datetimedata';
dataFum = fdata';

% Common dates
datetimeCommon = intersect( datetimeGasTraverse, datetimeFum );

isInGas = ismember(datetimeGasTraverse, datetimeCommon );
isInFum = ismember(datetimeFum, datetimeCommon );

figure;
figure_size( 's' );
plot( gasVals(isInGas), fdata(isInFum), 'ko', 'MarkerFaceColor', 'r' );
axis square;
xlabel( 'SO_{2} flux (tonnes/day)' );
ylabel( 'Average Maximum Fumarole Temperature (^{o}C' );
title( 'Fumarole Temperature v Gas Flux' );

filePlot = "fig--fum_v_gas.png";
saveas( gcf, filePlot );

headers = {'Date','SO2','Fumarole'};
T = table(datetimeCommon, gasVals(isInGas), fdata(isInFum), 'VariableNames', headers);
writetable( T, 'dataGasFum.xlsx');
writetable( T, 'dataGasFum.csv');
