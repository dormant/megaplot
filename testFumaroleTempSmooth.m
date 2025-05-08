clear;
setup = setupGlobals();

dateBeg = datenum( 2012, 1, 1 );
dateEnd = datenum( 2025, 1, 1 );


% ============================== Load fumarole temperature data
load( 'data/fumarole_temps/fumarole_temps.mat' );
datimFum = fdatim;
dataFum = fdata;


figure;
figure_size( 'p' );
tiledlayout('vertical');


colourFum = 'm';
markerSize = 6;
nexttile;
plot( datimFum, dataFum, 'o', 'MarkerEdgeColor', colourFum, 'MarkerFaceColor', colourFum, 'MarkerSize', markerSize );
xlim( [dateBeg dateEnd] );
ylim( [200 600] );
datetick('x', 'keeplimits' );
title( 'Raw data' );

nexttile;
nrmean = 7;
dataFumM = movmean( dataFum, nrmean);
plot( datimFum, dataFumM, 'o', 'MarkerEdgeColor', colourFum, 'MarkerFaceColor', colourFum, 'MarkerSize', markerSize );
xlim( [dateBeg dateEnd] );
ylim( [200 600] );
datetick('x', 'keeplimits' );
title( sprintf( "%d-point running mean", nrmean) );

nexttile;
tJump = 28;
datetimeFum = datetime( datimFum, 'ConvertFrom', 'datenum' );
[datetimeFumM, dataFumM] = meanJumps( datetimeFum, dataFum, tJump );
datimFumM = datenum( datetimeFumM );
plot( datimFumM, dataFumM, 'o', 'MarkerEdgeColor', colourFum, 'MarkerFaceColor', colourFum, 'MarkerSize', markerSize );
xlim( [dateBeg dateEnd] );
ylim( [200 600] );
datetick('x', 'keeplimits' );
title( sprintf( "%d-day mean value", tJump) );

nexttile;
dataFumM = nan( size(dataFum) );
for i = 1:length(dataFum)
    dataFumM(i) = mean(dataFum(1:i));
end
plot( datimFum, dataFumM, 'o', 'MarkerEdgeColor', colourFum, 'MarkerFaceColor', colourFum, 'MarkerSize', markerSize );
xlim( [dateBeg dateEnd] );
ylim( [200 600] );
title( "LTA" );

nexttile;
%plot( datimFum, dataFum, 'k.' );
hold on;

for degFit = 3:2:7
    p = polyfit(datimFum,dataFum,degFit);
    y1 = polyval(p,datimFum);
    plot(datimFum,y1,'-');
end
lgd = legend( {"3", "5", "7"}, 'Location', 'northeast' );
title(lgd,'Degree')
xlim( [dateBeg dateEnd] );
ylim( [200 600] );
datetick('x', 'keeplimits' );
title( 'Polynomial fits' );

plotOverTitle( 'Average Maximum Fumarole Temperature (^{o}C)' );